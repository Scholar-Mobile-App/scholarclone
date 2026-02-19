import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/fees_status_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

import '../../../core/utils/cs.dart';

class FeesDetailsController extends GetxController {
  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  RxInt tabIndex = 0.obs;
  RxInt paidAmount = 0.obs;
  RxInt unPaidAmount = 0.obs;

  RxList<UnPaid> unPaidList = <UnPaid>[].obs;
  RxList<Paid> paidList = <Paid>[].obs;

  Map<String, dynamic> resJson = {};

  String convertCurrencyTransaction(String amount) {
    NumberFormat formatter;
    if (amount != '' &&
        amount.length == 1 &&
        !amount.characters.contains(".")) {
      formatter = NumberFormat('#,##,0.00');
    } else if (amount != '' &&
        amount.length == 2 &&
        !amount.characters.contains(".")) {
      formatter = NumberFormat('#,##,00.00');
    } else if (amount != '' &&
        amount.length == 3 &&
        !amount.characters.contains(".")) {
      formatter = NumberFormat('#,##,000.00');
    } else if (amount != '' &&
        amount.length > 3 &&
        !amount.characters.contains(".")) {
      formatter = NumberFormat('#,##,000.00');
    } else if (amount.characters.contains(".") && amount.length > 6) {
      formatter = NumberFormat('#,##,000.##');
    } else {
      return amount;
    }

    return formatter.format(double.parse(amount));
  }

  Future<void> callService() async {
    isLoading.value = true;
    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.student_id: userInfo[CS.student_id],
      CS.token: userInfo[CS.token],
    };
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        apiUrl: "https://erp.triz.co.in/studentFeesDetailAPI",
        isShowProgressDialog: false,
        body: body,
      );
    } else {
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      FeesStatusModel model = FeesStatusModel.fromJson(resJson);

      for (var element in model.data!.pending!) {
        unPaidList.add(element);
        unPaidAmount.value += int.parse(element.remain.toString());
      }

      for (var element in model.data!.paid!) {
        paidList.add(element);
        paidAmount.value += int.parse(element.paidAmount.toString());
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
    isLoading.value = false;
  }
}
