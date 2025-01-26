import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/models/items_model.dart';
import 'package:tepmare_warehouse_man_app/ui/components/secondary_app_bar.dart';

import '../components/barcode_service.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails({required this.item});
  Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SecondaryAppBar("Item Details".tr()),
              10.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.designation ?? "",
                        style: const TextStyle(
                          color: kGreyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "${item.client?.firstName ?? ""} ${item.client?.lastName ?? ""}",
                        style: const TextStyle(
                          color: kGreyColor,
                          fontSize: 14,
                        ),
                      ),
                      40.h,
                      Text(
                        "Description".tr(),
                        style: const TextStyle(
                          color: kGreyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        item.description ?? "",
                        style: const TextStyle(
                          color: kGreyColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: screenWidth / 2.5,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Stock".tr(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item.stock.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        10.h,
                        const Divider(
                          color: Colors.white,
                        ),
                        10.h,
                        Text(
                          item.type ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        10.h,
                        const Divider(
                          color: Colors.white,
                          height: 10,
                          thickness: 2,
                        ),
                        10.h,
                        Text(
                          item.category ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        10.h,
                      ],
                    ),
                  )
                ],
              ),
              20.h,
              Row(
                children: [
                  SizedBox(
                      width: screenWidth / 3,
                      child: Text(
                        "SKU".tr(),
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                  Text(
                    item.sku ?? "",
                    style: const TextStyle(
                      color: kGreyColor,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              10.h,
              Row(
                children: [
                  SizedBox(
                      width: screenWidth / 3,
                      child: Text(
                        "Barcode".tr(),
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                  Text(
                    item.barcode ?? "",
                    style: const TextStyle(
                      color: kGreyColor,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              10.h,
              Row(
                children: [
                  SizedBox(
                      width: screenWidth / 3,
                      child: Text(
                        "Width".tr(),
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                  Text(
                    item.height?.toString() ?? "",
                    style: const TextStyle(
                      color: kGreyColor,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              10.h,
              Row(
                children: [
                  SizedBox(
                      width: screenWidth / 3,
                      child: Text(
                        "Height".tr(),
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                  Text(
                    item.height?.toString() ?? "",
                    style: const TextStyle(
                      color: kGreyColor,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              10.h,
              Row(
                children: [
                  SizedBox(
                      width: screenWidth / 3,
                      child: Text(
                        "Depth".tr(),
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                  Text(
                    item.depth?.toString() ?? "",
                    style: const TextStyle(
                      color: kGreyColor,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              10.h,
              Row(
                children: [
                  SizedBox(
                      width: screenWidth / 3,
                      child: Text(
                        "Weight".tr(),
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                  Text(
                    item.weight?.toString() ?? "",
                    style: const TextStyle(
                      color: kGreyColor,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              40.h,
              SizedBox(
                width: screenWidth / 2,
                child: BarcodeService(Barcode.code128())
                    .buildBarcode(item.barcode ?? ""),
              )
            ],
          ),
        ),
      ),
    );
  }
}
