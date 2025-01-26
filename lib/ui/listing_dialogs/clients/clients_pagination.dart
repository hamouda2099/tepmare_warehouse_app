import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants.dart';
import '../../../logic/services/api_manager.dart';
import '../../../models/clients_model.dart';
import '../../components/page_and_limit_component.dart';
import 'clients_dialog.dart';


class ClientsDialogPagination extends ConsumerWidget {
  ClientsDialogPagination({super.key, required this.query});

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
                child: FutureBuilder<ClientsModel>(
                  future: ApiManager.getClients(
                    page: ref.read(pageProvider.notifier).state.toString(),
                    limit: ref.read(limitProvider.notifier).state.toString(),
                    query: query,
                  ),
                  builder: (BuildContext context,
                      AsyncSnapshot<ClientsModel> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        {
                          return const CircularProgressIndicator();
                        }
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error.toString()}');
                        } else {
                          return (snapshot.data!.clients?.isEmpty ?? true)
                              ? const Text(
                                  'No Data',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount:
                                      snapshot.data!.clients?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          ClientsListDialog.selectedClient =
                                              snapshot.data?.clients?[index];
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: screenWidth / 2,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: kSecondaryColor
                                                .withOpacity(0.05),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            snapshot.data?.clients?[index]
                                                    .username ??
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
