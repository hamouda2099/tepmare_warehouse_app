import 'package:flutter/material.dart';

import '../../config/constants.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({
    required this.controller,
    required this.onChanged,
  });

  TextEditingController controller;
  Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: controller,
        onChanged: (val) {
          onChanged();
        },
        style: const TextStyle(
          color: kPrimaryColor,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: kPrimaryColor,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
