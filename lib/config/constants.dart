import 'dart:io';

import 'package:flutter/material.dart';

double screenHeight = 0.0, screenWidth = 0.0;

String apiKey = 'AIzaSyAcMYqmCXFOkELQwF2kmjz3knwmXH0d88A';
const String appVersion = '1.0.7';
num? buildNumber = Platform.isAndroid
    ? 12
    : Platform.isIOS
    ? 9
    : null;
String localLanguage = 'en';
List<BoxShadow> boxShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.3),
    spreadRadius: 1,
    blurRadius: 1,
    offset: const Offset(0, 0),
  )
];
const Color kPrimaryColor = Color(0xFF03263F);
const Color kGreenColor = Color(0xFF17A200);
const Color kGreyColor = Color(0xFF4E4E4E);
const Color kSecondaryColor = Color(0xFF2196F3);
const Color kBackgroundColor = Color(0xFFFFFFFF);
