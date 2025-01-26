import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/config/navigator.dart';
import 'package:tepmare_warehouse_man_app/models/sites_model.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/edit_site.dart';

class SiteItem extends StatelessWidget {
  SiteItem(this.site);
  Site site;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Text(
                  site.label ?? "",
                  style: const TextStyle(
                    color: kGreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                InkWell(
                    onTap: () {
                    navigator(
                      context: context,
                      screen: EditSite(site),
                    );
                  },
                    child: Image.asset(
                      "assets/images/pen-circle.png",
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
