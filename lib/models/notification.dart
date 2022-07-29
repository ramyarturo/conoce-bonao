import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationModel {
  int id;
  String title;
  String body;
  DateTime sentAt;
  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.sentAt,
  });

  factory NotificationModel.fromMap(map) {
    return NotificationModel(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      sentAt: DateTime.fromMillisecondsSinceEpoch(map['sentAt'] as int),
    );
  }
  factory NotificationModel.fromRemoteMessage(RemoteMessage remoteMessage) {
    final data = remoteMessage.data;
    final messageNotification = remoteMessage.notification;
    String title = messageNotification?.title ?? data['title'];
    String body = messageNotification?.body ?? data['body'];

    return NotificationModel(
      id: 0,
      title: title,
      body: body,
      sentAt: remoteMessage.sentTime ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'sentAt': sentAt.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
