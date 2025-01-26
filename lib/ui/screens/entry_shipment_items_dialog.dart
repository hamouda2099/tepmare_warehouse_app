import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/logic/uiLogic/entry_shipment_logic.dart';

void showShipmentsItem(BuildContext context,
    {required EntryShipmentLogic logic}) {
  final childrenReBuilder = StateProvider<String?>((ref) => null);

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          child: Consumer(
            builder: (context, ref, child) {
              ref.watch(childrenReBuilder);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                  SizedBox(
                    width: screenWidth / 1.2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Items".tr(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              "Qty".tr(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 80,
                              child: Text(
                                "Delete".tr(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    width: screenWidth / 1.2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: screenWidth / 1.2,
                    height: screenHeight / 1.4,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: EntryShipmentLogic.children.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 45,
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                            width: screenWidth / 4,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(EntryShipmentLogic.children[index]
                                    ['designation']),
                                const Spacer(),
                                Text(EntryShipmentLogic.children[index]['qty']
                                    .toString()),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 80,
                                  child: InkWell(
                                      onTap: () {
                                        EntryShipmentLogic.children
                                            .removeAt(index);
                                        ref
                                            .read(childrenReBuilder.notifier)
                                            .state = DateTime.now().toString();
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              );
            },
          ),
        );
      });
}
