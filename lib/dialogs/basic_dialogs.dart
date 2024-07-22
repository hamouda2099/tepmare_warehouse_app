import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../main.dart';

class Dialogs {
  void loadingDialog(BuildContext context) {
    // Functions().closeKeyBoard();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Center(
          child: Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kBackgroundColor,
            ),
            child: const SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
          ),
        );
      },
    );
  }

  void messageDialog(
    BuildContext context,
    String message, {
    Function? function,
  }) {
    // Functions().closeKeyBoard();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: kBackgroundColor,
        contentPadding: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 40, bottom: 40),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  color: kSecondaryColor,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (function == null) {
                  Navigator.pop(_);
                } else {
                  function();
                }
              },
              child: Container(
                width: screenWidth,
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                ),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    function == null ? ('Close'.tr()) : ('Ok'.tr()),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
