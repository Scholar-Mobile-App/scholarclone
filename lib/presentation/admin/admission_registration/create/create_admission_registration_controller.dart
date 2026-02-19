import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/standard.dart';
import 'package:scholar_clone/model/admin/admission_confirmation_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/presentation/admin/admission_registration/admission_registration_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_drop_down.dart';

import '../../../../core/utils/cs.dart';

class CreateAdmissionRegistrationController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  bool isEdit = Get.arguments[2] ?? false;
  AdmissionConfirmation admConfirmation =
      Get.arguments[3] ?? AdmissionConfirmation;

  RxBool isLoading = false.obs;

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
  Rx<DropDownModel> previousStandard = const DropDownModel(id: 0, name: "").obs;
  Rx<TextEditingController> sourceEnquiry = TextEditingController().obs;
  Rx<TextEditingController> remark = TextEditingController().obs;
  Rx<DateTime> followupDate = DateTime.now().obs;

  Rx<DropDownModel> status = const DropDownModel(id: 0, name: "").obs;
  Rx<DropDownModel> admissionStandard =
      const DropDownModel(id: 0, name: "").obs;

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

  Rx<DropDownModel> sendSMS = const DropDownModel(id: 0, name: "").obs;

  Map<String, dynamic> saveResJson = <String, dynamic>{};

  List<DropDownModel> statusList = [
    const DropDownModel(id: 1, name: "OPEN"),
    const DropDownModel(id: 2, name: "CLOSE"),
  ];
  List<DropDownModel> smsList = [
    const DropDownModel(id: 1, name: "No"),
    const DropDownModel(id: 0, name: "Yes"),
  ];

  @override
  void onInit() async {
    if (isEdit) {
      enquiryNumber.value.text = admConfirmation.enquiryNo ?? "";
      firstName.value.text = admConfirmation.firstName ?? "";
      middleName.value.text = admConfirmation.middleName ?? "";
      lastName.value.text = admConfirmation.lastName ?? "";
      mobile.value.text = admConfirmation.mobile ?? "";
      email.value.text = admConfirmation.email ?? "";
      dob.value = admConfirmation.dateOfBirth ?? DateTime.now();
      age.value.text = (admConfirmation.age ?? 0).toString();
      address.value.text = admConfirmation.address ?? "";
      previousSchoolName.value.text = admConfirmation.previousSchoolName ?? "";
      previousStandard.value = standardList.firstWhereOrNull(
              (element) => element.name == admConfirmation.previousStandard) ??
          const DropDownModel(id: 0, name: "");
      admConfirmation.previousStandard ?? "";
      sourceEnquiry.value.text = admConfirmation.sourceOfEnquiry ?? "";
      remark.value.text = admConfirmation.remarks ?? "";
      followupDate.value = admConfirmation.followupDate ?? DateTime.now();

      admissionStandard.value = standardList.firstWhereOrNull(
              (element) => element.name == admConfirmation.admissionStandard) ??
          const DropDownModel(id: 0, name: "");
      stopTransport.value.text = admConfirmation.streetName ?? "";
      councilerName.value.text = admConfirmation.councilerName ?? "";
      lastExamName.value.text = "";
      lastExamPercentage.value.text = "";
      fatherEducation.value.text = admConfirmation.fatherQualification ?? "";
      fatherOccupation.value.text = admConfirmation.fatherOccupation ?? "";
      motherEducation.value.text = admConfirmation.motherQualification ?? "";
      motherOccupation.value.text = admConfirmation.motherOccupation ?? "";
      annualIncome.value.text = admConfirmation.annualIncome ?? "";
      admissionDocketNo.value.text = "";
      registrationNo.value.text = "";

      sendSMS.value = smsList.firstWhereOrNull(
              (element) => element.id.toString() == admConfirmation.sendSms) ??
          const DropDownModel(id: 0, name: "");

      ///
      // selectFileName.value = fileNameList
      //     .firstWhere((element) => element.name == admConfirmation.fileName);
    }
    super.onInit();
  }

  bool valid() {
    final RxBool isValid = true.obs;

    // if (selectFileName.value.name.isEmpty) {
    //   CU.showToast(Get.context!, "Please select a To Place");
    //   isValid.value = false;
    // } else if (dob.value.toString().isEmpty) {
    //   CU.showToast(Get.context!, "Please select a Outward Date");
    //   isValid.value = false;
    // } else if (enquiryNumber.value.text.isEmpty) {
    //   CU.showToast(Get.context!, "Please enter a Outward Number");
    //   isValid.value = false;
    // } else if (firstName.value.text.isEmpty) {
    //   CU.showToast(Get.context!, "Please enter a Subject");
    //   isValid.value = false;
    // } else if (middleName.value.text.isEmpty) {
    //   CU.showToast(Get.context!, "Please enter a Description");
    //   isValid.value = false;
    // } else if (selectFileName.value.name.isEmpty) {
    //   CU.showToast(Get.context!, "Please select a File Name");
    //   isValid.value = false;
    // } else if (file.value.path.isEmpty) {
    //   CU.showToast(Get.context!, "Please upload a File");
    //   isValid.value = false;
    // }

    return isValid.value;
  }

  Future<void> callUpdateService() async {
    isLoading.value = true;
    if (await CU.checkInternet()) {
      var birthDate = dob.value;
      var followDate = followupDate.value;

      log("dob.value ${dob.value}");
      log("v.value ${followupDate.value}");

      saveResJson = await ApiClient.call(
        Get.context,
        apiUrl:
            "https://erp.triz.co.in/admission/admission_registration/${enquiryNumber.value.text}?type=API&token=${userInfo[CS.token]}&first_name=${firstName.value.text}&last_name=${lastName.value.text}&middle_name=${lastName.value.text}&sub_institute_id=${userInfo[CS.sub_institute_id]}&syear=${userInfo[CS.syear]}&user_id=${userInfo[CS.user_id]}&mobile=${mobile.value.text}&email=${email.value.text}&date_of_birth=$birthDate&address=${address.value.text}&previous_school_name=${previousSchoolName.value.text}&previous_standard=${admConfirmation.previousStandard}&followup_date=$followDate&remarks=${remark.value.text}&source_of_enquiry=${sourceEnquiry.value.text}&stop_for_transport=${stopTransport.value.text}&send_sms=${sendSMS.value.id}&admission_standard=${admissionStandard.value.name}&age=${age.value.text}&status=${status.value.name}&counciler_name=${councilerName.value.text}&last_exam_name=${lastExamName.value.text}&last_exam_percentage=${lastExamPercentage.value.text}&father_education_qualification=${fatherEducation.value.text}&father_occupation=${fatherOccupation.value.text}&mother_education_qualification=${motherEducation.value.text}&mother_occupation=${motherOccupation.value.text}&annual_income=${annualIncome.value.text}&registration_no=${registrationNo.value.text}&admission_docket_no=${admissionDocketNo.value.text}&enquiry_id=${admConfirmation.enquiryNo}",
        callMethod: CallMethod.put,
        isFormData: false,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callUpdateService);
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
      Get.find<AdmissionRegistrationController>()
          .admissionRegistrationList
          .clear();
      Get.find<AdmissionRegistrationController>().callOutwardService();
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
