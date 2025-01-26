import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants.dart';
import '../../../models/categories_model.dart';
import '../../components/search_text_field.dart';
import 'categories_pagination.dart';

class CategoriesListDialog {
  static Category? selectedCategory;

  final refreshProvider = StateProvider<String?>((ref) => null);

  Future<Category?> show(BuildContext context) async {
    TextEditingController searchCnt = TextEditingController();
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Consumer(
            builder: (context, ref, child) {
              return Container(
                width: screenWidth,
                height: screenHeight / 1.2,
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Select Category".tr(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              "assets/images/close.png",
                              width: 25,
                              height: 25,
                            )),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: screenWidth,
                      child: SearchTextField(
                        controller: searchCnt,
                        onChanged: (val) {
                          ref.read(refreshProvider.notifier).state =
                              DateTime.now().toString();
                        },
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        ref.watch(refreshProvider);
                        return Expanded(
                          child: CategoriesDialogPagination(
                            query: searchCnt.text,
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            },
          );
        });
    return selectedCategory;
  }
}
