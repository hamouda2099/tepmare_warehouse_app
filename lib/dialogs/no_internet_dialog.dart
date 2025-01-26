import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';

import '../config/constants.dart';
import '../config/navigator.dart';

class InternetDialog {
  void show({
    required BuildContext context,
    required Widget screen,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.signal_wifi_statusbar_connected_no_internet_4,
                  color: kPrimaryColor,
                  size: 150,
                ),
                10.h,
                Text(
                  'Network Error'.tr(),
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                5.h,
                Text(
                  'Check your network connection'.tr(),
                  style: const TextStyle(
                    color: kSecondaryColor,
                    fontSize: 14,
                  ),
                ),
                20.h,
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    navigator(
                      context: context,
                      screen: screen,
                    );
                  },
                  child: Container(
                    width: 130,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      boxShadow: boxShadow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Refresh'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
