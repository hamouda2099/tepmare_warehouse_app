import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/logic/uiLogic/create_item_logic.dart';
import 'package:tepmare_warehouse_man_app/ui/components/secondary_app_bar.dart';

import '../../config/constants.dart';
import '../components/custom_text_field.dart';
import '../components/dropdown_menu_component.dart';
import '../listing_dialogs/categories/categories_dialog.dart';
import '../listing_dialogs/clients/clients_dialog.dart';
import '../paginations/client_items_pagination.dart';
import 'items_children_dialog.dart';

class CreateItem extends ConsumerWidget {
  CreateItemLogic logic = CreateItemLogic();
  TextEditingController searchCnt = TextEditingController();
  final refreshReBuilder = StateProvider<String?>((ref) => null);
  PageController controller = PageController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logic.context = context;
    logic.ref = ref;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SecondaryAppBar("Create Item".tr()),
              40.h,
              Form(
                key: logic.formKey,
                child: Expanded(
                  child: PageView(
                    controller: controller,
                    children: [
                      ListView(
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              ref.watch(logic.clientProvider);
                              ref.watch(logic.clientNameProvider);
                              return Container(
                                height: 45,
                                width: screenWidth / 1.2,
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(ref
                                                .read(logic
                                                    .clientProvider.notifier)
                                                .state
                                                ?.username ??
                                            "Select Client".tr()),
                                        InkWell(
                                          onTap: () {
                                            ClientsListDialog()
                                                .show(context)
                                                .then((value) {
                                              if (value != null) {
                                                ref
                                                    .read(logic.clientProvider
                                                        .notifier)
                                                    .state = value;
                                                ref
                                                    .read(logic
                                                        .clientNameProvider
                                                        .notifier)
                                                    .state = value.username;
                                              }
                                            });
                                          },
                                          child: Image.asset(
                                            "assets/images/clients.png",
                                            width: 20,
                                            height: 20,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    5.h,
                                    const Divider()
                                  ],
                                ),
                              );
                            },
                          ),
                          20.h,
                          Consumer(
                            builder: (context, ref, child) {
                              ref.watch(logic.categoryProvider);
                              ref.watch(logic.categoryNameProvider);
                              return Container(
                                height: 45,
                                width: screenWidth / 1.2,
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(ref
                                                .read(logic
                                                    .categoryProvider.notifier)
                                                .state
                                                ?.label ??
                                            "Select Category".tr()),
                                        InkWell(
                                          onTap: () {
                                            CategoriesListDialog()
                                                .show(context)
                                                .then((value) {
                                              if (value != null) {
                                                ref
                                                    .read(logic.categoryProvider
                                                        .notifier)
                                                    .state = value;
                                                ref
                                                    .read(logic
                                                        .categoryNameProvider
                                                        .notifier)
                                                    .state = value.label;
                                              }
                                            });
                                          },
                                          child: Image.asset(
                                            "assets/images/category.png",
                                            width: 20,
                                            height: 20,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    5.h,
                                    const Divider()
                                  ],
                                ),
                              );
                            },
                          ),
                          CustomTextField(
                            controller: logic.designationCnt,
                            hint: "Designation".tr(),
                          ),
                          SizedBox(
                            width: screenWidth / 1.2,
                            child: DropdownMenuComponent(
                              icon: Icons.list,
                              hintText: 'Type'.tr(),
                              items: logic.types,
                              valueProvider: logic.typeProvider,
                            ),
                          ),
                          CustomTextField(
                            controller: logic.skuCnt,
                            hint: "SKU".tr(),
                          ),
                          CustomTextField(
                            controller: logic.barcodeCnt,
                            hint: "Barcode".tr(),
                          ),
                          SizedBox(
                            width: screenWidth / 1.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextField(
                                  width: screenWidth / 2.5,
                                  controller: logic.widthCnt,
                                  hint: "Width".tr(),
                                ),
                                CustomTextField(
                                  width: screenWidth / 2.5,
                                  controller: logic.heightCnt,
                                  hint: "Height".tr(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenWidth / 1.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextField(
                                  width: screenWidth / 2.5,
                                  controller: logic.depthCnt,
                                  hint: "Depth".tr(),
                                ),
                                CustomTextField(
                                  width: screenWidth / 2.5,
                                  controller: logic.weightCnt,
                                  hint: "Weight".tr(),
                                ),
                              ],
                            ),
                          ),
                          50.h,
                          Consumer(
                            builder: (context, ref, child) {
                              final type = ref.watch(logic.typeProvider);
                              return InkWell(
                                onTap: () {
                                  if (type == 'simple') {
                                    logic.create();
                                  } else {
                                    if ((logic.formKey.currentState
                                            ?.validate() ??
                                        false)) {
                                      controller.animateToPage(1,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeIn);
                                    }
                                  }
                                },
                                child: Container(
                                  width: screenWidth / 1.3,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: type == 'simple'
                                        ? kGreenColor
                                        : kPrimaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    type == 'simple' ? "Create".tr() : 'Next'.tr(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Items",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                " |",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  width: screenWidth / 1.5,
                                  child: TextField(
                                    controller: searchCnt,
                                    onChanged: (val) {
                                      ref
                                          .read(refreshReBuilder.notifier)
                                          .state = DateTime.now().toString();
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: "Search",
                                        hintStyle: TextStyle(fontSize: 14)),
                                  )),
                              InkWell(
                                  onTap: () {
                                    showItemChildren(context, logic: logic);
                                  },
                                  child: const Icon(
                                    Icons.widgets,
                                    color: kPrimaryColor,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 2,
                            width: screenWidth,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final client = ref.watch(logic.clientProvider);
                              ref.watch(refreshReBuilder);
                              return Expanded(
                                  child: SizedBox(
                                      width: screenWidth / 1.2,
                                      child: ClientItemsPagination(
                                        query: searchCnt.text,
                                        clientId: client?.id?.toString() ?? "",
                                      )));
                            },
                          ),
                          20.h,
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
                              child: const Text(
                                "Create",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
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
