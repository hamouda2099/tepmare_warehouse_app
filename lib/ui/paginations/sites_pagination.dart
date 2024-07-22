import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/models/sites_model.dart';
import 'package:tepmare_warehouse_man_app/ui/components/site_item.dart';


import '../../../config/constants.dart';
import '../../../logic/services/api_manager.dart';

/// Two variables in this class, first one is the function that returns list of data from api, second one is the custom widget that ListView.builder will return.
/// To use this custom pagination list you have to change that function and returned widget.
class SitesPagination extends ConsumerWidget {
  SitesPagination({this.query});

  String? query;
  ScrollController scrollController = ScrollController();
  int limit = 10;
  int page = 1;
  bool isLastPage = false;
  bool isFetchingData = false;
  bool initState = false;
  final centerLoadingProvider = StateProvider<bool>((ref) => false);
  final bottomLoadingProvider = StateProvider<bool>((ref) => false);
  List fetchedData = [];

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
        SitesModel sitesModel = await ApiManager.getSites(
          page: page.toString(),
          limit: limit.toString(),
          query: query??"",
        );
        List<Site>? tempFetchedData = sitesModel.sites;
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
            SiteItem(
              fetchedData[index],
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
