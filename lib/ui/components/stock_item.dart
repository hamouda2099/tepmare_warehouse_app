import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/models/stock_model.dart';

import 'barcode_service.dart';

class StockItem extends StatelessWidget {
  StockItem(this.stock);

  Stock stock;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock.designation ?? "",
                      style: const TextStyle(
                        color: kGreyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      stock.sku ?? "",
                      style: const TextStyle(
                        color: kGreyColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${"QTY: ".tr()}${stock.qty?.toString() ?? ""}",
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                20.w,
                SizedBox(
                  width: 100,
                  child: BarcodeService(Barcode.code128())
                      .buildBarcode(stock.location ?? ""),
                )
              ],
            ),
          ),
          10.h,
          const Divider()
        ],
      ),
    );
  }
}
