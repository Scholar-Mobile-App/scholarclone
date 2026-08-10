import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';
import 'package:scholar_clone/routes/app_routes.dart';
import 'package:scholar_clone/service/notification_service/app_life_cycle_handler.dart';
import 'package:scholar_clone/service/notification_service/helper.dart';

import 'service/notification_service/notification_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
    incrementNotificationCounter();
  } catch (e) {
    debugPrint('Firebase background initialization failed: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var firebaseReady = false;

  try {
    await Firebase.initializeApp();
    firebaseReady = true;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {
    // Firebase initialization failed - continue without Firebase
    debugPrint('Firebase initialization failed: $e');
  }


  if (firebaseReady) {
    await NotificationService.init();
  }

  await GetStorage.init();
  LocalStorage.loadLocalData();
  WidgetsBinding.instance.addObserver(
    LifecycleEventHandler(resumeCallBack: () async {
      getNotificationCounter().then(
        (value) {
          LocalStorage.notificationCount.value = value;
        },
      );
    }),
  );
  runApp(const MyApp());
  // ignore: deprecated_member_use
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'Scholar Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "GoogleSans-Regular",
        hintColor: CU.textColorhint,
        primaryColor: CU.primaryColor,
        textSelectionTheme:
            TextSelectionThemeData(selectionColor: CU.primaryColor),
      ),
      initialRoute: AppRoutes.splash, //AppRoutes.leaveRequests,
      getPages: AppRoutes.pages,
    );
  }
}
