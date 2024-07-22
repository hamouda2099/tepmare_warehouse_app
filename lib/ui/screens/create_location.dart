import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/logic/uiLogic/create_location_logic.dart';
import 'package:tepmare_warehouse_man_app/ui/components/custom_text_field.dart';
import 'package:tepmare_warehouse_man_app/ui/components/secondary_app_bar.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/sites.dart';

import '../../config/constants.dart';
import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../logic/services/api_manager.dart';
import '../components/dropdown_menu_component.dart';
import '../listing_dialogs/sites_dialog/sites_dialog.dart';

class CreateLocation extends StatelessWidget {
  CreateLocationLogic logic = CreateLocationLogic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SecondaryAppBar("Create Location".tr()),
              20.h,
              CustomTextField(
                controller: logic.hallCnt,
                hint: "Hall".tr(),
              ),
              10.h,
              SizedBox(
                width: screenWidth / 1.2,
                child: DropdownMenuComponent(
                  icon: Icons.list,
                  hintText: 'Aisle'.tr(),
                  items: logic.aisles,
                  valueProvider: logic.aisleProvider,
                ),
              ),
              10.h,
              SizedBox(
                width: screenWidth / 1.2,
                child: DropdownMenuComponent(
                  icon: Icons.list,
                  hintText: 'Field'.tr(),
                  items: logic.fields,
                  valueProvider: logic.fieldProvider,
                ),
              ),
              10.h,
              CustomTextField(
                controller: logic.positionCnt,
                hint: "Position".tr(),
              ),
              10.h,
              CustomTextField(
                width: screenWidth / 1.2,
                controller: logic.typeCnt,
                hint: "Type".tr(),
                validator: (val) {
                  if (logic.typeCnt.text.isEmpty) {
                    return 'This field is required'.tr();
                  } else {
                    return null;
                  }
                },
              ),
              10.h,
              SizedBox(
                width: screenWidth / 1.2,
                child: DropdownMenuComponent(
                  icon: Icons.list,
                  hintText: 'Level'.tr(),
                  items: logic.levels,
                  valueProvider: logic.levelProvider,
                ),
              ),
              20.h,
              Consumer(
                builder: (context, ref, child) {
                  ref.watch(logic.siteProvider);
                  ref.watch(logic.siteNameProvider);
                  return Container(
                    height: 50,
                    width: screenWidth / 1.2,
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(ref
                                    .read(logic.siteProvider.notifier)
                                    .state
                                    ?.label ??
                                "Select Site".tr()),
                            InkWell(
                              onTap: () {
                                SitesListDialog().show(context).then((value) {
                                  if (value != null) {
                                    ref
                                        .read(logic.siteProvider.notifier)
                                        .state = value;
                                    ref
                                        .read(logic.siteNameProvider.notifier)
                                        .state = value.label;
                                  }
                                });
                              },
                              child: Image.asset(
                                "assets/images/sites.png",
                                width: 20,
                                height: 20,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        5.h,
                        Divider()
                      ],
                    ),
                  );
                },
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  logic.create();
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
    );
  }
}
