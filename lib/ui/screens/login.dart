import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/logic/functions/helper_functions.dart';

import '../../config/constants.dart';
import '../../dialogs/languages_dialog.dart';
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
          backgroundColor: kPrimaryColor,
          body: Form(
            key: logic.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                20.h,
                Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                ),
                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        30.h,
                        CustomTextField(
                          controller: logic.emailCnt,
                          hint: "Username".tr(),
                          icon: Icons.person,
                          validator: HelperFunctions.validateFieldRequired,
                          onSubmit: () {
                            if (logic.formKey.currentState!.validate()) {
                              logic.login();
                            }
                          },
                        ),
                        20.h,
                        CustomTextField(
                          controller: logic.passwordCnt,
                          hint: "Password".tr(),
                          maxLines: 1,
                          icon: Icons.lock,
                          secure: true,
                          visibility: true,
                          validator: HelperFunctions.validateFieldRequired,
                          onSubmit: () {
                            if (logic.formKey.currentState!.validate()) {
                              logic.login();
                            }
                          },
                        ),
                        40.h,
                        InkWell(
                          onTap: () {
                            if (logic.formKey.currentState!.validate()) {
                              logic.login();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                            ),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Text(
                              'LOGIN'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        20.h,
                        InkWell(
                            onTap: () {
                              LanguagesDialog().languages(
                                context: context,
                                screen: Login(),
                              );
                            },
                            child: Text(
                              localLanguage == "en" ? "Français" : "English",
                              style: TextStyle(color: kPrimaryColor),
                            )),
                        10.h,
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
