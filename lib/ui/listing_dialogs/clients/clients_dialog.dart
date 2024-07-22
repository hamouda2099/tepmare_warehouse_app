import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../config/constants.dart';
import '../../../models/clients_model.dart';
import '../../components/search_text_field.dart';
import 'clients_pagination.dart';

class ClientsListDialog {
  static Client? selectedClient;

  final refreshProvider = StateProvider<String?>((ref) => null);

  Future<Client?> show(BuildContext context) async {
    TextEditingController searchCnt = TextEditingController();
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
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
              ],
            ),
            backgroundColor: Colors.white,
            content: Consumer(
              builder: (context, ref, child) {
                return SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight / 1.5,
                  child: Column(
                    children: [
                      SizedBox(
                        width: screenWidth / 2,
                        child: SearchTextField(
                          controller: searchCnt,
                          onChanged: () {
                            ref.read(refreshProvider.notifier).state =
                                DateTime.now().toString();
                          },
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          ref.watch(refreshProvider);
                          return Expanded(
                            child: ClientsDialogPagination(
                              query: searchCnt.text,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
    return selectedClient;
  }
}
