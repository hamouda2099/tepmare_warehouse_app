import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/models/sites_model.dart';
import 'package:tepmare_warehouse_man_app/ui/components/custom_text_field.dart';
import 'package:tepmare_warehouse_man_app/ui/components/secondary_app_bar.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/sites.dart';

import '../../config/constants.dart';
import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../logic/services/api_manager.dart';

class EditSite extends StatelessWidget {
  EditSite(this.site);
  Site site;
  TextEditingController siteLabel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    siteLabel.text = site.label??"";
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SecondaryAppBar("Edit Site".tr()),
              CustomTextField(
                controller: siteLabel,
                hint: "Enter Site Label".tr(),
              ),
              InkWell(
                onTap: () {
                  Dialogs().loadingDialog(context);
                  ApiManager.editSite(
                      label: siteLabel.text,
                      siteId: site.id.toString())
                      .then((value) {
                    Navigator.pop(context);
                    if (value['statusCode'] == 200) {
                      navigator(context: context,screen: Sites(),replacement: true);
                    } else {
                      Dialogs()
                          .messageDialog(context, value['message'] ?? "");
                    }
                  });
                },
                child: Container(
                  width: screenWidth,
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
