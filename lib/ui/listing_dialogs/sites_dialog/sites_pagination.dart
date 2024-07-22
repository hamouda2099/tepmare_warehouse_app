import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/ui/listing_dialogs/sites_dialog/sites_dialog.dart';


import '../../../config/constants.dart';
import '../../../logic/services/api_manager.dart';
import '../../../models/sites_model.dart';
import '../../components/page_and_limit_component.dart';


class SitesDialogPagination extends ConsumerWidget {
  SitesDialogPagination({super.key, required this.query});

  String query;
  final listViewRebuilding = StateProvider<String>((ref) => '');
  final pageProvider = StateProvider<int>((ref) => 1);
  final limitProvider = StateProvider<int>((ref) => 20);
  final selectedSearchWithProvider = StateProvider<String>((ref) => '');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) {
            ref.watch(listViewRebuilding);
            return Expanded(
              child: Center(
                child: FutureBuilder<SitesModel>(
                  future: ApiManager.getSites(
                    page: ref.read(pageProvider.notifier).state.toString(),
                    limit: ref.read(limitProvider.notifier).state.toString(),
                    query: query,
                  ),
                  builder: (BuildContext context,
                      AsyncSnapshot<SitesModel> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        {
                          return const CircularProgressIndicator(color: kSecondaryColor,);
                        }
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error.toString()}');
                        } else {
                          return (snapshot.data!.sites?.isEmpty ?? true)
                              ? const Text(
                                  'No Data',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: snapshot.data!.sites?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        SitesListDialog.selectedSite =
                                            snapshot.data?.sites?[index];
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: screenWidth / 2,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color:
                                              kSecondaryColor.withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          snapshot.data?.sites?[index].label ??
                                              "",
                                          style: const TextStyle(
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                        }
                    }
                  },
                ),
              ),
            );
          },
        ),
        PageAndLimitPagination(
          pageProvider: pageProvider,
          limitProvider: limitProvider,
          listViewRebuildingProvider: listViewRebuilding,
        ),
      ],
    );
  }
}
