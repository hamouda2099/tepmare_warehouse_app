import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/config/navigator.dart';
import 'package:tepmare_warehouse_man_app/models/locations_model.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/locations.dart';

import '../../dialogs/basic_dialogs.dart';
import '../../logic/services/api_manager.dart';

class LocationItem extends StatelessWidget {
  LocationItem(this.location);
  Location location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.barcode ?? "",
                      style: const TextStyle(
                        color: kGreyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      location.site ?? "2",
                      style: const TextStyle(
                        color: kGreyColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                    onTap: () {
                      Dialogs().loadingDialog(context);
                      ApiManager.deleteLocation(id: location.id.toString()).then((value) {
                        Navigator.pop(context);
                        if (value['statusCode'] == 200) {
                          navigator(
                              context: context,
                          replacement: true,
                          screen: Locations(),
                        );
                      } else {
                          Dialogs().messageDialog(context, value['message'] ?? "");
                        }
                      });
                    },
                    child: Image.asset(
                      "assets/images/trash.png",
                      width: 25,
                  ),
                ),
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
