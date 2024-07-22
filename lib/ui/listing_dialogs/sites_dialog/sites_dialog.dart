import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/ui/listing_dialogs/sites_dialog/sites_pagination.dart';

import '../../../config/constants.dart';
import '../../../models/sites_model.dart';
import '../../components/search_text_field.dart';


class SitesListDialog {
  static Site? selectedSite;

  final refreshProvider = StateProvider<String?>((ref) => null);

  Future<Site?> show(BuildContext context) async {
    TextEditingController searchCnt = TextEditingController();
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Select Site".tr(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/images/close.png",
                          width: 25,
                          height: 25,
                        )),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ],
            ),
            backgroundColor: Colors.white,
            content: Consumer(
              builder: (context, ref, child) {
                return SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight / 1.5,
                  child: Column(
                    children: [
                      SizedBox(
                        width: screenWidth / 2,
                        child: SearchTextField(
                          controller: searchCnt,
                          onChanged: () {
                            ref.read(refreshProvider.notifier).state =
                                DateTime.now().toString();
                          },
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          ref.watch(refreshProvider);
                          return Expanded(
                            child: SitesDialogPagination(
                              query: searchCnt.text,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
    return selectedSite;
  }
}
