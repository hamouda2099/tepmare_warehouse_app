import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'config/constants.dart';
import 'config/env.dart';
import 'logic/uiLogic/splash_logic.dart';

GlobalKey<NavigatorState> globalKey = GlobalKey();

void main() {
  if (kDebugMode) {
    Env.prod();
  } else {
    /// ** WARNING.. DON'T CHANGE THIS LINE!!!
    Env.prod();
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('fr'),
      startLocale: const Locale('fr'),
      child: ProviderScope(
        child: App(),
      ),
    ),
  );
}
class SplashScreen extends StatefulWidget {
  static const String id = '/welcome';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashLogic logic = SplashLogic();

  @override
  void initState() {
    logic.context = context;
    Future.delayed(const Duration(seconds: 2), () {
      logic.checkLoggedIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(child: Image.asset(width: 100, "assets/images/logo.png")),
    );
  }
}
