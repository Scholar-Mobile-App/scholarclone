import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/standard.dart';
import 'package:scholar_clone/model/admin/admission_confirmation_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/presentation/admin/admission_enquiry/admission_enquiry_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_drop_down.dart';

class CreateAdmissionEnquiryController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  bool isEdit = Get.arguments[2] ?? false;
  AdmissionConfirmation admConfirmation =
      Get.arguments[3] ?? AdmissionConfirmation;

  RxBool isLoading = false.obs;

  // RxString outwardNumber = "".obs;
  // RxString description = "".obs;
  // RxString subject = "".obs;
  Rx<TextEditingController> enquiryNumber =
      TextEditingController(text: "20210024").obs;
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

  Rx<DropDownModel> sendSMS = const DropDownModel(id: 0, name: "").obs;
  Rx<DropDownModel> selectAdmissionStandard =
      const DropDownModel(id: 0, name: "").obs;
  Rx<DropDownModel> selectPreviousStandard =
      const DropDownModel(id: 0, name: "").obs;
  Rx<DropDownModel> selectCategory = const DropDownModel(id: 0, name: "").obs;

  Map<String, dynamic> resJson = <String, dynamic>{};
  Map<String, dynamic> saveResJson = <String, dynamic>{};

  Rx<XFile> file = XFile("").obs;

  RxString selectedGender = ''.obs;

  final List<String> genderOptions = ["Male", "Female"];

  final List<DropDownModel> smsList = [
    const DropDownModel(id: 1, name: "No"),
    const DropDownModel(id: 0, name: "Yes"),
  ];

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

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
      selectPreviousStandard.value = standardList.firstWhereOrNull(
              (element) => element.name == admConfirmation.previousStandard) ??
          const DropDownModel(id: 0, name: "");

      sourceEnquiry.value.text = admConfirmation.sourceOfEnquiry ?? "";
      remark.value.text = admConfirmation.remarks ?? "";
      followupDate.value = admConfirmation.followupDate ?? DateTime.now();

      selectCategory.value = standardList.firstWhereOrNull(
              (element) => element.id.toString() == admConfirmation.category) ??
          const DropDownModel(id: 0, name: "");

      selectedGender.value = admConfirmation.gender == "M"
          ? "Male"
          : admConfirmation.gender == "F"
              ? "Female"
              : "";

      selectAdmissionStandard.value = standardList.firstWhereOrNull((element) =>
              element.id.toString() == admConfirmation.admissionStandard) ??
          const DropDownModel(id: 0, name: "");

      sendSMS.value = smsList.firstWhereOrNull(
              (element) => element.id.toString() == admConfirmation.sendSms) ??
          const DropDownModel(id: 0, name: "");
    }

    super.onInit();
  }

  bool valid() {
    final RxBool isValid = true.obs;

    if (dob.value.toString().isEmpty) {
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
    } else if (file.value.path.isEmpty) {
      CU.showToast(Get.context!, "Please upload a File");
      isValid.value = false;
    }

    return isValid.value;
  }

  Future<void> createAdmissionEnquiry() async {
    Map<String, dynamic> body = <String, dynamic>{
      "type": "API",
      "sub_institute_id": userInfo[CS.sub_institute_id],
      "syear": userInfo[CS.syear],
      "user_id": userInfo[CS.user_id],
      "token": userInfo[CS.token],
      "enquiry_id": enquiryNumber.value.text,
      'first_name': firstName.value.text,
      'last_name': lastName.value.text,
      'middle_name': middleName.value.text,
      'mobile': mobile.value.text,
      'email': mobile.value.text,
      'date_of_birth': DateFormat('yyyy-MM-dd').format(dob.value),
      'address': address.value.text,
      'previous_school_name': previousSchoolName.value.text,
      'previous_standard': selectPreviousStandard.value.id.toString(),
      'followup_date': DateFormat('yyyy-MM-dd').format(followupDate.value),
      'remarks': remark.value.text,
      'source_of_enquiry': sourceEnquiry.value.text,
      'category': selectCategory.value.id.toString(),
      'Gender': selectedGender.isNotEmpty
          ? selectedGender.value == "Male"
              ? "M"
              : "F"
          : "",
      'send_sms': sendSMS.value.id.toString(),
      'admission_standard': selectAdmissionStandard.value.id.toString(),
      'age': age.value.text
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/admission/admission_enquiry",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, createAdmissionEnquiry);
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
      Get.find<AdmissionEnquiryController>().admissionEnquiryList.clear();
      Get.find<AdmissionEnquiryController>().callService();
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

  Future<void> updateAdmissionEnquiry() async {
    // if (valid()) {

    isLoading.value = true;
    if (await CU.checkInternet()) {
      saveResJson = await ApiClient.call(
        Get.context,
        apiUrl:
            'https://erp.triz.co.in/admission/admission_enquiry/${enquiryNumber.value.text}?type=API&token=${userInfo[CS.token]}&first_name=${firstName.value.text}&last_name=${lastName.value.text}&middle_name=${middleName.value.text}&sub_institute_id=${userInfo[CS.sub_institute_id]}&syear=${userInfo[CS.syear]}&user_id=${userInfo[CS.user_id]}&mobile=${mobile.value.text}&email=${email.value.text}&date_of_birth=${DateFormat('yyyy-MM-dd').format(dob.value)}&address=${address.value.text}&previous_school_name=${previousSchoolName.value.text}&previous_standard=${selectPreviousStandard.value.id.toString()}&followup_date=${DateFormat('yyyy-MM-dd').format(followupDate.value)}&remarks=${remark.value.text}&source_of_enquiry=${sourceEnquiry.value.text}&category=${selectCategory.value.id.toString()}&send_sms=${sendSMS.value.id.toString()}&admission_standard=${selectAdmissionStandard.value.id.toString()}',
        callMethod: CallMethod.put,
        isFormData: false,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, updateAdmissionEnquiry);
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
    Get.find<AdmissionEnquiryController>().admissionEnquiryList.clear();
    Get.find<AdmissionEnquiryController>().callService();
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
    // }
  }
}
