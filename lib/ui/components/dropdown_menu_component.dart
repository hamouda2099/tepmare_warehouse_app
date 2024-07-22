import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/constants.dart';

class DropdownMenuComponent extends ConsumerWidget {
  DropdownMenuComponent({
    super.key,
    required this.valueProvider,
    required this.items,
    required this.icon,
    required this.hintText,
  });

  StateProvider valueProvider;
  List items = [];
  IconData icon;
  String hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(valueProvider);
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Column(
        children: [
          DropdownButton(
            borderRadius: BorderRadius.circular(10),
            dropdownColor: Colors.white,
            underline: const SizedBox(),
            isExpanded: true,
            iconSize: 20,
            value: items.contains(value) ? value : null,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: kPrimaryColor,
            ),
            hint: Text(
              hintText,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            onChanged: (newValue) {
              ref.read(valueProvider.notifier).state = newValue;
            },
            items: items.map((location) {
              return DropdownMenuItem(
                value: location,
                child: Text(
                  location.toString(),
                  style: const TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
              );
            }).toList(),
          ),
          Divider(color: kGreyColor,)
        ],
      ),
    );
  }
}
