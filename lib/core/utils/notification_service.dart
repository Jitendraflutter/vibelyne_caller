import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage rm) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
}

bool isFlutterLocalNotificationsInitialized = false;

/// Handle local notification and initialize
class NotificationServiceApi {
  static const String channelTitle = "Voicly notifications";
  static const String channelId = "voicly_channel";
  static const String channelDescription =
      'Get notifications about bookings, general requests etc.';

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void _onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    if (notificationResponse.payload != null) {
      final message = RemoteMessage.fromMap(
        jsonDecode(notificationResponse.payload!),
      );
      goRouteByNotification(message);
    }
  }

  ///
  static void _onDidReceiveNotificationBackgroundResponse(
    NotificationResponse notificationResponse,
  ) async {
    if (notificationResponse.payload != null) {
      final message = RemoteMessage.fromMap(
        jsonDecode(notificationResponse.payload!),
      );
      goRouteByNotification(message);
    }
  }

  /// Initialize local notification
  static Future<void> initializeLocalNotification() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    /// Local android notification settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Local ios notification settings
    final DarwinInitializationSettings
    iOSSettings = DarwinInitializationSettings(
      defaultPresentBadge: true,
      defaultPresentSound: true,
      // onDidReceiveLocalNotification:
      //     (int id, String? title, String? body, String? payload) async {
      //   // debugLog(
      //   //     "Flutter Notification :: onDidReceiveLocalNotification: called");
      // },
    );

    /// Local notification settings
    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    /// Initialize local notification plugin
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveNotificationBackgroundResponse,
    );

    /// Create a [AndroidNotificationChannel] for heads up notifications
    late AndroidNotificationChannel channel = const AndroidNotificationChannel(
      channelId, // id
      channelTitle, // title
      description: channelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await NotificationServiceApi.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

    /// local notification initialised
    isFlutterLocalNotificationsInitialized = true;
  }
}

Future<void> setupFlutterNotifications({bool? isFromBackground}) async {
  await FirebaseMessaging.instance.requestPermission();

  /// Initialise local notification
  await NotificationServiceApi.initializeLocalNotification();

  /// Observe and listen for new notification, [When app is in Foreground]
  // FirebaseMessaging.onMessage.listen(showFlutterNotification);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    showFlutterNotification(message);

    if (message.data["text"].toString().toLowerCase().contains(
      "scanned_coupon",
    )) {}
  });

  /// Listen for messages when app is in background.
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Listen when user click on the notification [When app is in background] Not terminated
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    goRouteByNotification(message);
  });

  /// FCM TOKEN
  print("FCM Token:${await FirebaseMessaging.instance.getToken()}");

  /// Check if the user is coming through notification click
  /// Put below code to your splash screen to navigate to a specific screen.
}

/// This method will show a notification in the notification bar
void showFlutterNotification(RemoteMessage rm) async {
  RemoteNotification? notification = rm.notification;
  AndroidNotification? android = rm.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    NotificationServiceApi.flutterLocalNotificationsPlugin.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationServiceApi.channelId,
          NotificationServiceApi.channelTitle,
          channelDescription: NotificationServiceApi.channelDescription,
          playSound: true,
          silent: false,
          icon: '@mipmap/ic_launcher',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: jsonEncode(rm.toMap()),
    );
  }
}

/// Notification route
void goRouteByNotification(RemoteMessage message) async {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // final text = (message.data["text"] ?? "").toString().toLowerCase();
    // final role = (LocalStorage.getUserRole()).toLowerCase();
    // if (text.contains("approvals")) {
    //   if (role == AppString.hotpotVendor) {
    //     Get.toNamed(Routes.VENDOR_SERVER_REQUEST);
    //   } else {
    //     Get.toNamed(Routes.SERVICE_REQUEST);
    //   }
    // } else if (text.contains("transaction")) {
    //   Get.toNamed(Routes.MEAL_HISTORY);
    // } else if (text.contains("coupons")) {
    //   if (role == AppString.hotpotVendor) {
    //     Get.offAllNamed(Routes.VENDOR_DASHBOARD, arguments: {"index": 1});
    //   } else if ([
    //     AppString.hotpotUser,
    //     AppString.hotpotAdmin,
    //     AppString.hotpotHr
    //   ].map((e) => e.toLowerCase()).contains(role)) {
    //     Get.offAllNamed(Routes.USER_DASHBOARD, arguments: {"index": 1});
    //   } else {
    //     debugPrint("Route not found");
    //   }
    // } else if (text.contains("meals")) {
    //   if (role == AppString.hotpotVendor) {
    //     Get.offAllNamed(Routes.VENDOR_DASHBOARD);
    //   } else {
    //     Get.offAllNamed(Routes.USER_DASHBOARD);
    //   }
    // } else {
    //   debugPrint("Route not found");
    // }
  });
}
