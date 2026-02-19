import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/network.dart';
import 'package:scholar_clone/presentation/auth/sign_up/sign_up_screen.dart';

class SignUpController extends GetxController {
  List userType = [
    {
      "type": "STUDENT",
      "image": AppImage.student,
    },
    {
      "type": "TEACHER",
      "image": AppImage.teacher,
    },
    {
      "type": "ADMIN",
      "image": AppImage.admin,
    },
  ];
  RxInt selectedIndex = 0.obs;
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString email = "".obs;
  RxString institudeName = "".obs;
  RxString mobile = "".obs;
  RxString selectedGender = "Male".obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxList<StandardModel> standardList = <StandardModel>[].obs;
  StandardModel? selectedStandard;

  RxBool isLoading = false.obs;

  var resJson;

  Future<void> callService() async {
    isLoading.value = true;
    if (await AppNetWork.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        isFormData: false,
        apiUrl: "https://erp.triz.co.in/trizStandardAPI",
        isShowProgressDialog: false,
      );
    } else {
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      resJson[CS.data].forEach((element) {
        standardList.add(StandardModel.fromJson(element));
      });
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
    isLoading.value = false;
  }

  Future<void> callServiceStudent() async {
    Map<String, dynamic> body = <String, dynamic>{
      "user_type": "Student",
      "first_name": firstName.value,
      "last_name": lastName.value,
      "gender": selectedGender.value == "Male" ? "M" : "F",
      "birthdate": selectedDate.value.toString().substring(0, 11),
      "email": email.value,
      "mobile": mobile.value,
      "institute_name": institudeName.value,
      "standard": selectedStandard!.gradeId,
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/api/NewLMS_temp_signup_student",
        isShowProgressDialog: true,
      );

      log(resJson.toString());
      log(resJson[CS.status].toString());
      log(resJson['message']);
      log("----------------------------");
    } else {
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      if (resJson['message'] is String) {
        Get.back();

        Fluttertoast.showToast(
          msg: "Signup successfully",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        showDialog(
          builder: (context) => CU.showDiloag(context, "Invalid Information"),
          barrierDismissible: false,
          context: Get.context!,
        );
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceTeacherAndAdmin() async {
    Map<String, dynamic> body = <String, dynamic>{
      "user_type": selectedIndex.value == 1 ? "LMS Teacher" : "Admin",
      "first_name": firstName.value,
      "last_name": lastName.value,
      "gender": selectedGender.value == "Male" ? "M" : "F",
      "birthdate": selectedDate.value.toString().substring(0, 11),
      "email": email.value,
      "mobile": mobile.value,
      "institute_name": institudeName.value,
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/api/NewLMS_temp_signup",
        isShowProgressDialog: true,
      );
    } else {
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      if (resJson['message'] is String) {
        Fluttertoast.showToast(
          msg: "Signup successfully",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => WebViewPage(
        //       "Sign Up",
        //       "http://erp.triz.co.in/",
        //     ),
        //   ),
        // );
      } else {
        showDialog(
          builder: (context) => CU.showDiloag(context, "Invalid Information"),
          barrierDismissible: false,
          context: Get.context!,
        );
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
          builder: (context) => CU.showDiloag(context, resJson[CS.message]),
          barrierDismissible: false,
          context: Get.context!);
    }
  }

  @override
  void onInit() {
    callService().then((_) => selectedStandard = standardList[0]);
    super.onInit();
  }
}
