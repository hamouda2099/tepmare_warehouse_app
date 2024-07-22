import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';

import '../../config/constants.dart';
import '../../config/navigator.dart';
import '../../config/user_data.dart';
import '../../dialogs/languages_dialog.dart';
import '../../logic/services/cache_manager.dart';
import '../screens/home.dart';
import '../screens/login.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          UserData.user?.username ?? CacheManager.getUsername() ?? "",
          style: const TextStyle(color: kGreyColor, fontSize: 16),
        ),
        const Spacer(),
        InkWell(
            onTap: () {
              navigator(context: context, screen: const Home());
            },
            child: Image.asset(
              "assets/images/dashboard.png",
              width: 20,
              height: 20,
              color: kGreyColor,
            )),
        15.w,
        InkWell(
            onTap: () {
              LanguagesDialog().languages(context: context, screen: Home());
            },
            child: Image.asset(
              "assets/images/settings.png",
              width: 20,
              height: 20,
              color: kGreyColor,
            )),
        15.w,
        InkWell(
            onTap: () {
              UserData.token = null;
              UserData.user = null;
              CacheManager.setUserToken(null);
              navigator(context: context, screen: Login(), remove: true);
            },
            child: Image.asset(
              "assets/images/logout.png",
              width: 20,
              height: 20,
              color: kGreyColor,
            )),
      ],
    );
  }
}
