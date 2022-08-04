import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/controllers/notification_controller.dart';
import 'package:conoce_bonao/models/notification.dart';
import 'package:conoce_bonao/utils/notification_utils.dart';

class NotificationService extends GetxService {
  @override
  void onReady() {
    super.onReady();
    _init();
  }

  _init() async {
    await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = NotificationModel.fromRemoteMessage(message);
      notificationController.onNewNotification(notification);
    });
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  }
}

Future _onBackgroundMessage(RemoteMessage message) async {
  final isolate = IsolateNameServer.lookupPortByName(NotificationController.backgroundIsolatePort);
  isolate?.send(message);
}
