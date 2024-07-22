import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/logic/services/cache_manager.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/home.dart';

import '../../config/navigator.dart';
import '../../ui/screens/login.dart';


class SplashLogic {
  BuildContext? context;

  void splashInit() async {
    Future.delayed(const Duration(seconds: 2), () {
      navigator(
        context: context!,
        screen: Login(),
        remove: true,
      );
    });
  }

  Future checkLoggedIn() async {
    await CacheManager.init();
    if (CacheManager.getUserToken()?.isNotEmpty ?? false) {
      navigator(
        context: context!,
        screen: const Home(),
        remove: true,
      );
    } else {
      navigator(
        context: context!,
        screen: Login(),
        remove: true,
      );
    }
  }
}
