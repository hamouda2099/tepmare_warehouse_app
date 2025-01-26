import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/dialogs/basic_dialogs.dart';
import 'package:tepmare_warehouse_man_app/logic/uiLogic/exit_shipment_logic.dart';
import 'package:tepmare_warehouse_man_app/models/stock_model.dart';

import '../../../config/constants.dart';
import '../../../logic/services/api_manager.dart';

/// Two variables in this class, first one is the function that returns list of data from api, second one is the custom widget that ListView.builder will return.
/// To use this custom pagination list you have to change that function and returned widget.
class ExitShipmentClientItemsPagination extends ConsumerWidget {
  ExitShipmentClientItemsPagination(
      {super.key, required this.query, required this.clientId});
  String query;
  String clientId;
  ScrollController scrollController = ScrollController();
  int limit = 10;
  int page = 1;
  bool isLastPage = false;
  bool isFetchingData = false;
  bool initState = false;
  final centerLoadingProvider = StateProvider<bool>((ref) => false);
  final bottomLoadingProvider = StateProvider<bool>((ref) => false);
  List<Stock> fetchedData = [];

  void getData(WidgetRef widgetRef) async {
    if (!isLastPage) {
      if (!isFetchingData) {
        isFetchingData = true;
        if (page == 1) {
          widgetRef.read(centerLoadingProvider.notifier).state = true;
        } else {
          widgetRef.read(bottomLoadingProvider.notifier).state = true;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
        }

        /// (1) change this function.
        StockModel stockItem = await ApiManager.getStock(
            page: page.toString(),
            limit: limit.toString(),
            query: query,
            clientId: clientId);
        List<Stock>? tempFetchedData = stockItem.stock;
        if (tempFetchedData?.isEmpty ?? true) {
          isLastPage = true;
        }
        fetchedData += tempFetchedData ?? [];
        page++;
        if (page == 2) {
          widgetRef.read(centerLoadingProvider.notifier).state = false;
        } else {
          widgetRef.read(bottomLoadingProvider.notifier).state = false;
        }
        isFetchingData = false;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    if (!initState) {
      initState = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          getData(widgetRef);
          scrollController.addListener(
            () {
              if (scrollController.position.atEdge &&
                  scrollController.position.pixels != 0) {
                getData(widgetRef);
              }
            },
          );
        },
      );
    }

    final centerLoading = widgetRef.watch(centerLoadingProvider);
    final bottomLoading = widgetRef.watch(bottomLoadingProvider);
    return centerLoading
        ? Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          )
        : fetchedData.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.people,
                      size: 70,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'No Data'.tr(),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: fetchedData.length,
                controller: scrollController,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      /// (2) change custom component for list view
                      InkWell(
                        onTap: () {
                          enterQty(context,
                                  qty:
                                      fetchedData[index].qty?.toString() ?? "0",
                                  itemName: fetchedData[index].designation)
                              .then((value) {
                            bool found = false;
                            num currentQty = 0;
                            for (int i = 0;
                                i < ExitShipmentLogic.children.length;
                                i++) {
                              if (ExitShipmentLogic.children[i]['itemId']
                                      .toString() ==
                                  fetchedData[index].id.toString()) {
                                currentQty +=
                                    ExitShipmentLogic.children[i]['qty'];
                              }
                            }
                            if (currentQty + value >
                                (fetchedData[index].qty ?? 0)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text(
                                      "${"Cannot exceed available stock of".tr()} ${fetchedData[index].qty}."),
                                ),
                              );
                              return;
                            }
                            for (int i = 0;
                                i < ExitShipmentLogic.children.length;
                                i++) {
                              if (ExitShipmentLogic.children[i]['itemId']
                                      .toString() ==
                                  fetchedData[index].id.toString()) {
                                ExitShipmentLogic.children[i]['qty'] =
                                    ExitShipmentLogic.children[i]['qty'] +
                                        value;
                                found = true;
                                break;
                              }
                            }
                            if (!found) {
                              ExitShipmentLogic.children.add({
                                "itemId": fetchedData[index].id,
                                "qty": value,
                                "designation": fetchedData[index].designation,
                                "locationId": fetchedData[index].locationId,
                              });
                            }
                          });
                        },
                        child: Container(
                          height: 45,
                          margin: const EdgeInsets.all(5),
                          width: screenWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(fetchedData[index].designation ?? ""),
                              Text(
                                "Stock: ${fetchedData[index].qty ?? ""}",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      index == fetchedData.length - 1 && bottomLoading
                          ? Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                },
              );
  }
}

Future<num> enterQty(BuildContext context,
    {required String qty, String? itemName}) async {
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enter QTY From".tr(),
                      style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                        ))
                  ],
                ),
                Text(
                  itemName ?? "",
                  style: const TextStyle(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                10.h,
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: kSecondaryColor.withOpacity(0.2), width: 1),
                  ),
                  child: TextFormField(
                    validator: (val) {
                      if (controller.text.isEmpty) {
                        return 'This field is required'.tr();
                      } else if (num.parse(controller.text) > num.parse(qty)) {
                        return 'Invalid Quantity'.tr();
                      } else {
                        return null;
                      }
                    },
                    controller: controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Quantity".tr(),
                    ),
                  ),
                ),
                10.h,
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    child: Text(
                      "Add to List".tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
  return num.parse(controller.text);
}
