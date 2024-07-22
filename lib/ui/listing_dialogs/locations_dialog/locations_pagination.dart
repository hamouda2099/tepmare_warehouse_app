import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../config/constants.dart';
import '../../../logic/services/api_manager.dart';
import '../../../models/locations_model.dart';
import '../../components/page_and_limit_component.dart';
import 'locations_dialog.dart';

class LocationsDialogPagination extends ConsumerWidget {
  LocationsDialogPagination({super.key, required this.query});

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
                child: FutureBuilder<LocationsModel>(
                  future: ApiManager.getLocations(
                    page: ref.read(pageProvider.notifier).state.toString(),
                    limit: ref.read(limitProvider.notifier).state.toString(),
                    query: query,
                  ),
                  builder: (BuildContext context,
                      AsyncSnapshot<LocationsModel> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        {
                          return CircularProgressIndicator();
                        }
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error.toString()}');
                        } else {
                          return (snapshot.data!.locations?.isEmpty ?? true)
                              ? const Text(
                                  'No Data',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount:
                                      snapshot.data!.locations?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        LocationsListDialog.selectedLocation =
                                            snapshot.data?.locations?[index];
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
                                          snapshot.data?.locations?[index]
                                                  .barcode ??
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
