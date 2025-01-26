import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/logic/functions/helper_functions.dart';
import 'package:tepmare_warehouse_man_app/logic/uiLogic/create_location_logic.dart';
import 'package:tepmare_warehouse_man_app/ui/components/custom_text_field.dart';
import 'package:tepmare_warehouse_man_app/ui/components/secondary_app_bar.dart';

import '../../config/constants.dart';
import '../components/dropdown_menu_component.dart';
import '../listing_dialogs/sites_dialog/sites_dialog.dart';

class CreateLocation extends ConsumerWidget {
  CreateLocationLogic logic = CreateLocationLogic();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logic.context = context;
    logic.ref = ref;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SecondaryAppBar("Create Location".tr()),
              20.h,
              Expanded(
                child: Form(
                  key: logic.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: logic.hallCnt,
                          hint: "Hall".tr(),
                          validator: HelperFunctions.validateFieldRequired,
                        ),
                        10.h,
                        DropdownMenuComponent(
                          icon: Icons.list,
                          hintText: 'Aisle'.tr(),
                          items: logic.aisles,
                          valueProvider: logic.aisleProvider,
                          validator: (val) {
                            if (ref.read(logic.aisleProvider.notifier).state ==
                                null) {
                              return 'This field is required'.tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                        10.h,
                        DropdownMenuComponent(
                          icon: Icons.list,
                          hintText: 'Field'.tr(),
                          items: logic.fields,
                          valueProvider: logic.fieldProvider,
                          validator: (val) {
                            if (ref.read(logic.fieldProvider.notifier).state ==
                                null) {
                              return 'This field is required'.tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                        10.h,
                        CustomTextField(
                          controller: logic.positionCnt,
                          hint: "Position".tr(),
                          validator: HelperFunctions.validateFieldRequired,
                        ),
                        10.h,
                        CustomTextField(
                          controller: logic.typeCnt,
                          hint: "Type".tr(),
                          validator: HelperFunctions.validateFieldRequired,
                        ),
                        10.h,
                        DropdownMenuComponent(
                          icon: Icons.list,
                          hintText: 'Level'.tr(),
                          items: logic.levels,
                          valueProvider: logic.levelProvider,
                          validator: (val) {
                            if (ref.read(logic.levelProvider.notifier).state ==
                                null) {
                              return 'This field is required'.tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                        20.h,
                        Consumer(
                          builder: (context, ref, child) {
                            ref.watch(logic.siteProvider);
                            ref.watch(logic.siteNameProvider);
                            return Container(
                              width: screenWidth,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: kGreyColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(ref
                                          .read(logic.siteProvider.notifier)
                                          .state
                                          ?.label ??
                                      "Select Site".tr()),
                                  InkWell(
                                    onTap: () {
                                      SitesListDialog()
                                          .show(context)
                                          .then((value) {
                                        if (value != null) {
                                          ref
                                              .read(logic.siteProvider.notifier)
                                              .state = value;
                                          ref
                                              .read(logic
                                                  .siteNameProvider.notifier)
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
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  logic.create();
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
    );
  }
}
