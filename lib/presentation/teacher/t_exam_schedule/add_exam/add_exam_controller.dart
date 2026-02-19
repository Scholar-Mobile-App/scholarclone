import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

import '../../../../core/utils/utility.dart';
import '../../../../model/teacher/assign_homework/section_model.dart';

import 'package:dio/dio.dart' as dio;

class AddExamController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = {};

  RxList<String> stdName = <String>[].obs;
  RxList<String> divName = <String>[].obs;
  RxList<Standard> stdList = <Standard>[].obs;
  RxList<Division> divList = <Division>[].obs;

  final GlobalKey<FormFieldState> standardKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> divisionKey = GlobalKey<FormFieldState>();

  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxString standard = "".obs;
  RxString title = "".obs;
  RxString imageFile = "".obs;

  RxInt stdID = 0.obs;
  RxInt divID = 0.obs;

  pickPhotos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "pdf", "jpeg"],
      allowMultiple: false,
    );

    imageFile.value = result!.files.first.path!;
  }

  @override
  void onInit() {
    callServiceStandard();
    super.onInit();
  }

  Future<void> callServiceStandard() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.type: "API",
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_teacher_timetablewiseStandard",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandard);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      StandardModel model = StandardModel.fromJson(resJson);

      stdList.value += model.data!;

      for (int i = 0; i < model.data!.length; i++) {
        stdName.add(model.data![i].stdName!);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceDivision() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.type: "API",
      "standard_id": stdID,
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_teacher_timetablewiseDivision",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceDivision);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      DivisionModel model = DivisionModel.fromJson(resJson);
      divList.value += model.data!;

      for (int i = 0; i < model.data!.length; i++) {
        divName.add(model.data![i].divName!);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceSubmit(context) async {
    dio.FormData formData = dio.FormData.fromMap({
      "title": title,
      "date": selectedDate,
      "standard_id": stdID,
      "division_id": divID,
      "type": "API",
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.token: userInfo[CS.token],
    });

    formData.files.addAll([
      MapEntry("attachment", await dio.MultipartFile.fromFile(imageFile.value)),
    ]);

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        isFormData: false,
        body: formData,
        apiUrl: "https://erp.triz.co.in/add_teacherExamSchedule",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceSubmit);
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
      //setState(() {});
    } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
        resJson[CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: context,
      );
    }
  }
}
