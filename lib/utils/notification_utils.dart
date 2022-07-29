import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:conoce_bonao/models/notification.dart';

class NotificationUtils {
  static final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static init() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('launch_background');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static show(NotificationModel notificationModel) async {
    const platformChannelSpecifics = NotificationDetails(
      android: NotificationChannels.mainChannel,
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      notificationModel.title,
      notificationModel.body,
      platformChannelSpecifics,
      payload: notificationModel.toJson(),
    );
  }
}

abstract class NotificationChannels {
  static const mainChannel = AndroidNotificationDetails(
    'main channel',
    'Notificaciones importantes',
    channelDescription: 'Notificaciones importantes',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );
}
