import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/logic/functions/helper_functions.dart';
import 'package:tepmare_warehouse_man_app/logic/functions/show_snack_bar.dart';
import 'package:tepmare_warehouse_man_app/logic/uiLogic/exit_shipment_logic.dart';

import '../../config/constants.dart';
import '../components/custom_text_field.dart';
import '../components/secondary_app_bar.dart';
import '../listing_dialogs/clients/clients_dialog.dart';
import '../paginations/exit_shipments_client_items_pagination.dart';
import 'exit_shipment_items_dialog.dart';

class ExitShipment extends ConsumerWidget {
  ExitShipmentLogic logic = ExitShipmentLogic();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ExitShipmentLogic.children = [];
    logic.context = context;
    logic.ref = ref;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SecondaryAppBar("Exit Shipment".tr()),
              40.h,
              Expanded(
                child: PageView(
                  controller: logic.controller,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Form(
                      key: logic.formKey,
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Consumer(
                                    builder: (context, ref, child) {
                                      ref.watch(logic.clientProvider);
                                      ref.watch(logic.clientNameProvider);
                                      return Container(
                                        width: screenWidth,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: kGreyColor.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(ref
                                                    .read(logic.clientProvider
                                                        .notifier)
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
                                                        .read(logic
                                                            .clientProvider
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
                                      );
                                    },
                                  ),
                                  20.h,
                                  CustomTextField(
                                    controller: logic.destinationAddressCnt,
                                    hint: "Destination Address".tr(),
                                    validator:
                                        HelperFunctions.validateFieldRequired,
                                  ),
                                  20.h,
                                  CustomTextField(
                                    controller: logic.approClientCnt,
                                    hint: "N'd appro client".tr(),
                                    validator:
                                        HelperFunctions.validateFieldRequired,
                                  ),
                                  20.h,
                                  CustomTextField(
                                    controller: logic.descriptionCnt,
                                    hint: "Description".tr(),
                                    maxLines: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (ref
                                      .read(logic.clientProvider.notifier)
                                      .state ==
                                  null) {
                                showSnackBar(
                                    context: context,
                                    message: "Please select client".tr(),
                                    error: true);
                              } else if (logic.formKey.currentState!
                                  .validate()) {
                                logic.controller.animateToPage(1,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeIn);
                              }
                            },
                            child: Container(
                              width: screenWidth,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                              ),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
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
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Items".tr(),
                              style: const TextStyle(
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
                                  controller: logic.searchCnt,
                                  onChanged: (val) {
                                    ref
                                        .read(logic.refreshReBuilder.notifier)
                                        .state = DateTime.now().toString();
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: kPrimaryColor,
                                      ),
                                      hintText: "Search".tr(),
                                      hintStyle: const TextStyle(fontSize: 14)),
                                )),
                            InkWell(
                                onTap: () async {},
                                child: const Icon(
                                  Icons.document_scanner_outlined,
                                  color: kPrimaryColor,
                                )),
                            10.w,
                            InkWell(
                                onTap: () {
                                  showExitShipmentItems(context, logic: logic);
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
                        20.h,
                        Consumer(
                          builder: (context, ref, child) {
                            final client = ref.watch(logic.clientProvider);
                            ref.watch(logic.refreshReBuilder);
                            return Expanded(
                                child: SizedBox(
                                    width: screenWidth / 1.2,
                                    child: ExitShipmentClientItemsPagination(
                                      query: logic.searchCnt.text,
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
                              style: const TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}
