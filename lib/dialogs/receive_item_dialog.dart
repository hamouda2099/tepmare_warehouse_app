import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';

import '../config/constants.dart';
import '../models/locations_model.dart';
import '../models/shipment_details_model.dart';
import '../ui/listing_dialogs/locations_dialog/locations_dialog.dart';
import 'basic_dialogs.dart';

class ReceiveItem {
  static List<Map> locations = [];
  static List<LocationItem> locationsWidgets = [];
  final locationsRefresh = StateProvider<String?>((ref) => null);

  Future receiveItem(BuildContext context, {Item? item}) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: screenWidth / 1.1,
                height: screenHeight / 1.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Consumer(
                  builder: (context, ref, child) {
                    ref.watch(locationsRefresh);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item?.designation ?? "",
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          item?.type ?? "",
                          style: const TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${"QTY".tr()} ${item?.reportedQty.toString()}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        20.h,
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              locationsWidgets.add(LocationItem());
                              ref.read(locationsRefresh.notifier).state =
                                  DateTime.now().toString();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kGreenColor,
                                borderRadius: BorderRadius.circular(
                                  100,
                                ),
                              ),
                              child: const Text(
                                "Add Location",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        20.h,
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: locationsWidgets.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      locationsWidgets[index],
                                      InkWell(
                                        onTap: () {
                                          locations.removeAt(index);
                                          locationsWidgets.removeAt(index);
                                          ref
                                              .read(locationsRefresh.notifier)
                                              .state = DateTime
                                                  .now()
                                              .toString();
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        20.h,
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              num locationsQty = 0;
                              for (var element in locations) {
                                locationsQty = locationsQty + element['qty'];
                              }
                              if (locationsQty <= (item?.reportedQty ?? 0)) {
                                Navigator.pop(context);
                              } else {
                                Dialogs().messageDialog(
                                  context,
                                  "Please check Quantities".tr(),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: screenWidth / 4,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kGreenColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Text(
                                "Confirm",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        });
    return locations;
  }
}

class LocationItem extends ConsumerWidget {
  final locationProvider = StateProvider<Location?>((ref) => null);
  final doneProvider = StateProvider<bool>((ref) => false);
  TextEditingController qtyCnt = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(locationProvider);
    final done = ref.watch(doneProvider);
    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              width: 100,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: kPrimaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: done
                  ? Center(
                      child: Text(
                        qtyCnt.text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : TextFormField(
                      textAlign: TextAlign.center,
                      controller: qtyCnt,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (qtyCnt.text.isEmpty) {
                          return 'This field is required'.tr();
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: "Enter Qty".tr(),
                      ),
                    )),
          InkWell(
            onTap: () {
              LocationsListDialog().show(context).then((value) {
                if (value != null) {
                  ref.read(locationProvider.notifier).state = value;
                }
              });
            },
            child: SizedBox(
              width: 100,
              child: Text(
                ref.read(locationProvider.notifier).state?.barcode ??
                    "Select Location".tr(),
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          10.w,
          done == true
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      ReceiveItem.locations.add({
                        "locationId": ref
                            .read(locationProvider.notifier)
                            .state
                            ?.id
                            .toString(),
                        "qty": num.parse(qtyCnt.text),
                      });
                      ref.read(doneProvider.notifier).state = true;
                    }
                  },
                  child: const Icon(
                    Icons.done,
                    color: Colors.green,
                  ),
                ),
        ],
      ),
    );
  }
}
