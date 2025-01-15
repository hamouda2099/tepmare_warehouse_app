import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import '../../config/constants.dart';

class DeviceData {
  static Future<DeviceModel> getDeviceInfo() async {
    Map? mobileInfo = {};
    String? fcmToken = '';
    try {
      mobileInfo = await getMobileInfo();
      // fcmToken = await getFcmToken();
    } catch (_) {}
    return DeviceModel(
      appVersion: appVersion,
      fcmToken: fcmToken ?? '-',
      mobileOS: mobileInfo?['mobileOS'] ?? '-',
      mobileOSVersion: mobileInfo?['mobileOSVersion'] ?? '-',
      mobileBrand: mobileInfo?['mobileBrand'] ?? '-',
      mobileModel: mobileInfo?['mobileModel'] ?? '-',
    );
  }

  static Future<Map<String, String>?> getMobileInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, String> _deviceData = <String, String>{};

    Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
      return <String, dynamic>{
        'version.release': build.version.release,
        'brand': build.brand,
        'model': build.model,
      };
    }

    Map<String, dynamic> readIosDeviceInfo(IosDeviceInfo data) {
      return <String, dynamic>{
        'systemVersion': data.systemVersion,
        'model': data.model,
        'name': data.name,
        'systemName': data.systemName,
        'localizedModel': data.localizedModel,
        'identifierForVendor': data.identifierForVendor,
        'isPhysicalDevice': data.isPhysicalDevice,
        'utsname.sysname:': data.utsname.sysname,
        'utsname.nodename:': data.utsname.nodename,
        'utsname.release:': data.utsname.release,
        'utsname.version:': data.utsname.version,
        'utsname.machine:': data.utsname.machine,
      };
    }

    Map<String, dynamic> deviceData;
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        _deviceData['mobileOS'] = 'android';
        _deviceData['mobileOSVersion'] = deviceData['version.release'] ?? '-';
        _deviceData['mobileBrand'] = deviceData['brand'] ?? '-';
        _deviceData['mobileModel'] = deviceData['model'] ?? '-';
        return _deviceData;
      } else if (Platform.isIOS) {
        deviceData = readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        _deviceData['mobileOS'] = 'ios';
        _deviceData['mobileOSVersion'] = deviceData['systemVersion'] ?? '-';
        _deviceData['mobileBrand'] = deviceData['iPhone'] ?? '-';
        _deviceData['mobileModel'] = deviceData['model'] ?? '-';
        return _deviceData;
      }
    } on PlatformException {
      _deviceData['mobileOS'] = 'not_found';
      _deviceData['mobileOSVersion'] = 'not_found';
      _deviceData['mobileBrand'] = 'not_found';
      _deviceData['mobileModel'] = 'not_found';
      return _deviceData;
    }
    return null;
  }

  // static Future<String> getFcmToken() async {
  //   try {
  //     FirebaseMessaging messaging = FirebaseMessaging.instance;
  //     await messaging.deleteToken();
  //     String? fcmToken = await messaging.getToken(
  //       vapidKey: vapidKey,
  //     );
  //     return fcmToken ?? '-';
  //   } catch (e) {
  //     print(e);
  //     return e.toString();
  //   }
  // }
}

class DeviceModel {
  DeviceModel({
    this.fcmToken,
    this.appVersion,
    this.mobileOS,
    this.mobileOSVersion,
    this.mobileBrand,
    this.buildNumber,
    this.mobileModel,
  });

  String? fcmToken;
  String? appVersion;
  String? mobileOS;
  String? buildNumber;
  String? mobileOSVersion;
  String? mobileBrand;
  String? mobileModel;
}
