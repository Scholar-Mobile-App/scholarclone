import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/admin/admission_confirmation_model.dart';
import 'package:scholar_clone/model/admin/file_location_model.dart';
import 'package:scholar_clone/model/admin/to_place_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:scholar_clone/presentation/admin/outward/admin_outward_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_drop_down.dart';

class CreateAdmissionConfirmationController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  bool isEdit = Get.arguments[2] ?? false;
  AdmissionConfirmation outward = Get.arguments[3] ?? AdmissionConfirmation;

  RxBool isLoading = false.obs;

  // RxString outwardNumber = "".obs;
  // RxString description = "".obs;
  // RxString subject = "".obs;
  Rx<TextEditingController> enquiryNumber = TextEditingController().obs;
  Rx<TextEditingController> firstName = TextEditingController().obs;
  Rx<TextEditingController> middleName = TextEditingController().obs;
  Rx<TextEditingController> lastName = TextEditingController().obs;
  Rx<TextEditingController> mobile = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<DateTime> dob = DateTime.now().obs;
  Rx<TextEditingController> age = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> previousSchoolName = TextEditingController().obs;
  Rx<TextEditingController> sourceEnquiry = TextEditingController().obs;
  Rx<TextEditingController> remark = TextEditingController().obs;
  Rx<DateTime> followupDate = DateTime.now().obs;
  Rx<TextEditingController> stopTransport = TextEditingController().obs;
  Rx<TextEditingController> councilerName = TextEditingController().obs;
  Rx<TextEditingController> lastExamName = TextEditingController().obs;
  Rx<TextEditingController> lastExamPercentage = TextEditingController().obs;
  Rx<TextEditingController> fatherEducation = TextEditingController().obs;
  Rx<TextEditingController> fatherOccupation = TextEditingController().obs;
  Rx<TextEditingController> motherEducation = TextEditingController().obs;
  Rx<TextEditingController> motherOccupation = TextEditingController().obs;
  Rx<TextEditingController> annualIncome = TextEditingController().obs;
  Rx<TextEditingController> admissionDocketNo = TextEditingController().obs;
  Rx<TextEditingController> registrationNo = TextEditingController().obs;

  Rx<DropDownModel> selectFileName = const DropDownModel(id: 0, name: "").obs;
  Rx<DropDownModel> selectToPlace = const DropDownModel(id: 0, name: "").obs;

  RxList<DropDownModel> fileNameList = <DropDownModel>[].obs;
  RxList<DropDownModel> toPlaceList = <DropDownModel>[].obs;

  Map<String, dynamic> resJson = <String, dynamic>{};
  Map<String, dynamic> saveResJson = <String, dynamic>{};

  FileLocationModel? fileLocationModel;
  ToPlaceModel? toPlaceModel;

  Rx<XFile> file = XFile("").obs;

  @override
  void onInit() async {
    await callServiceFileName();
    await callServiceToPlace();
    // if (isEdit) {
    //   selectToPlace.value =
    //       toPlaceList.firstWhere((element) => element.name == outward.placeId);

    //   log("................${selectToPlace.value.id}............${selectToPlace.value.name}");

    //   selectFileName.value = fileNameList
    //       .firstWhere((element) => element.name == outward.fileName);

    //   outwardDate.value = outward.outwardDate ?? DateTime.now();
    //   enquiryNumber.value.text = outward.outwardNumber ?? "";
    //   description.value.text = outward.description ?? "";
    //   subject.value.text = outward.title ?? "";

    //   file.value = XFile("${outward.attachment}*");
    // }
    super.onInit();
  }

  bool valid() {
    final RxBool isValid = true.obs;

    if (selectFileName.value.name.isEmpty) {
      CU.showToast(Get.context!, "Please select a To Place");
      isValid.value = false;
    } else if (dob.value.toString().isEmpty) {
      CU.showToast(Get.context!, "Please select a Outward Date");
      isValid.value = false;
    } else if (enquiryNumber.value.text.isEmpty) {
      CU.showToast(Get.context!, "Please enter a Outward Number");
      isValid.value = false;
    } else if (firstName.value.text.isEmpty) {
      CU.showToast(Get.context!, "Please enter a Subject");
      isValid.value = false;
    } else if (middleName.value.text.isEmpty) {
      CU.showToast(Get.context!, "Please enter a Description");
      isValid.value = false;
    } else if (selectFileName.value.name.isEmpty) {
      CU.showToast(Get.context!, "Please select a File Name");
      isValid.value = false;
    } else if (file.value.path.isEmpty) {
      CU.showToast(Get.context!, "Please upload a File");
      isValid.value = false;
    }

    return isValid.value;
  }

  Future<void> callServiceFileName() async {
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(Get.context,
          apiUrl:
              "https://erp.triz.co.in/inward_outward/add_physical_file_location?type=API&sub_institute_id=${userInfo[CS.sub_institute_id]}",
          isShowProgressDialog: false,
          callMethod: CallMethod.get);
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceFileName);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      FileLocationModel model = FileLocationModel.fromJson(resJson);
      fileLocationModel = model;
      for (int i = 0; i < model.data!.length; i++) {
        fileNameList.add(DropDownModel(
            id: model.data![i].id ?? 0, name: model.data![i].title ?? ""));
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: true,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceToPlace() async {
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(Get.context,
          apiUrl:
              "https://erp.triz.co.in/inward_outward/add_place_master?type=API&sub_institute_id=${userInfo[CS.sub_institute_id]}",
          isShowProgressDialog: false,
          callMethod: CallMethod.get);
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceFileName);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      ToPlaceModel model = ToPlaceModel.fromJson(resJson);
      toPlaceModel = model;
      for (int i = 0; i < model.data!.length; i++) {
        toPlaceList.add(DropDownModel(
            id: model.data![i].id ?? 0, name: model.data![i].title ?? ""));
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: true,
        context: Get.context!,
      );
    }
  }

  Future<void> callService() async {
    if (valid()) {
      dio.FormData formData = dio.FormData.fromMap({
        "type": "API",
        "token": userInfo[CS.token],
        "sub_institute_id": userInfo[CS.sub_institute_id],
        "syear": userInfo[CS.syear],
        "place_id": selectToPlace.value.id,
        "file_location_id": selectFileName.value.id,
        "outward_number": enquiryNumber.value.text,
        "title": firstName.value.text,
        "description": middleName.value.text,
        "acedemic_year": userInfo[CS.syear],
        "outward_date": dob.value,
        "attachment": file.value.path.replaceAll("*", ""),
      });
      if (file.value.path.isNotEmpty && !file.value.path.contains("*")) {
        formData.files.add(
          MapEntry(
              "attachment", await dio.MultipartFile.fromFile(file.value.path)),
        );
      }

      isLoading.value = true;
      if (await CU.checkInternet()) {
        saveResJson = await ApiClient.call(
          Get.context,
          body: formData,
          apiUrl: "https://erp.triz.co.in/inward_outward/add_outward",
          callMethod: CallMethod.post,
          isFormData: false,
          isShowProgressDialog: false,
        );
      } else {
        CU.showNoInternetDialog(Get.context!, callService);
        return;
      }

      if (saveResJson[CS.status].toString() == StatusCode.Success) {
        Fluttertoast.showToast(
          msg: saveResJson[CS.message],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Get.back();
        Get.find<AdminOutwardController>().outwardList.clear();
        Get.find<AdminOutwardController>().callOutwardService();
        isLoading.value = false;
      } else if (saveResJson[CS.status_code].toString() == StatusCode.Error ||
          saveResJson[CS.status].toString() == StatusCode.Authentication) {
        showDialog(
          builder: (context) => CU.showDiloag(context, saveResJson[CS.message]),
          barrierDismissible: false,
          context: Get.context!,
        );
        isLoading.value = false;
      }
    }
  }

  Future<void> callUpdateService() async {
    if (valid()) {
      isLoading.value = true;
      if (await CU.checkInternet()) {
        saveResJson = await ApiClient.call(
          Get.context,
          apiUrl:
              "https://erp.triz.co.in/inward_outward/add_outward/${outward.id}?type=API&token=${userInfo[CS.token]}&title=${firstName.value.text}&place_id=${selectToPlace.value.id}&file_location_id=${selectFileName.value.id}&outward_number=${enquiryNumber.value.text}&description=${middleName.value.text}&acedemic_year=${userInfo[CS.syear]}&outward_date=${dob.value}",
          callMethod: CallMethod.put,
          isFormData: false,
          isShowProgressDialog: false,
        );
      } else {
        CU.showNoInternetDialog(Get.context!, callService);
        return;
      }

      // if (saveResJson[CS.status].toString() == StatusCode.Success) {
      Fluttertoast.showToast(
        msg: saveResJson[CS.message],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Get.back();
      Get.find<AdminOutwardController>().outwardList.clear();
      Get.find<AdminOutwardController>().callOutwardService();
      isLoading.value = false;
      // } else if (saveResJson[CS.status_code].toString() == StatusCode.Error ||
      //     saveResJson[CS.status].toString() == StatusCode.Authentication) {
      //   showDialog(
      //     builder: (context) => CU.showDiloag(context, saveResJson[CS.message]),
      //     barrierDismissible: false,
      //     context: Get.context!,
      //   );
      //   isLoading.value = false;
      // }
    }
  }
}
