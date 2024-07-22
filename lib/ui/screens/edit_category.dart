import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/config/navigator.dart';

import 'package:tepmare_warehouse_man_app/ui/components/custom_text_field.dart';
import 'package:tepmare_warehouse_man_app/ui/components/secondary_app_bar.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/categories.dart';

import '../../config/constants.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../logic/services/api_manager.dart';
import '../../models/categories_model.dart';

class EditCategory extends StatelessWidget {
  EditCategory(this.category);
  Category category;
  TextEditingController categoryLabel = TextEditingController();
  @override
  Widget build(BuildContext context) {
    categoryLabel.text = category.label ?? "";
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SecondaryAppBar("Edit Category".tr()),
              (screenHeight / 3).h,
              CustomTextField(
                controller: categoryLabel,
                hint: "Enter Category Label".tr(),
              ),
              20.h,
              InkWell(
                onTap: () {
                  Dialogs().loadingDialog(context);
                  ApiManager.editCategory(
                          label: categoryLabel.text,
                          categoryId: category.id.toString())
                      .then((value) {
                    Navigator.pop(context);
                    if (value['statusCode'] == 200) {
                      navigator(
                          context: context,
                          screen: Categories(),
                          replacement: true);
                    } else {
                      Dialogs().messageDialog(context, value['message'] ?? "");
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
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Submit'.tr(),
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
