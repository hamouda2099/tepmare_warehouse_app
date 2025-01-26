import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BarcodeService {
  BarcodeService(this.barcode);

  Barcode barcode;
  final GlobalKey _barcodeKey = GlobalKey();

  Widget buildBarcode(String data) {
    return RepaintBoundary(
      key: _barcodeKey,
      child: BarcodeWidget(
        width: 150,
        height: 40,
        data: data,
        barcode: barcode,
        errorBuilder: (context, error) => Center(
          child: Text(
            "Invalid EAN 13 Barcode".tr(),
          ),
        ),
      ),
    );
  }
}
