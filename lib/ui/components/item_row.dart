import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/config/navigator.dart';
import 'package:tepmare_warehouse_man_app/models/items_model.dart';

import 'package:tepmare_warehouse_man_app/ui/screens/item_details.dart';

import '../../dialogs/basic_dialogs.dart';
import '../../logic/services/api_manager.dart';
import '../screens/items.dart';

class ItemRow extends StatelessWidget {
  ItemRow(this.item);
  Item item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigator(context: context, screen: ItemDetails(item: item,));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.designation ?? "",
                        style: const TextStyle(
                          color: kGreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        item.barcode ?? "",
                        style: const TextStyle(
                          color: kGreyColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    item.type ?? "",
                    style: const TextStyle(
                      color: kSecondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.w,
                  InkWell(
                      onTap: () {
                        Dialogs().loadingDialog(context);
                        ApiManager.deleteItem(id: item.id.toString()).then((value) {
                          Navigator.pop(context);
                          if (value['statusCode'] == 200) {
                            navigator(
                                context: context,
                                screen: Items(),
                                replacement: true);
                          } else {
                            Dialogs().messageDialog(context, value['message'] ?? "");
                          }
                        });
                      },
                      child: Image.asset(
                        "assets/images/trash.png",
                        width: 25,
                      )),

                ],
              ),
            ),
            10.h,
            const Divider()
          ],
        ),
      ),
    );
  }
}
