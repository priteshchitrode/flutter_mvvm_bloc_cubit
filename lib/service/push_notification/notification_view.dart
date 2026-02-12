import 'dart:convert';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/custom_log.dart';

class NotificationView {
  /// Display Notification View
  Future<void> display({required RemoteMessage message, Map<String, String?>? payload}) async {
    final prettyBodyString = const JsonEncoder.withIndent('  ').convert(message.data);
    CustomLog.debug(NotificationView, "\nNotification full data : ${message.toMap()}, \n\nNotification payload data : $prettyBodyString");
    await _notificationBodyView(message: message, payload: payload);
  }

  Future<void> _notificationBodyView({required RemoteMessage message, Map<String, String?>? payload}) async {
    int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    String? bigPicture;
    if (Platform.isIOS) {
      bigPicture = message.notification?.apple?.imageUrl;
    } else {
      bigPicture = message.notification?.android?.imageUrl;
    }
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'general_channel',
        title: message.notification?.title,
        body: message.notification?.body,
        backgroundColor: AppColors.secondaryColor,
        notificationLayout: bigPicture != null ? NotificationLayout.BigPicture : NotificationLayout.Default,
        bigPicture: bigPicture,
        payload: payload,
        hideLargeIconOnExpand: true,
        displayOnBackground: true,
        wakeUpScreen: true,
        displayOnForeground: true,
      ),
    );
    await AwesomeNotifications().incrementGlobalBadgeCounter();
  }

}
