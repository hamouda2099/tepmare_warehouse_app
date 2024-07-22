import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/ui/components/custom_text_field.dart';
import 'package:tepmare_warehouse_man_app/ui/components/secondary_app_bar.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/shipments.dart';

import '../../config/constants.dart';
import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../logic/functions/date_picker.dart';
import '../../logic/services/api_manager.dart';
import '../../models/shipments_model.dart';
import '../components/dropdown_menu_component.dart';

class EditShipment extends ConsumerWidget {
  EditShipment(this.shipment);
  Shipment shipment;
  TextEditingController container = TextEditingController();
  final arrivalDateProvider = StateProvider<String?>((ref) => null);
  final statusProvider = StateProvider<String?>((ref) => null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    container.text = shipment.container?.toString() ?? "";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(arrivalDateProvider.notifier).state = shipment.arrivalDate ?? "";
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SecondaryAppBar("Edit Shipment".tr()),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      (screenHeight / 3).h,
                      Container(
                          height: 45,
                          width: screenWidth / 1.2,
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: Consumer(
                            builder: (context, ref, child) {
                              ref.watch(arrivalDateProvider);
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(ref
                                              .read(
                                                  arrivalDateProvider.notifier)
                                              .state ??
                                          "Arrival Date".tr()),
                                      InkWell(
                                        onTap: () {
                                          datePicker(context).then((value) {
                                            ref
                                                .read(arrivalDateProvider
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
                                  const Divider()
                                ],
                              );
                            },
                          )),
                      SizedBox(
                        width: screenWidth / 1.2,
                        child: DropdownMenuComponent(
                          icon: Icons.list,
                          hintText: 'Status'.tr(),
                          items: const ["terminated", "completed"],
                          valueProvider: statusProvider,
                        ),
                      ),
                      CustomTextField(
                        controller: container,
                        hint: "Container".tr(),
                      ),
                      20.h,
                      InkWell(
                        onTap: () {
                          Dialogs().loadingDialog(context);
                          ApiManager.editShipment(
                                  shipmentId: shipment.id.toString(),
                                  container: container.text,
                                  status:
                                      ref.read(statusProvider.notifier).state)
                              .then((value) {
                            Navigator.pop(context);
                            if (value['statusCode'] == 200) {
                              Navigator.pop(context);
                              navigator(
                                  context: context,
                                  replacement: true,
                                  screen: Shipments());
                            } else {
                              Dialogs().messageDialog(
                                  context, value['message'] ?? "");
                            }
                          });
                        },
                        child: Container(
                          width: screenWidth / 1.3,
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
                            'Submit'.tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
