import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:url_launcher/url_launcher.dart';


import '../config/constants.dart';

class UpdateAppDialog {
  Future<void> update(
    BuildContext context,
    bool? forceAndroidUpdate,
    bool? forceIosUpdate,
  ) async {
    if (Platform.isAndroid) {
      await androidUpdate(context, forceAndroidUpdate);
    } else if (Platform.isIOS) {
      await iosUpdate(context, forceIosUpdate);
    }
  }

  Future<void> androidUpdate(
    BuildContext context,
    bool? forceAndroidUpdate,
  ) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: kBackgroundColor,
        content: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Update SHARE DRIVE?'.tr(),
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.h,
              Text(
                'To enjoy the latest features, improvements, and enhanced performance, please update to the newest version today.'
                    .tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              30.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  forceAndroidUpdate == true
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'No thanks'.tr(),
                              style: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                  20.w,
                  InkWell(
                    onTap: () async {
                      await launchUrl(
                        Uri.parse(
                          "googlePlayUrl",
                        ),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Update'.tr(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  await launchUrl(
                    Uri.parse(
                      "googlePlayUrl",
                    ),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Image.asset(
                  "assets/images/google_play_badge.png",
                  height: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> iosUpdate(
    BuildContext context,
    bool? forceIosUpdate,
  ) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: kBackgroundColor,
        content: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Update SHARE DRIVE?'.tr(),
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.h,
              Text(
                'To enjoy the latest features, improvements, and enhanced performance, please update to the newest version today.'
                    .tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              30.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  forceIosUpdate == true
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'No thanks'.tr(),
                              style: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                  20.w,
                  InkWell(
                    onTap: () async {
                      await launchUrl(
                        Uri.parse(
                          "appStoreUrl",
                        ),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Update Version'.tr(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 30,
                color: kSecondaryColor,
              ),
              InkWell(
                onTap: () async {
                  await launchUrl(
                    Uri.parse(
                      "appStoreUrl",
                    ),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Image.asset(
                  "assets/images/app_store_badge.png",
                  height: 70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
