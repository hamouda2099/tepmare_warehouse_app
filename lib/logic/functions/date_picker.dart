import 'package:flutter/material.dart';

Future<String?> datePicker(BuildContext context) async {
  String? pickedDate;
  await showDatePicker(
    context: context,
    firstDate: DateTime.now(),
    lastDate: DateTime(2050),
  ).then((value) {
    if (value != null) {
      pickedDate =
          "${value.year}-${value.month < 10 ? "0${value.month}" : value.month}-${value.day < 10 ? "0${value.day}" : value.day}";
    }
  });
  return pickedDate;
}
