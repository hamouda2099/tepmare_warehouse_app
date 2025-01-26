import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/main.dart';
import 'package:tepmare_warehouse_man_app/ui/components/secondary_app_bar.dart';

import '../../config/date_formatter.dart';
import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../dialogs/receive_item_dialog.dart';
import '../../logic/services/api_manager.dart';
import '../../models/locations_model.dart';
import '../../models/shipment_details_model.dart';
import '../components/barcode_service.dart';

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
                                  Text(
                                    shipment?.client?.webSite ?? "",
                                    style: const TextStyle(
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
                              Text(
                                "${shipment?.client?.address}",
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${shipment?.client?.postalCode}",
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
                              Text(
                                shipment?.client?.deliveryAddress ?? "",
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                shipment?.client?.deliveryPostalCode ?? "",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold),
                              ),
                              shipment?.status == "pending" &&
                                      shipment?.type == 'exit'
                                  ? InkWell(
                                      onTap: () {
                                        Dialogs().loadingDialog(context);
                                        ApiManager.deliverShipment(
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
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        decoration: BoxDecoration(
                                          color: kGreenColor,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          "Deliver".tr(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(
                                      width: 80,
                                    ),
                              20.h,
                              Text(
                                "Items".tr(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                    (index) => ItemRow(shipment?.items?[index],
                                        shipment?.type ?? "")),
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
  ItemRow(this.item, this.shipmentType);

  Item? item;
  String? shipmentType;
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
        borderRadius: BorderRadius.circular(15),
      ),
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                  bottom: 5,
                ),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item?.type?.toString() ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          10.h,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reported QTY: ".tr(),
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                item?.reportedQty?.toString() ?? "",
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          10.h,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Received QTY: ".tr(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                item?.receivedQty?.toString() ?? "",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          10.h,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Location: ".tr(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              shipmentType == 'exit'
                  ? BarcodeService(Barcode.code128())
                      .buildBarcode(item?.location ?? "")
                  : (item?.locations?.length == 1)
                      ? BarcodeService(Barcode.code128())
                          .buildBarcode(item?.locations?[0] ?? "")
                      : InkWell(
                          onTap: () {
                            showItemLocations(
                              context,
                              item?.locations,
                            );
                          },
                          child: const Icon(
                            Icons.list_alt_rounded,
                            color: kPrimaryColor,
                          ),
                        ),
            ],
          ),
          10.h,
          shipmentType == 'exit'
              ? const SizedBox(
                  width: 100,
                )
              : item?.receivedQty == null
                  ? InkWell(
                      onTap: () {
                        ReceiveItem.locationsWidgets = [];
                        ReceiveItem.locations = [];
                        ReceiveItem()
                            .receiveItem(context, item: item)
                            .then((locations) {
                          Dialogs().loadingDialog(globalKey.currentContext!);
                          ApiManager.receiveItem(
                                  id: item?.id.toString() ?? "",
                                  itemId: item?.itemId?.toString() ?? "",
                                  shipmentId:
                                      item?.shipmentId?.toString() ?? "",
                                  locations: locations)
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
                                context,
                                value['message'],
                              );
                            }
                          });
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Receive Item",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    )
                  : 0.w
        ],
      ),
    );
  }
}

showItemLocations(BuildContext context, List? locations) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Item Locations".tr(),
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  )),
            ],
          ),
          content: SizedBox(
            width: screenWidth / 1.5,
            height: screenHeight / 2,
            child: ListView.builder(
                itemCount: locations?.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: BarcodeService(
                      Barcode.code128(),
                    ).buildBarcode(locations?[index] ?? ""),
                  );
                }),
          ),
        );
      });
}
