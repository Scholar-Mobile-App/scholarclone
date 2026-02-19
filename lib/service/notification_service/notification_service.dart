import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../core/utils/cs.dart';
import 'helper.dart';

abstract class NotificationService {
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  static AndroidNotificationChannel? channel;
  static bool isConfigured = true;
  static bool isOnMessageStart = false;
  static final GlobalKey<ScaffoldState> scaffoldkey =
      GlobalKey<ScaffoldState>();

  static init() async {
    FirebaseMessaging.instance.requestPermission();
    firebaseinit();
    firebaseMessaging();
  }

  static firebaseinit() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      playSound: true,
      importance: Importance.max,
    );
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_small_notification');
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin!.initialize(
      initializationSettings,
    );
  }

  static firebaseMessaging() {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) async {
        log("Message $message");

        if (message != null) {
          getNotificationCounter();
          showNotification(message);
        } else {
          getNotificationCounter();
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      showNotification(message);
      log('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    log('Handling a background message ${message.messageId}');
    incrementNotificationCounter();
  }

  static showNotification(RemoteMessage msg) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel!.id,
      channel!.name,
      importance: Importance.high,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin!.show(
        msg.notification.hashCode,
        msg.notification!.title,
        msg.notification!.body,
        platformChannelSpecifics,
        payload: msg.notification!.body,
      );
    } else {
      await flutterLocalNotificationsPlugin!.show(
        msg.notification.hashCode,
        msg.notification!.title,
        msg.notification!.body,
        platformChannelSpecifics,
        payload: msg.notification!.body,
      );
    }
  }

  static Future onSelectNotification(String payload) async {
    if (!isOnMessageStart) return;
    if (isConfigured) {
      isConfigured = false;
      Map<String, dynamic> message = jsonDecode(payload);
      navigateToItemDetail(scaffoldkey.currentContext,
          Platform.isIOS ? message : message[CS.data]);
    } else {
      isConfigured = true;
    }
  }

  static Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: scaffoldkey.currentContext!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                new MaterialPageRoute(
//                  builder: (context) => new ExamListScreen("exam1"),
//                ),
//              );
            },
          )
        ],
      ),
    );
  }

  static navigateToItemDetail(context, data) {
    if (data[CS.isRedirect] == "1") {
      if (data[CS.isRead] == "0") {
        //        CU.NotificationRead(context, data[CS.notificationID]);
        log(data.toString());
      }
      log("====================================1=========");
//      log(Data[CS.notiAdditionalData]);
//      Map<String, dynamic> Cell = jsonDecode(Data[CS.notiAdditionalData]);
      log("=============================================");
//      log(Cell.toString());
//      onSelectRedirectScreen(context, Data[CS.redirectScreen].toString(), Cell);
    }
  }
}
