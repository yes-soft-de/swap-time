import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/subjects.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';
import 'package:swaptime_flutter/module_notifications/presistance/notification_prefs.dart';
import 'package:swaptime_flutter/utils/logger/logger.dart';

@provide
class FireNotificationService {
  final NotificationPrefs prefs;
  final ApiClient _client;

  FireNotificationService(
    this.prefs,
    this._client,
  );

  static final PublishSubject<String> _onNotificationRecieved =
      PublishSubject();
  static Stream get onNotificationStream => _onNotificationRecieved.stream;

  static StreamSubscription iosSubscription;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<void> init() async {
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {});

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
  }

  Future<void> refreshNotificationToken(String userAuthToken) async {
    var token = await _fcm.getToken();
    print('Token: $token');
    if (token != null && userAuthToken != null) {
      // Save the notification token
      await NotificationPrefs().saveNotification(token);
      // And send a copy for the Backend
      await _client.post(Urls.API_NOTIFICATION,
          {'date': DateTime.now().toIso8601String(), 'token': token},
          headers: {'Authorization': 'Bearer ' + userAuthToken});

      // And Subscribe to the changes
      this._fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          Logger().info('FireNotificationService', 'onMessage: $message');
          _onNotificationRecieved.add(message.toString());
        },
        onLaunch: (Map<String, dynamic> message) async {
          Logger().info('FireNotificationService', 'onMessage: $message');
        },
        onResume: (Map<String, dynamic> message) async {
          Logger().info('FireNotificationService', 'onMessage: $message');
        },
      );
    }
  }
}
