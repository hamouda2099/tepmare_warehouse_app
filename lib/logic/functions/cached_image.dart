import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/logic/services/cache_manager.dart';

import '../../config/constants.dart';
import 'image_converter.dart';

class CachedImage extends StatefulWidget {
  CachedImage({
    required this.url,
    this.fit,
    this.width,
    this.height,
    this.borderRadius,
    this.boxShape,
    this.borderColor,
  });

  String? url;
  double? width, height;
  BoxFit? fit;
  BorderRadius? borderRadius;
  BoxShape? boxShape;
  Color? borderColor;

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  bool loading = true;
  String? imageBase64;
  Uint8List? decodedImg;

  Future<void> init() async {
    if (mounted && widget.url == "http://api.sharedriveapp.com-") {
      setState(() {
        loading = false;
      });
      return;
    }

    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    if (widget.url == null || (widget.url?.isEmpty ?? true)) {
      imageBase64 = null;
    } else {
      imageBase64 = CacheManager.getCachedImage(widget.url!);
      if (imageBase64?.isEmpty ?? true) {
        imageBase64 = null;
      }
      if (imageBase64 == null) {
        try {
          imageBase64 = await ImageConverter().urlToBase64(widget.url!);
          if (imageBase64 != null) {
            CacheManager.setCachedImage(widget.url!, imageBase64);
          }
        } catch (_) {}
      }
      if (imageBase64 != null) {
        try {
          decodedImg = base64Decode(imageBase64 ?? '');
        } catch (_) {}
      }
    }
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            )
          : Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: widget.borderColor ?? Colors.transparent,
                ),
                borderRadius:
                    widget.boxShape == null ? widget.borderRadius : null,
                shape: widget.boxShape ?? BoxShape.rectangle,
                image: decodedImg == null
                    ? DecorationImage(
                        image: const AssetImage(
                          'assets/images/app_logo.png',
                        ),
                        fit: widget.fit ?? BoxFit.contain,
                      )
                    : DecorationImage(
                        image: MemoryImage(decodedImg!),
                        fit: widget.fit ?? BoxFit.contain,
                      ),
              ),
            ),
    );
  }
}
