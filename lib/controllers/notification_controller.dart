import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:conoce_bonao/models/notification.dart';

import '../ui/notifications/components/single_notification_item.dart';
import '../utils/notification_utils.dart';

class NotificationController extends GetxController {
  static const String notificationBoxKey = "notification_box";
  static const String backgroundIsolatePort = "main_port";

  final notificationList = <NotificationModel>[].obs;
  final animatedKeyList = GlobalKey<AnimatedListState>();
  late Box<Map> _hive;
  final List<StreamSubscription> _subscriptions = [];

  @override
  void onReady() async {
    super.onReady();
    _hive = await Hive.openBox(notificationBoxKey);
    _loadNotifications();
    _listenBackgroundNotificationsIsolate();

    ever<List<NotificationModel>>(notificationList, (list) async {
      await _hive.clear();
      _hive.addAll(list.map((element) => element.toMap()));
    });
  }

  _listenBackgroundNotificationsIsolate() {
    ReceivePort receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(receivePort.sendPort, backgroundIsolatePort);

    final isolateSubscription = receivePort.listen((message) {
      if (message is RemoteMessage) {
        final notification = NotificationModel.fromRemoteMessage(message);
        onNewNotification(notification);
      }
    });
    _subscriptions.add(isolateSubscription);
  }

  _loadNotifications() async {
    notificationList.value = _hive.values.map(NotificationModel.fromMap).toList();
  }

  onNewNotification(NotificationModel notification) {
    NotificationUtils.show(notification);
    notificationList.add(notification);
    animatedKeyList.currentState?.insertItem(0, duration: 500.milliseconds);
  }

  clearNotifications() async {
    for (var item in notificationList) {
      animatedKeyList.currentState?.removeItem(0, (_, animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: SingleNotificationItem(notification: item),
          ),
        );
      }, duration: 300.milliseconds);

      await Future.delayed(50.milliseconds);
    }
    notificationList.clear();
  }

  @override
  void onClose() {
    super.onClose();
    for (var element in _subscriptions) {
      element.cancel();
    }
  }
}
