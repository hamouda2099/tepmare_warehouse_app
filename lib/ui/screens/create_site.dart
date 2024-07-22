import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/ui/components/custom_text_field.dart';
import 'package:tepmare_warehouse_man_app/ui/components/secondary_app_bar.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/sites.dart';

import '../../config/constants.dart';
import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../logic/services/api_manager.dart';

class CreateSite extends StatelessWidget {
  TextEditingController siteLabel = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SecondaryAppBar("Create Site".tr()),
              (screenHeight/3).h,
              CustomTextField(controller: siteLabel,hint: "Enter Site Label".tr(),),
              20.h,
              InkWell(
                onTap: () {
                  Dialogs().loadingDialog(context);
                  ApiManager.createSite(label: siteLabel.text)
                      .then((value) {
                    Navigator.pop(context);
                    if (value['statusCode'] == 200) {
                      navigator(context: context, screen: Sites(),replacement: true);
                    } else {
                      Dialogs().messageDialog(context, value['message']);
                    }
                  });
                },
                child: Container(
                  width: screenWidth / 1.3,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                  ),
                  decoration: BoxDecoration(
                    color: kGreenColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Create'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
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
