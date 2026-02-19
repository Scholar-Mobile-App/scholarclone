import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/punch_in_out_info_model.dart';

class PunchInOutController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  final RxBool isLoading = false.obs;
  final RxBool isPunchLoading = false.obs;

  final RxString currentAddress = 'Fetching address...'.obs;
  var currentPosition = Rxn<Position>();

  final Rx<File?> imageFile = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  final RxString currentTime = ''.obs;

  Rx<PunchInOutInfoModel> punchInOutInfoModel = PunchInOutInfoModel().obs;
  late Timer _timer;

  Map<String, dynamic> statusRes = {};
  Map<String, dynamic> resJson = {};

  @override
  void onInit() {
    super.onInit();
    _updateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime();
    });
    callServicePunchStatus(isInit: true);
  }

  void _updateTime() {
    final now = DateTime.now();
    currentTime.value = DateFormat('hh:mm:ss a').format(now);
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Future<void> determinePosition() async {
    isPunchLoading.value = true;
    // bool serviceEnabled;
    LocationPermission permission;

    // Check permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isPunchLoading.value = false;
        currentAddress.value = 'Location permissions are denied';
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      openAppSettings();
      isPunchLoading.value = false;
      currentAddress.value = 'Location permissions are permanently denied.';
      return;
    }

    // Get position
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.best));
    currentPosition.value = position;

    // Get address
    await getAddressFromLatLng(position);
    takePhoto();
  }

  Future<void> getAddressFromLatLng(Position position) async {
    try {
      log("latitude ${position.latitude}");
      log("longitude ${position.longitude}");

      currentAddress.value = "${position.latitude}, ${position.longitude}";
    } catch (e) {
      currentAddress.value = "Failed to get address: $e";
    }
  }

  // Future<void> takePhoto() async {
  //   final status = await Permission.camera.request();
  //   log(status.name);
  //   if (status.isGranted) {
  //     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  //     if (pickedFile != null) {
  //       imageFile.value = File(pickedFile.path);
  //       if (!(punchInOutInfoModel.value.buttonDisable ?? false)) {
  //         punchInOutInfoModel.value.button == "out"
  //             ? callServicePunchOut()
  //             : callServicePunchIN();
  //       }
  //     } else {
  //       isPunchLoading.value = false;
  //     }
  //   } else if (status.isPermanentlyDenied) {
  //     await openAppSettings();
  //     isPunchLoading.value = false;
  //     log("HELLO");
  //   } else {
  //     Get.snackbar("Permission Denied", "Camera access is required");
  //     isPunchLoading.value = false;
  //   }
  // }

  Future<void> takePhoto() async {
    isPunchLoading.value = true;

    try {
      // Step 1: Request Camera Permission
      final status = await Permission.camera.request();
      log("Camera Permission: ${status.name}");

      // Step 2: Permission Granted
      if (status.isGranted) {
        final pickedFile = await _picker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          imageFile.value = File(pickedFile.path);

          // Step 3: Perform Punch Logic
          if (!(punchInOutInfoModel.value.buttonDisable ?? false)) {
            if (punchInOutInfoModel.value.button == "out") {
              await callServicePunchOut();
            } else {
              await callServicePunchIN();
            }
          }
        } else {
          Get.snackbar("Cancelled", "No photo was taken.");
        }
      }

      // Step 4: Handle Permanently Denied Permission
      else if (status.isPermanentlyDenied) {
        Get.snackbar("Permission Denied",
            "Camera permission is permanently denied. Please enable it from settings.");
        await openAppSettings();
      }

      // Step 5: Handle Other Denied Cases
      else {
        Get.snackbar(
            "Permission Denied", "Camera access is required to take a photo.");
      }
    } catch (e) {
      log("Camera Error: $e");
      Get.snackbar("Error", "An unexpected error occurred.");
    } finally {
      isPunchLoading.value = false;
    }
  }

  Future<void> callServicePunchStatus({bool isInit = false}) async {
    if (isInit) {
      isLoading.value = true;
    }

    int id = kDebugMode
        ? 1
        : (userInfo["user_profile_name"] == "Teacher")
            ? userInfo[CS.teacher_id]
            : userInfo["user_id"];

    if (await CU.checkInternet()) {
      statusRes = await ApiClient.call(
        Get.context!,
        callMethod: CallMethod.get,
        apiUrl: "https://erp.triz.co.in/hrms-inout-time?type=API&user_id=$id",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServicePunchStatus);
      return;
    }

    punchInOutInfoModel.value = PunchInOutInfoModel.fromJson(statusRes);

    isLoading.value = false;
  }

  Future<void> callServicePunchIN() async {
    isPunchLoading.value = true;

    int id = kDebugMode
        ? 1
        : (userInfo["user_profile_name"] == "Teacher")
            ? userInfo[CS.teacher_id]
            : userInfo["user_id"];

    dio.FormData formData = dio.FormData.fromMap({
      'type': 'API',
      'user_id': id,
      'sub_institute_id': userInfo[CS.sub_institute_id],
      'punchin_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
      'address_in': currentAddress.value
    });

    formData.files.addAll([
      MapEntry(
        "photo_in",
        await dio.MultipartFile.fromFile(imageFile.value?.path ?? ""),
      )
    ]);
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: formData,
        isFormData: false,
        apiUrl: "https://erp.triz.co.in/hrms-in-time/store",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServicePunchIN);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      Fluttertoast.showToast(
        msg: resJson[CS.message],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      callServicePunchStatus();
      isPunchLoading.value = false;
    } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
        resJson[CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isPunchLoading.value = false;
    }
    isPunchLoading.value = false;
  }

  Future<void> callServicePunchOut() async {
    isPunchLoading.value = true;

    int id = kDebugMode
        ? 1
        : (userInfo["user_profile_name"] == "Teacher")
            ? userInfo[CS.teacher_id]
            : userInfo["user_id"];

    dio.FormData formData = dio.FormData.fromMap({
      'type': 'API',
      'user_id': id,
      'sub_institute_id': userInfo[CS.sub_institute_id],
      'punchout_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
      'address_out': currentAddress.value
    });

    formData.files.addAll([
      MapEntry(
        "photo_out",
        await dio.MultipartFile.fromFile(imageFile.value?.path ?? ""),
      )
    ]);
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: formData,
        isFormData: false,
        apiUrl: "https://erp.triz.co.in/hrms-out-time/store",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServicePunchIN);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      Fluttertoast.showToast(
        msg: resJson[CS.message],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      isPunchLoading.value = false;
      callServicePunchStatus();
    } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
        resJson[CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isPunchLoading.value = false;
    }
    isPunchLoading.value = false;
  }
}
