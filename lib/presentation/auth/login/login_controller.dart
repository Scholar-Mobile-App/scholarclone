import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import '../../../core/utils/cu.dart';
import '../../../core/utils/enum.dart';

class LoginController extends GetxController {
  RxBool isPasswordScreen = false.obs;
  RxBool passwordVisible = false.obs;
  RxBool isCallChkMobile = false.obs;

  RxString selectedLogin = "Student/Parents".obs;
  RxString passwordError = "".obs;
  RxString txtMobileError = "".obs;

  TextEditingController txtPassword = TextEditingController(text: "");
  TextEditingController txtMobile = TextEditingController(text: "");

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    if (kDebugMode) {
      txtMobile.text = "9979176562";
      txtPassword.text = "123456";
    }
    super.onInit();
  }

  bool isValidated() {
    bool isValid = true;
    passwordError.value = "";
    isMobileValidated();
    if (CU.isEmptyOrNull(txtPassword.text) ||
        txtPassword.text.length <= 5 ||
        txtPassword.text.length > 50) {
      passwordError.value = "Please enter your valid OTP.";
      isValid = false;
    }
    return isValid;
  }

  bool isMobileValidated() {
    bool isValid = true;
    txtMobileError.value = "";

    if (CU.isEmptyOrNull(txtMobile.text)) {
      txtMobileError.value = "Please enter your mobile.";
      isValid = false;
    }
    return isValid;
  }

  Future<void> verifyOTP() async {
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      CS.mobile: txtMobile.text,
      CS.otp: txtPassword.text,
    };

    Map<String, dynamic>? resJson;
    if (await CU.checkInternet()) {
      if (selectedLogin.value == "Student/Parents") {
        resJson = await ApiClient.call(
          Get.context,
          body: body,
          apiUrl: CS.student_check_otp,
          isShowProgressDialog: false,
        );
      } else if (selectedLogin.value == "Teacher/Staff") {
        resJson = await ApiClient.call(
          Get.context,
          body: body,
          apiUrl: CS.teacher_check_otp,
          isShowProgressDialog: false,
        );
      } else if (selectedLogin.value == "Admin/Trustee/Principal") {
        resJson = await ApiClient.call(
          Get.context,
          body: body,
          apiUrl: CS.admin_check_otp,
          isShowProgressDialog: false,
        );
      }
    } else {
      CU.showNoInternetDialog(Get.context!, verifyOTP);
      return;
    }

    if (resJson![CS.status].toString() == StatusCode.Success) {
      if (selectedLogin.value == "Student/Parents") {
        await LocalStorage.storeUserInfo(jsonEncode(resJson[CS.data]));
        await LocalStorage.storeLoginInfo(resJson[CS.data][0]);
        Get.offNamedUntil(
          AppRoutes.studentUserList,
          (route) => false,
        );
      } else if (selectedLogin.value == "Teacher/Staff") {
        await LocalStorage.storeTeacherInfo(jsonEncode(resJson[CS.data]));
        await LocalStorage.storeLoginInfo(resJson[CS.data]);
        Get.offNamedUntil(
          AppRoutes.teacherMain,
          (route) => false,
        );
      } else if (selectedLogin.value == "Admin/Trustee/Principal") {
        await LocalStorage.storeAdminInfo(jsonEncode(resJson[CS.data]));
        await LocalStorage.storeLoginInfo(resJson[CS.data]);

        Get.offNamedUntil(
          AppRoutes.adminMain,
          (route) => false,
        );
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      CU.showToast(Get.context!, resJson[CS.message]);
      // isPasswordScreen.value = false;
      txtPassword.clear();
      isLoading.value = false;
    }
    txtPassword.clear();
    isLoading.value = false;
  }

  Future<void> sendOTP(mobileNo) async {
    if (!isMobileValidated() || isCallChkMobile.value) return;
    isCallChkMobile.value = true;
    Map<String, dynamic> body = <String, dynamic>{
      CS.mobile: mobileNo,
    };

    Map<String, dynamic>? resJson;
    if (await CU.checkInternet()) {
      if (selectedLogin.value == "Student/Parents") {
        resJson = await ApiClient.call(Get.context,
            body: body, apiUrl: CS.student_login, isShowProgressDialog: false);
      } else if (selectedLogin.value == "Teacher/Staff") {
        resJson = await ApiClient.call(Get.context,
            body: body, apiUrl: CS.teacherlogin, isShowProgressDialog: false);
      } else if (selectedLogin.value == "Admin/Trustee/Principal") {
        resJson = await ApiClient.call(Get.context,
            body: body, apiUrl: CS.adminlogin, isShowProgressDialog: false);
      }
    } else {
      CU.showNoInternetDialog(Get.context!, sendOTP);
      isCallChkMobile.value = false;
      return;
    }

    if (resJson![CS.status].toString() == StatusCode.Success) {
      isCallChkMobile.value = false;
      isPasswordScreen.value = true;
      FocusScope.of(Get.context!).unfocus();

      txtMobileError.value = "";
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      txtMobileError.value = resJson[CS.message];
      isCallChkMobile.value = false;

      return;
    }
    isCallChkMobile.value = false;
  }
}
