import 'package:get/get.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';
import 'package:flutter/material.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import '../../../../core/utils/cs.dart';
import '../../../../model/admin/student_fees_detail_model.dart';

class FeesCollectDetailsController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];
  Student studentInfo = Get.arguments[2];
  StudentFeesDetailModel? studentFeesDetailModel;

  Rx<TextEditingController> bankName = TextEditingController().obs;
  Rx<TextEditingController> transactionID = TextEditingController().obs;

  Map<String, dynamic> resJson = {};

  RxList<Pending> checkData = <Pending>[].obs;

  RxBool isLoading = true.obs;

  @override
  void onReady() {
    callService();
    super.onReady();
  }

  // Method to sum remain amounts
  int get totalRemain =>
      checkData.fold(0, (sum, item) => sum + (item.remain ?? 0));

  Future<void> callService() async {
    if (await CU.checkInternet()) {
      isLoading.value = true;
      resJson = await ApiClient.call(
        Get.context!,
        callMethod: CallMethod.post,
        isFormData: false,
        body: {},
        apiUrl:
            "https://erp.triz.co.in/studentFeesDetailAPI?syear=${userInfo[CS.syear]}&sub_institute_id=${userInfo[CS.sub_institute_id]}&student_id=${studentInfo.id}",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      studentFeesDetailModel = StudentFeesDetailModel.fromJson(resJson);
      isLoading.value = false;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  bool valid() {
    final RxBool isValid = true.obs;

    if (bankName.value.text.isEmpty) {
      CU.showToast(Get.context!, "Please enter a Bank Name");
      isValid.value = false;
    } else if (transactionID.value.text.isEmpty) {
      CU.showToast(Get.context!, "Please enter a Transaction ID");
      isValid.value = false;
    }

    return isValid.value;
  }

  Future<void> callServicePayNow() async {
    if (valid()) {
      if (await CU.checkInternet()) {
        resJson = await ApiClient.call(
          Get.context!,
          callMethod: CallMethod.post,
          isFormData: false,
          body: {},
          apiUrl:
              "https://dev.triz.co.in/fees/get_online_receipt?syear=${userInfo[CS.syear]}&sub_institute_id=${userInfo[CS.sub_institute_id]}&student_id=${studentInfo.id}&amount=$totalRemain&bank_name=${bankName.value.text}&transactionid=${transactionID.value.text}&fine=0&token=${studentFeesDetailModel!.data!.stuData!.token ?? ""}",
          isShowProgressDialog: true,
        );
      } else {
        CU.showNoInternetDialog(Get.context!, callServicePayNow());
        return;
      }

      CU.hideProgressDialog(Get.context);

      if (resJson[CS.status].toString() == StatusCode.Success) {
        Get.offAndToNamed(
          AppRoutes.onlineReceptView,
          arguments: resJson["receipt_html"],
        );
      } else if (resJson[CS.status].toString() == StatusCode.Error) {
        showDialog(
          builder: (context) => CU.showDiloag(context, resJson[CS.message]),
          barrierDismissible: false,
          context: Get.context!,
        );
      }
    }
  }
}
