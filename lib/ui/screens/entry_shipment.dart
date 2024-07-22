import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/dialogs/basic_dialogs.dart';
import 'package:tepmare_warehouse_man_app/logic/uiLogic/entry_shipment_logic.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/entry_shipment_items_dialog.dart';

import '../../config/constants.dart';
import '../../logic/functions/date_picker.dart';
import '../../logic/services/api_manager.dart';
import '../components/custom_text_field.dart';
import '../components/secondary_app_bar.dart';
import '../listing_dialogs/clients/clients_dialog.dart';
import '../paginations/entry_shipments_client_items_pagination.dart';

class EntryShipment extends ConsumerWidget {
  EntryShipmentLogic logic = EntryShipmentLogic();
  PageController controller = PageController();
  TextEditingController searchCnt = TextEditingController();
  final refreshReBuilder = StateProvider<String?>((ref) => null);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    logic.context = context;
    logic.ref = ref;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SecondaryAppBar("Entry Shipment".tr()),
              40.h,
              Form(
                key: logic.formKey,
                child: Expanded(
                  child: PageView(
                    controller: controller,
                    children: [
                      ListView(
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              ref.watch(logic.clientProvider);
                              ref.watch(logic.clientNameProvider);
                              return Container(
                                height: 45,
                                width: screenWidth / 1.2,
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(ref
                                            .read(logic
                                            .clientProvider.notifier)
                                            .state
                                            ?.username ??
                                            "Select Client".tr()),
                                        InkWell(
                                          onTap: () {
                                            ClientsListDialog()
                                                .show(context)
                                                .then((value) {
                                              if (value != null) {
                                                ref
                                                    .read(logic.clientProvider
                                                    .notifier)
                                                    .state = value;
                                                ref
                                                    .read(logic
                                                    .clientNameProvider
                                                    .notifier)
                                                    .state = value.username;
                                              }
                                            });
                                          },
                                          child: Image.asset(
                                            "assets/images/clients.png",
                                            width: 20,
                                            height: 20,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    5.h,
                                    const Divider()
                                  ],
                                ),
                              );
                            },
                          ),
                          20.h,
                          Container(
                              height: 45,
                              width: screenWidth / 1.2,
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              child: Consumer(
                                builder: (context, ref, child) {
                                  ref.watch(logic.arrivalDateProvider);
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(ref
                                              .read(logic
                                              .arrivalDateProvider
                                              .notifier)
                                              .state ??
                                              "Arrival Date".tr()),
                                          InkWell(
                                            onTap: () {
                                              datePicker(context)
                                                  .then((value) {
                                                ref
                                                    .read(logic
                                                    .arrivalDateProvider
                                                    .notifier)
                                                    .state = value;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.edit_calendar_outlined,
                                              color: kPrimaryColor,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider()
                                    ],
                                  );
                                },
                              )),
                          CustomTextField(
                            controller: logic.containerCnt,
                            hint: "Container".tr(),
                          ),
                          10.h,
                          CustomTextField(
                            controller: logic.descriptionCnt,
                            hint: "Description".tr(),
                          ),
                          50.h,
                          InkWell(
                            onTap: () {
                              controller.animateToPage(1,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeIn);
                            },
                            child: Container(
                              width: screenWidth / 1.3,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                              ),
                              decoration: BoxDecoration(
                                color:  kPrimaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:  Text(
                               "Next".tr(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Items".tr(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                " |",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  width: screenWidth / 2,
                                  child: TextField(
                                    controller: searchCnt,
                                    onChanged: (val) {
                                      ref
                                          .read(refreshReBuilder.notifier)
                                          .state = DateTime.now().toString();
                                    },
                                    decoration:  InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: "Search".tr(),
                                        hintStyle: TextStyle(fontSize: 14)),
                                  )),
                              InkWell(
                                  onTap: () async{

                                    String barcodeScanRes;
                                    // Platform messages may fail, so we use a try/catch PlatformException.
                                    try {
                                      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                                          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                                      ApiManager.getItemByBarcode(barcode: barcodeScanRes).then((item){
                                        if(item['statusCode'] == 200){
                                          enterQty(context).then((value) {
                                            EntryShipmentLogic.children.add({
                                              "itemId": item['item']['id'],
                                              "qty": value,
                                              "designation": item['item']['designation'],
                                            });
                                          });
                                        } else {
                                          Dialogs().messageDialog(context, "Item Not Found".tr());
                                        }
                                      });
                                    } on PlatformException {
                                      barcodeScanRes = 'Failed to get platform version.';
                                    }

                                  },
                                  child: const Icon(
                                    Icons.document_scanner_outlined,
                                    color: kPrimaryColor,
                                  )),
                              10.w,
                              InkWell(
                                  onTap: () {
                                    showShipmentsItem(context, logic: logic);
                                  },
                                  child: const Icon(
                                    Icons.widgets,
                                    color: kPrimaryColor,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 2,
                            width: screenWidth,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final client = ref.watch(logic.clientProvider);
                              ref.watch(refreshReBuilder);
                              return Expanded(
                                  child: SizedBox(
                                      width: screenWidth / 1.2,
                                      child: EntryShipmentClientItemsPagination(
                                        query: searchCnt.text,
                                        clientId: client?.id?.toString() ?? "",
                                      )));
                            },
                          ),
                          20.h,
                          InkWell(
                            onTap: () {
                              logic.create();
                            },
                            child: Container(
                              width: screenWidth / 1.3,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                              ),
                              decoration: BoxDecoration(
                                color: kGreenColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Create".tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
