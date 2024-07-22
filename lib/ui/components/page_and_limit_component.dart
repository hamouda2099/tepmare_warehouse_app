import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/constants.dart';

class PageAndLimitPagination extends ConsumerWidget {
  PageAndLimitPagination({
    required this.pageProvider,
    required this.limitProvider,
    required this.listViewRebuildingProvider,
  });

  StateProvider pageProvider, limitProvider, listViewRebuildingProvider;
  TextEditingController pageFieldController = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                if (ref.read(pageProvider.notifier).state > 1) {
                  ref.read(pageProvider.notifier).state--;
                  ref.read(listViewRebuildingProvider.notifier).state =
                      DateTime.now().toString();
                }
                pageFieldController.text =
                    ref.read(pageProvider.notifier).state.toString();
              },
              icon: const Icon(
                Icons.chevron_left,
                color: kPrimaryColor,
              ),
              tooltip: "Back",
            ),
            SizedBox(
              width: 100,
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: kPrimaryColor,
                ),
                controller: pageFieldController,
                textAlign: TextAlign.center,
                onEditingComplete: () {
                  try {
                    ref.read(pageProvider.notifier).state =
                        int.parse(pageFieldController.text.toString());
                    ref.read(listViewRebuildingProvider.notifier).state =
                        DateTime.now().toString();
                  } catch (e) {}
                },
              ),
            ),
            IconButton(
              onPressed: () {
                ref.read(pageProvider.notifier).state++;
                ref.read(listViewRebuildingProvider.notifier).state =
                    DateTime.now().toString();
                pageFieldController.text =
                    ref.read(pageProvider.notifier).state.toString();
              },
              icon: const Icon(
                Icons.chevron_right,
                color: kPrimaryColor,
              ),
              tooltip: "Next",
            ),
          ],
        ),
      ],
    );
  }
}
