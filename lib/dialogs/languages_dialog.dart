import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';

import '../config/constants.dart';
import '../config/navigator.dart';
import '../logic/services/api_manager.dart';
import '../logic/services/cache_manager.dart';

class LanguagesDialog {
  void languages({
    required BuildContext context,
    required Widget screen,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: kBackgroundColor,
        contentPadding: EdgeInsets.zero,
        content: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Change Language'.tr(),
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 50,
                child: Divider(
                  color: kSecondaryColor,
                ),
              ),
              InkWell(
                onTap: () {
                  CacheManager.setLanguageCode('en');
                  localLanguage = 'en';
                  context.setLocale(const Locale('en'));
                  // ApiManager.updateUser(lang: "en");
                  navigator(
                    context: context,
                    remove: true,
                    screen: screen,
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      const Image(
                        height: 35,
                        image: AssetImage(
                          'assets/images/en.jpg',
                        ),
                      ),
                      10.w,
                      Text(
                        'English'.tr(),
                        style: const TextStyle(
                          color: kSecondaryColor,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              20.h,
              InkWell(
                onTap: () {
                  CacheManager.setLanguageCode('fr');
                  localLanguage = 'fr';
                  context.setLocale(const Locale('fr'));
                  // ApiManager.updateUser(lang: "fr");
                  navigator(
                    context: context,
                    remove: true,
                    screen: screen,
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    children: [
                      const Image(
                        height: 35,
                        image: AssetImage(
                          'assets/images/fr.png',
                        ),
                      ),
                      10.w,
                      Text(
                        'French'.tr(),
                        style: const TextStyle(
                          color: kSecondaryColor,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
