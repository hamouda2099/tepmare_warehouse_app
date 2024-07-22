import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'config/constants.dart';
import 'main.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Tepmare',
      theme: ThemeData(
        fontFamily: 'Poppins-Regular',
        primarySwatch: Colors.amber,
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: kPrimaryColor,
            selectionColor: kPrimaryColor,
            selectionHandleColor: kPrimaryColor),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      home: SplashScreen(),
    );
  }
}
