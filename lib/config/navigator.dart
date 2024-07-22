import 'dart:io';

import 'package:flutter/material.dart';

import '../dialogs/basic_dialogs.dart';
import '../dialogs/no_internet_dialog.dart';

Future<void> navigator({
  required BuildContext context,
  required Widget screen,
  bool remove = false,
  bool replacement = false,
}) async {
  Dialogs().loadingDialog(context);
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      if (remove) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) {
          return screen;
        }), (Route<dynamic> route) => false);
      } else if (replacement) {
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (_) {
            return screen;
          },
        ));
      } else {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
          builder: (_) {
            return screen;
          },
        ));
      }
    } else {
      Navigator.pop(context);
      InternetDialog().show(
        context: context,
        screen: screen,
      );
    }
  } on SocketException catch (_) {
    Navigator.pop(context);
    InternetDialog().show(
      context: context,
      screen: screen,
    );
  }
}
