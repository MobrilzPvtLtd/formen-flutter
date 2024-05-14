// ignore_for_file: avoid_print

import 'package:dating/core/config.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


Future<void> initPlatformState() async {
  OneSignal.shared.setAppId(Config.oneSignel);
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {});
  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    print("Accepted OSPermissionStateChanges : $changes");
  });
  // print("--------------__uID : ${getData.read("UserLogin")["id"]}");
}