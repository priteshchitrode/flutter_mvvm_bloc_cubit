import 'dart:async';
import 'dart:convert';
import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/data/storage/secured_shared_preferences.dart';
import 'package:flutter_mvvm_bloc_cubit/service/push_notification/notification_helper.dart';
import 'package:flutter_mvvm_bloc_cubit/service/push_notification/notification_payload.dart';
import 'package:flutter_mvvm_bloc_cubit/service/push_notification/notification_view.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_string.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/custom_log.dart';

class NotificationService {
  final SecuredSharedPreferences _secureSharedPrefs;
  NotificationService(this._secureSharedPrefs) {
    _notificationAllowPermission();
    _notificationChannel();
    getFcmToken();
    _displayNotification();
    _onClickBackgroundState();
    _onClickTerminateState();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    AwesomeNotifications().setListeners(onActionReceivedMethod: _receivedNotification);
  }

  final NotificationView _notificationView = NotificationView();

  int badgeCount = 0;

  /// Increment the badge count and update the app icon
  Future<void> _incrementBadgeCount() async {
    badgeCount++;
    if (await AppBadgePlus.isSupported()) {
      // Set badge
      AppBadgePlus.updateBadge(badgeCount);
    } else {
      CustomLog.debug(this, "App badge not supported on this device.");
    }
    CustomLog.debug(this, "Badge Count : $badgeCount");
  }

  /// Reset the badge count
  Future<void> clearBadgeCount() async {
    badgeCount = 0;
    if (await AppBadgePlus.isSupported()) {
      AppBadgePlus.updateBadge(0);
    }
    CustomLog.debug(this, "Badge Count Clear : $badgeCount");
  }

  /// Request permission for notifications on iOS and Android (Android 13 and above)
  Future<void> _notificationAllowPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        sound: true,
        provisional: false,
        criticalAlert: false,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      } else {
        debugPrint('User declined or has not accepted permission');
      }
    } catch (e) {
      CustomLog.error(NotificationService, "Notification request permission error : ", e);
    }
  }

  /// Get FCM TOKEN
  Future<void> getFcmToken() async {
    try {
      await Firebase.initializeApp().then(
        (value) => {
          FirebaseMessaging.instance.getToken().then((value) async {
            FirebaseMessaging.instance.subscribeToTopic('global');
            String token = value ?? "";
            CustomLog.debug(NotificationService, "Fcm Token : ${token.trim()}");
            await _secureSharedPrefs.saveKey(AppString.sessionKey.fcmToken, token.trim());
          }),
        },
      );
    } catch (e) {
      CustomLog.error(NotificationService, "Get FCM TOKEN error", e);
    }
  }

  /// Method to clear/delete FCM token
  Future<void> clearFcmToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
      CustomLog.debug(NotificationService, "FCM token cleared successfully");
    } catch (e) {
      CustomLog.error(NotificationService, "Failed to clear FCM token", e);
    }
  }

  /// Notification Channel
  void _notificationChannel() {
    try {
      AwesomeNotifications().initialize(
        'resource://mipmap/ic_launcher',
        [
          NotificationChannel(
            channelGroupKey: 'General',
            channelKey: 'general_channel',
            channelName: 'General notifications',
            channelDescription: 'All general notification for latest offers & coupon',
            importance: NotificationImportance.Max,
            channelShowBadge: false,
            icon: 'resource://mipmap/ic_launcher',
            playSound: true,
            defaultRingtoneType: DefaultRingtoneType.Notification,
          ),
        ],
        channelGroups: [NotificationChannelGroup(channelGroupKey: 'General', channelGroupName: 'General notifications')],
        debug: false,
      );
      CustomLog.debug(NotificationService, "Notification Channel Initialize successfully");
    } catch (e) {
      CustomLog.error(NotificationService, "Notification Channel error", e);
    }
  }

  /// Notification Payload
  Future<Map<String, String?>> _notificationPayload(RemoteMessage message) async {
    Map<String, String> valueMap = {};
    try {
      String raw = message.data.toString();
      String jsonString = NotificationHelper.convertToJsonStringQuotes(raw: raw);
      final Map<String, dynamic> result = json.decode(jsonString);
      valueMap = result.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      CustomLog.error(NotificationService, "Payload error", e);
    }
    return valueMap;
  }

  /// Notification Display Method
  void _displayNotification() {
    try {
      FirebaseMessaging.onMessage.listen((message) async {
        _incrementBadgeCount();
        await _notificationView.display(message: message, payload: await _notificationPayload(message));
      });
    } catch (e) {
      CustomLog.error(NotificationService, "Display Notification error", e);
    }
  }

  /// Firebase Messaging BackgroundHandler
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    try {
      CustomLog.debug(NotificationView, "Notification Full payload data : ${message.toMap()}");
      NotificationPayload payload = NotificationPayload.fromJson(message.data);
      AppBadgePlus.updateBadge(1);
      if (payload.route != null) {
        //navigatorKey.currentState?.context.push(payload.route!);
      }
    } catch (e) {
      CustomLog.error(NotificationService, "Background click error", e);
    }
  }

  /// On Click Foreground State
  @pragma("vm:entry-point")
  static Future<void> _receivedNotification(ReceivedAction receivedAction) async {
    try {
      NotificationPayload payload = NotificationPayload.fromJson(receivedAction.payload ?? {});
      CustomLog.debug(NotificationService, "Payload : $payload");
      if (payload.route != null) {
        //navigatorKey.currentState?.context.push(payload.route!);
      }
    } catch (e) {
      CustomLog.error(NotificationService, "Foreground click error", e);
    }
  }

  /// On Click Terminate State
  Future<void> _onClickTerminateState() async {
    try {
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          NotificationPayload payload = NotificationPayload.fromJson(message.data);
          _handleNotificationClick(payload, "On Terminate state");
        }
      });
    } catch (e) {
      CustomLog.error(NotificationService, "Terminate State Notification error", e);
    }
  }

  /// On Click Background State
  Future<void> _onClickBackgroundState() async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // TODO : Convert message.data into model
      NotificationPayload payload = NotificationPayload.fromJson(message.data);
      _handleNotificationClick(payload, "On background state");
    });
  }

  // TODO : Take only notification payload model as a parameter & if model.rout != null ? navigate to screen :
  void _handleNotificationClick(NotificationPayload payload, String consolePrint) {
    CustomLog.debug(NotificationService, "$consolePrint : $payload");
    if (payload.route != null) {
      // navigatorKey.currentState?.context.push(payload.route!);
    }
  }

}
