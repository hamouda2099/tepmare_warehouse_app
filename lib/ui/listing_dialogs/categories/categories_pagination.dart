import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../config/constants.dart';
import '../../../logic/services/api_manager.dart';
import '../../../models/categories_model.dart';
import '../../components/page_and_limit_component.dart';
import 'categories_dialog.dart';

class CategoriesDialogPagination extends ConsumerWidget {
  CategoriesDialogPagination({super.key, required this.query});

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
                child: FutureBuilder<CategoriesModel>(
                  future: ApiManager.getCategories(
                    page: ref.read(pageProvider.notifier).state.toString(),
                    limit: ref.read(limitProvider.notifier).state.toString(),
                    query: query,
                  ),
                  builder: (BuildContext context,
                      AsyncSnapshot<CategoriesModel> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        {
                          return const CircularProgressIndicator();
                        }
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error.toString()}');
                        } else {
                          return (snapshot.data!.categories?.isEmpty ?? true)
                              ? const Text(
                                  'No Data',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount:
                                      snapshot.data!.categories?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          CategoriesListDialog.selectedCategory =
                                              snapshot.data?.categories?[index];
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
                                            snapshot.data?.categories?[index]
                                                    .label ??
                                                "",
                                            style: const TextStyle(
                                              color: kPrimaryColor,
                                            ),
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
