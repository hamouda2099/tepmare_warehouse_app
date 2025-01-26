import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/user_data.dart';
import 'package:tepmare_warehouse_man_app/logic/functions/show_snack_bar.dart';
import 'package:tepmare_warehouse_man_app/logic/services/cache_manager.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/home.dart';

import '../../../config/navigator.dart';
import '../../../dialogs/basic_dialogs.dart';
import '../../../logic/services/api_manager.dart';

class LoginLogic {
  late BuildContext context;

  final isPasswordVisibleProvider = StateProvider<bool>((ref) => false);
  TextEditingController emailCnt = TextEditingController();
  TextEditingController passwordCnt = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (emailCnt.text.isEmpty || passwordCnt.text.isEmpty) {
      Dialogs().messageDialog(context, "Some Field is required");
    } else {
      Dialogs().loadingDialog(context);
      ApiManager.login(username: emailCnt.text, password: passwordCnt.text)
          .then((value) {
        Navigator.pop(context);
        if (value.statusCode == 200) {
          UserData.token = value.user?.token;
          CacheManager.setUserToken(value.user?.token ?? '');
          CacheManager.setUsername(value.user?.username ?? '');
          UserData.user = value.user;
          navigator(
            context: context,
            screen: const Home(),
            remove: true,
          );
        } else {
          showSnackBar(
              context: context,
              message: value.message ?? 'Error !',
              error: true);
        }
      }).catchError((onError) {
        Navigator.pop(context);
        Dialogs().messageDialog(context, onError.toString());
      });
    }
  }
}
