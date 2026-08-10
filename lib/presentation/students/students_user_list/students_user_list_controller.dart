import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

class StudentUserListController extends GetxController {
  @override
  void onInit() {
    callService();
    userInfo = LocalStorage.studentList;

    log("UserINFO $userInfo");
    log("LOCAL DATA ${LocalStorage.studentList}");
    super.onInit();
  }

  Map<String, dynamic> resJson = {};
  List<dynamic> userInfo = [];
  HomeDataModel? homeData;

  Future<void> callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      "user_profile_name": LocalStorage.studentList[0]["user_profile_name"],
      "user_profile_id": LocalStorage.studentList[0]["user_profile_id"],
      "sub_institute_id": LocalStorage.studentList[0]["sub_institute_id"],
      CS.token: await LocalStorage.studentList[0]["token"],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: CS.homeScreen,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      HomeDataModel homeDataModel = HomeDataModel.fromJson(resJson);
      homeData = homeDataModel;
      callGcmInsertService();
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callGcmInsertService() async {
    Map<String, dynamic> resJson;

    final fcmToken = await _getFcmToken();
    if (fcmToken == null || fcmToken.isEmpty) {
      log('FCM token is not available yet');
      return;
    }
    LocalStorage.gcmToken = fcmToken;

    log("GCM REG ID $fcmToken");

    Map<String, dynamic> body = <String, dynamic>{
      CS.type: "API",
      CS.token: userInfo[0][CS.token],
      CS.mobile_no: userInfo[0][CS.mobile],
      CS.sub_institute_id: userInfo[0][CS.sub_institute_id],
      CS.gcm_regid: fcmToken,
      CS.imei_no: await getDeviceId(),
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(Get.context,
          body: body, apiUrl: CS.chkGcmInsert, isShowProgressDialog: false);
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<String?> _getFcmToken() async {
    try {
      final messaging = FirebaseMessaging.instance;
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        log('Notification permission was denied');
        return null;
      }

      // On Apple platforms Firebase cannot issue an FCM token until APNs has
      // registered the device. This can take a moment after permission is
      // granted, especially on the first app launch.
      if (Platform.isIOS) {
        String? apnsToken;
        for (var attempt = 0; attempt < 10 && apnsToken == null; attempt++) {
          apnsToken = await messaging.getAPNSToken();
          if (apnsToken == null) {
            await Future<void>.delayed(const Duration(milliseconds: 500));
          }
        }
        if (apnsToken == null) {
          log('APNs token is not available; FCM registration postponed');
          return null;
        }
      }

      return await messaging.getToken();
    } catch (error, stackTrace) {
      log('Unable to obtain FCM token', error: error, stackTrace: stackTrace);
      return null;
    }
  }

  Future getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }
}
