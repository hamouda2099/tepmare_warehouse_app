import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ImageConverter {
  String fileToBase64(File image) {
    return base64Encode(File(image.path).readAsBytesSync());
  }

  Future<String?> urlToBase64(String url) async {
    http.Response response;
    try {
      response = await http.get(Uri.parse(url));
    } catch (_) {
      return null;
    }
    if (response.statusCode == 200) {
      try {
        final bytes = response.bodyBytes;
        return bytes != null ? base64Encode(bytes) : null;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<File> urlToFile(String url) async {
    final response = await http.get(Uri.parse(url));

    Directory documentDirectory =
        await path_provider.getApplicationDocumentsDirectory();

    File file = Platform.isIOS
        ? File(join(
            documentDirectory.path.replaceAll('file:///', ''), 'imagetest.png'))
        : File(join(documentDirectory.path, 'imagetest.png'));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }
}
