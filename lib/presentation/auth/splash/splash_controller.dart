import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future<void>.delayed(const Duration(seconds: 1), _restoreSession);
  }

  void _restoreSession() {
    final profile = LocalStorage.loginInfo["user_profile_name"]?.toString();

    // GetStorage is initialized before the app starts, so the saved session
    // is available here after a full application restart.
    switch (profile) {
      case "Student":
        if (LocalStorage.studentList.isNotEmpty &&
            _hasToken(LocalStorage.studentList.first)) {
          Get.offAllNamed(AppRoutes.studentUserList);
          return;
        }
        break;
      case "Teacher":
        if (_hasToken(LocalStorage.teacherModel)) {
          Get.offAllNamed(AppRoutes.teacherMain);
          return;
        }
        break;
      case "Admin":
        if (_hasToken(LocalStorage.adminModel)) {
          Get.offAllNamed(AppRoutes.adminMain);
          return;
        }
        break;
    }

    _openLogin();
  }

  bool _hasToken(Map<String, dynamic> user) =>
      user[CS.token]?.toString().isNotEmpty == true;

  void _openLogin() {
    if (Get.currentRoute != AppRoutes.login) {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<void> verifyOTP() async {
    Map<String, dynamic>? resJson;

    if (LocalStorage.loginInfo["user_profile_name"] != null) {
      if (await CU.checkInternet()) {
        if (LocalStorage.loginInfo["user_profile_name"] == "Student") {
          resJson = await ApiClient.call(
            Get.context,
            body: {
              CS.mobile: LocalStorage.studentList[0]["mobile"],
              CS.otp: LocalStorage.studentList[0]["otp"],
            },
            apiUrl: CS.student_check_otp,
            isShowProgressDialog: false,
          );
        } else if (LocalStorage.loginInfo["user_profile_name"] == "Teacher") {
          resJson = await ApiClient.call(
            Get.context,
            body: {
              CS.mobile: LocalStorage.teacherModel["mobile"],
              CS.otp: LocalStorage.teacherModel["otp"],
            },
            apiUrl: CS.teacher_check_otp,
            isShowProgressDialog: false,
          );
        } else if (LocalStorage.loginInfo["user_profile_name"] == "Admin") {
          resJson = await ApiClient.call(
            Get.context,
            body: {
              CS.mobile: LocalStorage.adminModel["mobile"],
              CS.otp: LocalStorage.adminModel["otp"],
            },
            apiUrl: CS.admin_check_otp,
            isShowProgressDialog: false,
          );
        }

        final response = resJson;
        if (response != null &&
            response[CS.status].toString() == StatusCode.Success) {
          if (LocalStorage.loginInfo["user_profile_name"] == "Student") {
            await LocalStorage.storeUserInfo(jsonEncode(response[CS.data]));
            await LocalStorage.storeLoginInfo(response[CS.data][0]);
            Get.offNamedUntil(
              AppRoutes.studentUserList,
              (route) => false,
            );
          } else if (LocalStorage.loginInfo["user_profile_name"] == "Teacher") {
            await LocalStorage.storeTeacherInfo(jsonEncode(response[CS.data]));
            await LocalStorage.storeLoginInfo(response[CS.data]);
            Get.offNamedUntil(
              AppRoutes.teacherMain,
              (route) => false,
            );
          } else if (LocalStorage.loginInfo["user_profile_name"] == "Admin") {
            await LocalStorage.storeAdminInfo(jsonEncode(response[CS.data]));
            await LocalStorage.storeLoginInfo(response[CS.data]);

            Get.offNamedUntil(
              AppRoutes.adminMain,
              (route) => false,
            );
          }
        } else {
          _openLogin();
        }
      } else {
        _openLogin();
      }
    } else {
      _openLogin();
    }
  }

  Map<String, dynamic> resJson = {};

  Future<void> callService() async {
    // A signed-out user must never be held on the splash screen by the
    // optional remote version check.
    if (LocalStorage.loginInfo["user_profile_name"] == null) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      _openLogin();
      return;
    }

    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String appVersion = packageInfo.version;

    log("App version $appVersion");

    if (await CU.checkInternet()) {
      try {
        resJson = await ApiClient.call(
          Get.context!,
          apiUrl: "https://erp.triz.co.in/api/playscreen",
          body: resJson,
          isShowProgressDialog: false,
        ).timeout(const Duration(seconds: 10));
      } catch (_) {
        _openLogin();
        return;
      }
    } else {
      _openLogin();
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      Map<String, dynamic> data;
      if (Platform.isIOS) {
        data = resJson[CS.data][CS.ios];
      } else {
        data = resJson[CS.data][CS.android];
      }
      log(data.toString());

      if (appVersion != data[CS.appVersion] && data[CS.isUpdate] == 1) {
        await CU.showUpdateDiloag(
            Get.context!, data[CS.message], data[CS.isComplusory]);

        // Non-compulsory update dialogs can be dismissed. Continue startup
        // instead of leaving the user on the splash screen.
        await verifyOTP();

        log(".............................UPDATE");
      } else if (data[CS.is_maintenance] == 1) {
        await CU.showMaintenanceDiloag(
            Get.context!, data[CS.maintenance_message], callService);

        log(".............................MAINTENANCE");
      } else {
        verifyOTP();

        log(".............................verifyOTP");
      }

      // dynamic userInfo = LocalStorage.loginInfo;

      // if (userInfo == null ||
      //     userInfo[CS.lms_user_id] == null ||
      //     userInfo[CS.lms_user_id].isEmpty) {
      //   if (userInfo == null ||
      //       userInfo['user_profile_name'] == null ||
      //       userInfo['user_profile_name'].isEmpty) {
      //     Future.delayed(
      //       const Duration(seconds: 2),
      //       () => {Get.offAllNamed(AppRoutes.login)},
      //     );
      //   } else {
      //     if (userInfo["user_profile_name"] == "Admin") {
      //       Future.delayed(
      //         const Duration(seconds: 2),
      //         () => {Get.offAllNamed(AppRoutes.adminMain)},
      //       );
      //     } else {
      //       Future.delayed(
      //         const Duration(seconds: 2),
      //         () => {Get.offAllNamed(AppRoutes.teacherMain)},
      //       );
      //     }
      //   }
      // } else {
      //   Future.delayed(
      //     const Duration(seconds: 2),
      //     () => {Get.offAllNamed(AppRoutes.studentUserList)},
      //   );
      // }
    } else {
      _openLogin();
    }
  }
}
