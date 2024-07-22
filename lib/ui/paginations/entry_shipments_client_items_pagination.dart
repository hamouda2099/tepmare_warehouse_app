import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/models/items_model.dart';
import 'package:tepmare_warehouse_man_app/models/sites_model.dart';
import 'package:tepmare_warehouse_man_app/ui/components/site_item.dart';


import '../../../config/constants.dart';
import '../../../logic/services/api_manager.dart';
import '../../logic/uiLogic/create_item_logic.dart';
import '../../logic/uiLogic/entry_shipment_logic.dart';

/// Two variables in this class, first one is the function that returns list of data from api, second one is the custom widget that ListView.builder will return.
/// To use this custom pagination list you have to change that function and returned widget.
class EntryShipmentClientItemsPagination extends ConsumerWidget {
  EntryShipmentClientItemsPagination(
      {super.key,
        required this.query,
        required this.clientId});
  String query;
  String clientId;  ScrollController scrollController = ScrollController();
  int limit = 10;
  int page = 1;
  bool isLastPage = false;
  bool isFetchingData = false;
  bool initState = false;
  final centerLoadingProvider = StateProvider<bool>((ref) => false);
  final bottomLoadingProvider = StateProvider<bool>((ref) => false);
  List<Item> fetchedData = [];

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
        ItemsModel itemsModel = await ApiManager.getItems(
          page: page.toString(),
          limit: limit.toString(),
            query: query,
            clientId: clientId
        );
        List<Item>? tempFetchedData = itemsModel.items;
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
        ? Center(child: CircularProgressIndicator(color: kPrimaryColor,),)

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
                enterQty(context).then((value) {
                  EntryShipmentLogic.children.add({
                    "itemId":
                    fetchedData[index].id,
                    "qty": value,
                    "designation": fetchedData[index].designation,
                  });
                });
              },
              child: Container(
                height: 45,
                margin: EdgeInsets.all(5),
                width: screenWidth ,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius:
                  BorderRadius.circular(10),
                ),
                child: Text(fetchedData[index]
                    .designation ??
                    ""),
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

Future<num> enterQty(BuildContext context) async {
  TextEditingController controller = TextEditingController();
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Container(
                width: screenWidth / 3,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: kSecondaryColor.withOpacity(0.2), width: 1),
                ),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.done,
                    color: kGreenColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        );
      });
  return num.parse(controller.text);
}
