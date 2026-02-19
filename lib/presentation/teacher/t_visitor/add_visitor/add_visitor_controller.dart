import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/visitor_type_model.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/utility.dart';

import 'package:dio/dio.dart' as dio;

class AddVisitorController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = {};

  final GlobalKey<FormFieldState> visitorKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> meetKey = GlobalKey<FormFieldState>();

  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<TimeOfDay> time = TimeOfDay.now().obs;

  RxList<VisitorTypeDatum> toVisitorList = <VisitorTypeDatum>[].obs;
  RxList<ToMeetArray> toMeetList = <ToMeetArray>[].obs;
  RxList<String> visitorNameList = <String>[].obs;
  RxList<String> meetNameList = <String>[].obs;

  RxBool directAppointment = true.obs;

  RxString appointmentType = "Direct".obs;
  RxString imageFile = "".obs;
  RxString visitorName = "".obs;
  RxString visitorContact = "".obs;
  RxString visitorEmail = "".obs;
  RxString comingFrom = "".obs;
  RxString relation = "".obs;
  RxString purpose = "".obs;
  RxString visitorIdCard = "".obs;
  RxString inTime = "".obs;

  RxInt visitorID = 0.obs;
  RxInt meetID = 0.obs;

  @override
  void onInit() {
    callServicevisitorType();
    callServicetoMeet();
    super.onInit();
  }

  pickPhotos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "pdf"],
      allowMultiple: false,
    );

    imageFile.value = result!.files.first.path!;
  }

  Future<void> callServicevisitorType() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.type: "API",
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_visitorTypeAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServicevisitorType);
      return;
    }

    VisitorTypeModel model = VisitorTypeModel.fromJson(resJson);

    toVisitorList.value = model.visitorTypeData!;

    if (toVisitorList.isNotEmpty) {
      for (var i = 0; i < model.toMeetArray!.length; i++) {
        visitorNameList.add(toVisitorList[i].title ?? "");
      }
    }
  }

  Future<void> callServicetoMeet() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.type: "API",
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_visitorTypeAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(
        Get.context!,
        callServicetoMeet,
      );
      return;
    }

    VisitorTypeModel model = VisitorTypeModel.fromJson(resJson);

    toMeetList.value = model.toMeetArray!;

    if (toMeetList.isNotEmpty) {
      for (var i = 0; i < model.toMeetArray!.length; i++) {
        meetNameList.add(toMeetList[i].staffName!);
      }
    }
  }

  Future<void> callService(context) async {
    // if (valid()) {
    dio.FormData formData = dio.FormData.fromMap({
      "appointment_type": appointmentType.value,
      "visitor_type": visitorID.value,
      "name": visitorName.value,
      "contact": visitorContact.value,
      "email": visitorEmail.value,
      "coming_from": comingFrom.value,
      "to_meet": meetID,
      "relation": relation.value,
      "purpose": purpose.value,
      "visitor_idcard": visitorIdCard.value,
      "meet_date": selectedDate,
      "in_time": inTime.value,
      "type": "API",
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.token: userInfo[CS.token],
      "file_name": imageFile.value.isEmpty ? null : imageFile.value,
    });

    if (imageFile.value.isNotEmpty) {
      formData.files.add(
        MapEntry(
            "file_name", await dio.MultipartFile.fromFile(imageFile.value)),
      );
    }

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        context,
        body: formData,
        apiUrl: "https://erp.triz.co.in/add_visitorAPI",
        isShowProgressDialog: false,
        isFormData: false,
      );
    } else {
      CU.showNoInternetDialog(context, callService);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      showToast(
        context: context,
        message: resJson[CS.message],
        color: Colors.green,
        icons: Icons.check_circle_outline,
      );
      Get.back();
    } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
        resJson[CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: context,
      );
    }
    // }
  }
}
