import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../logic/uiLogic/login_logic.dart';
import '../components/custom_text_field.dart';

class Login extends StatelessWidget {
  LoginLogic logic = LoginLogic();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    logic.context = context;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: SizedBox(
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: screenWidth / 1.2,
                  child: CustomTextField(
                    controller: logic.emailCnt,
                    hint: "Username".tr(),
                    icon: Icons.person,
                    onSubmit: () {
                      logic.login();
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: screenWidth / 1.2,
                  child: CustomTextField(
                    controller: logic.passwordCnt,
                    hint: "Password".tr(),
                    icon: Icons.lock,
                    secure: true,
                    visibility: true,
                    onSubmit: () {
                      logic.login();
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    logic.login();
                  },
                  child: Container(
                    width: screenWidth / 1.2,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Text(
                      'LOGIN'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
