import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';

import '../../config/constants.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  String? actionText,
  bool? error,
  Function? action,
  Color color = kPrimaryColor,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: SizedBox(
        height: 25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              error == true
                  ? Icons.info_outline_rounded
                  : Icons.check_circle_sharp,
              color: error == true ? Colors.red : kPrimaryColor,
              size: 20,
            ),
            10.w,
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: error == true ? Colors.red : kPrimaryColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            actionText == null
                ? const SizedBox()
                : InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      action!();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        actionText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: error == true ? Color(0xFFFFEFEF) : color,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
