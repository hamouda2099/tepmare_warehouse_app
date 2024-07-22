import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/ui/components/secondary_app_bar.dart';

import '../../config/date_formatter.dart';
import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../logic/services/api_manager.dart';
import '../../models/locations_model.dart';
import '../../models/shipment_details_model.dart';
import '../listing_dialogs/locations_dialog/locations_dialog.dart';

class ShipmentDetails extends StatelessWidget {
  ShipmentDetails(this.shipmentId);
  String shipmentId;
  TextEditingController searchCnt = TextEditingController();
  Shipment? shipment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SecondaryAppBar("Shipment Details".tr()),
              20.h,
              FutureBuilder<ShipmentDetailsModel>(
                future: ApiManager.getShipmentDetails(shipmentId: shipmentId),
                builder: (BuildContext context,
                    AsyncSnapshot<ShipmentDetailsModel> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return const CircularProgressIndicator();
                      }
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error.toString()}');
                      } else {
                        shipment = snapshot.data?.shipment;
                        return Expanded(
                          child: ListView(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black.withOpacity(.8),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    dateFormatter(shipment?.createdAt ?? ""),
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.8)),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    decoration: BoxDecoration(
                                      color: kGreenColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      shipment?.status ?? "",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    decoration: BoxDecoration(
                                      color: kSecondaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      shipment?.type ?? "",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
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
                                        "N' appro Client".tr(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Text(
                                    shipment?.nDApproClient ?? "",
                                    style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              10.h,
                              Row(
                                children: [
                                  SizedBox(
                                      width: screenWidth / 3,
                                      child: Text(
                                        "N'Container".tr(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Text(
                                    shipment?.container ?? "",
                                    style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              10.h,
                              Row(
                                children: [
                                  SizedBox(
                                      width: screenWidth / 3,
                                      child: Text(
                                        "Description",
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Text(
                                    shipment?.description ?? "",
                                    style: const TextStyle(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              10.h,
                              Row(
                                children: [
                                  SizedBox(
                                      width: screenWidth / 3,
                                      child: Text(
                                        "Arrival Date".tr(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Text(
                                    shipment?.arrivalDate?.toString() ?? "",
                                    style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              20.h,
                              Text(
                                "${shipment?.client?.firstName ?? ""} ${shipment?.client?.lastName ?? ""}",
                                style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                shipment?.client?.companyName ?? "",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold),
                              ),
                              20.h,
                              Row(
                                children: [
                                  SizedBox(
                                      width: screenWidth / 3,
                                      child: Text(
                                        "Username".tr(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Text(
                                    shipment?.client?.username ?? "",
                                    style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              10.h,
                              Row(
                                children: [
                                  SizedBox(
                                      width: screenWidth / 3,
                                      child: Text(
                                        "Email".tr(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Text(
                                    shipment?.client?.email ?? "",
                                    style: const TextStyle(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              10.h,
                              Row(
                                children: [
                                  SizedBox(
                                      width: screenWidth / 3,
                                      child: Text(
                                        "Mobile".tr(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Text(
                                    shipment?.client?.fax ?? "",
                                    style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              10.h,
                              Row(
                                children: [
                                  SizedBox(
                                      width: screenWidth / 3,
                                      child: Text(
                                        "Fax".tr(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Text(
                                    shipment?.client?.fax ?? "",
                                    style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              10.h,
                              Row(
                                children: [
                                  SizedBox(
                                      width: screenWidth / 3,
                                      child: Text(
                                        "Website".tr(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  const Text(
                                    "www.compnyname.com",
                                    style: TextStyle(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              30.h,
                              Text(
                                "Address".tr(),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Country, State, Street , Villa",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "332367",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold),
                              ),
                              30.h,
                              Text(
                                "Delivery Address".tr(),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Country, State, Street , Villa",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "332367",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold),
                              ),
                              shipment?.status == "preparing"
                                  ? InkWell(
                                      onTap: () {
                                        Dialogs().loadingDialog(context);
                                        ApiManager.completeShipment(
                                                shipmentId: shipmentId)
                                            .then((value) {
                                          Navigator.pop(context);
                                          if (value['statusCode'] == 200) {
                                            navigator(
                                                context: context,
                                                screen:
                                                    ShipmentDetails(shipmentId),
                                                replacement: true);
                                          } else {
                                            Dialogs().messageDialog(context,
                                                value['message'] ?? "");
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: screenWidth / 1.2,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                          color: kGreenColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child:  Text(
                                          "Complete".tr(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(
                                      width: 80,
                                    ),
                              20.h,
                               Text(
                                "Items".tr(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              5.h,
                              Container(
                                width: screenWidth,
                                height: 2,
                                color: Colors.black,
                              ),
                              Column(
                                children: List.generate(
                                    shipment?.items?.length ?? 0,
                                    (index) =>
                                        ItemRow(shipment?.items?[index])),
                              )
                            ],
                          ),
                        );
                      }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemRow extends ConsumerWidget {
  ItemRow(this.item);

  Item? item;
  TextEditingController controller = TextEditingController();
  final locationProvider = StateProvider<Location?>((ref) => null);
  final locationBarcodeProvider = StateProvider<String?>((ref) => null);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(locationProvider);
    ref.watch(locationBarcodeProvider);
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item?.designation ?? "",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                  width: 60,
                  child: item?.receivedQty == null
                      ? InkWell(
                          onTap: () {
                            Dialogs().loadingDialog(context);
                            ApiManager.receiveItem(
                                    itemId: item?.id?.toString() ?? "",
                                    shipmentId:
                                        item?.shipmentId?.toString() ?? "",
                                    locationId: ref
                                            .read(locationProvider.notifier)
                                            .state
                                            ?.id
                                            ?.toString() ??
                                        "",
                                    qty: controller.text)
                                .then((value) {
                              Navigator.pop(context);
                              if (value['statusCode'] == 200) {
                                navigator(
                                  context: context,
                                  screen: ShipmentDetails(
                                      item?.shipmentId?.toString() ?? ""),
                                  replacement: true,
                                );
                              } else {
                                Dialogs().messageDialog(
                                    context, value['message'] ?? "");
                              }
                            });
                          },
                          child: const Icon(
                            Icons.done_outline,
                            color: kGreenColor,
                          ),
                        )
                      : null)
            ],
          ),
          10.h,
          Row(
            children: [
               Text(
                "Reported QTY: ".tr(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                item?.reportedQty?.toString() ?? "",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          10.h,
          Row(
            children: [
               Text(
                "Received QTY: ".tr(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              item?.receivedQty == null
                  ? Container(
                      width: screenWidth / 4,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: kPrimaryColor.withOpacity(0.3), width: 1)),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: controller,
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          hintText: "Enter Qty".tr(),
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                      ))
                  : Align(
                      alignment: Alignment.center,
                      child: Text(
                        item?.receivedQty?.toString() ?? "",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
          Row(
            children: [
               Text(
                "Location: ".tr(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  if (item?.locationId == null) {
                    LocationsListDialog().show(context).then((value) {
                      if (value != null) {
                        ref.read(locationBarcodeProvider.notifier).state =
                            value.barcode;
                        ref.read(locationProvider.notifier).state = value;
                      }
                    });
                  }
                },
                child: Text(
                  item?.locationId?.toString() ??
                      ref.read(locationProvider.notifier).state?.barcode ??
                      "Select Location".tr(),
                  style: TextStyle(
                      color: item?.locationId == null
                          ? kSecondaryColor
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
