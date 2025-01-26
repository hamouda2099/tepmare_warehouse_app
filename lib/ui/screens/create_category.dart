import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/logic/functions/helper_functions.dart';
import 'package:tepmare_warehouse_man_app/ui/components/custom_text_field.dart';
import 'package:tepmare_warehouse_man_app/ui/components/secondary_app_bar.dart';

import '../../config/constants.dart';
import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../logic/functions/show_snack_bar.dart';
import '../../logic/services/api_manager.dart';
import 'categories.dart';

class CreateCategory extends StatelessWidget {
  TextEditingController categoryLabel = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SecondaryAppBar("Create Category".tr()),
                CustomTextField(
                  controller: categoryLabel,
                  hint: "Enter Category Label".tr(),
                  validator: HelperFunctions.validateFieldRequired,
                ),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Dialogs().loadingDialog(context);
                      ApiManager.createCategory(label: categoryLabel.text)
                          .then((value) {
                        Navigator.pop(context);
                        if (value['statusCode'] == 200) {
                          navigator(
                              context: context,
                              screen: Categories(),
                              replacement: true);
                        } else {
                          showSnackBar(
                              context: context,
                              message: value['message'].toString().tr(),
                              error: true);
                        }
                      });
                    }
                  },
                  child: Container(
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
                      style: TextStyle(
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
      ),
    );
  }
}
