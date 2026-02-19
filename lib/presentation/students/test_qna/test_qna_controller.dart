import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/lms_subject_test_model.dart';

import '../../../core/utils/cs.dart';
import '../../../routes/app_routes.dart';

class TestQnAController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void onInit() async {
    log("questionPaperId ${data.questionPaperId}");
    await callService();
    start.value = (data.timeAllowed! * 60);
    super.onInit();
  }

  TestData data = Get.arguments[0];
  var homeData = Get.arguments[1];

  Map<String, dynamic>? resJson;
  Map<String, dynamic>? resSubmitJson;

  RxList<Tabbar> allqnaPages = <Tabbar>[].obs;

  RxInt start = 0.obs;
  RxInt givenAns = 0.obs;
  RxInt total = 0.obs;

  Timer? timer;

  RxBool isLoading = false.obs;

  Future<void> callService() async {
    log("hiiii");
    isLoading.value = true;
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: homeData[CS.token],
      CS.syear: homeData[CS.syear],
      CS.student_id: homeData[CS.student_id],
      CS.sub_institute_id: homeData[CS.sub_institute_id],
      CS.question_paper_id: data.questionPaperId,
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: jsonEncode(body),
        apiUrl: "https://erp.triz.co.in/studentQuestionPaperAPI",
        isShowProgressDialog: false,
        isFormData: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson![CS.status].toString() == StatusCode.Success) {
      var data = resJson![CS.data].entries.toList()[0].value.entries.toList();
      for (int i = 0; i < data.length; i++) {
        allqnaPages.add(
          Tabbar(
            text: (i + 1).toString(),
            data: data[i].value,
            ansData: AnsData(),
          ),
        );
      }

      tabController = TabController(vsync: this, length: allqnaPages.length);
      tabController?.addListener(handleTabSelection);
      startTimer();
    } else if (resJson![CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson![CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
    isLoading.value = false;
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
          Get.back();
        } else {
          start.value--;
        }
      },
    );
  }

  Future<void> callSubmitService() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: homeData[CS.token],
      CS.sub_institute_id: homeData[CS.sub_institute_id],
      CS.student_id: homeData[CS.student_id],
      CS.syear: homeData[CS.syear],
      CS.question_paper_id: data.questionPaperId, // check
      "question_list": getQuestionLayout(),
      CS.given_ans: getGivenAns(),
      "original_ans": getOrignalAns(),
      "total_marks": "1",
    };

    if (await CU.checkInternet()) {
      resSubmitJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/studentQuestionPaperSaveAPI",
        isShowProgressDialog: false,
        isFormData: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callSubmitService);
      return;
    }

    if (resSubmitJson![CS.status].toString() == StatusCode.Success) {
      Map<String, dynamic> quesAnsData = <String, dynamic>{};
      quesAnsData.addAll(<String, dynamic>{
        CS.data: getQuesAnsData(),
        CS.total: total,
        CS.grade: givenAns
      });

      Fluttertoast.showToast(
          msg: "Submit Successfully.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      Get.offAndToNamed(
        AppRoutes.testResult,
        arguments: [
          quesAnsData,
          homeData,
        ],
      );
    } else if (resSubmitJson![CS.status] == StatusCode.Error) {
      showDialog(
        builder: (context) =>
            CU.showDiloag(context, resSubmitJson![CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  getOrignalAns() {
    String str = "";
    for (int i = 0; i < allqnaPages.length; i++) {
      Tabbar page = allqnaPages[i];
      for (int j = 0; j < page.data["Answer"].length; j++) {
        if (page.data["Answer"][j]["correct_answer"].toString() == "1") {
          str += (str.isEmpty ? "" : ",") +
              page.data["Answer"][j]["id"].toString();
        }
      }
    }
    return str;
  }

  getQuesAnsData() {
    List<Map<String, dynamic>> lstQuesAnsData = [];
    for (int i = 0; i < allqnaPages.length; i++) {
      Tabbar page = allqnaPages[i];
      Map<String, dynamic> quesAnsData = <String, dynamic>{};
      quesAnsData.addAll(<String, dynamic>{
        "questiontext": page.data["question_title"].toString(),
        CS.org_ans: "",
        CS.given_ans: "",
      });
      for (int j = 0; j < page.data["Answer"].length; j++) {
        if (page.data["Answer"][j]["correct_answer"].toString() == "1") {
          quesAnsData.addAll(<String, dynamic>{
            CS.org_ans: page.data["Answer"][j]["answer"].toString()
          });
        }
        if (page.data["Answer"][j]["id"].toString() == page.ansData!.answerid) {
          quesAnsData.addAll(<String, dynamic>{
            CS.given_ans: page.data["Answer"][j]["answer"].toString()
          });
        }
      }
      if (quesAnsData['org_ans'] == quesAnsData['given_ans']) {
        givenAns.value += 1;
      }

      log(quesAnsData.toString());
      lstQuesAnsData.add(quesAnsData);
    }
    total.value = lstQuesAnsData.length;
    return lstQuesAnsData;
  }

  getGivenAns() {
    String str = "";
    for (int i = 0; i < allqnaPages.length; i++) {
      Tabbar page = allqnaPages[i];
      str += (str.isEmpty ? "" : ",") +
          (CU.isEmptyOrNull(page.ansData!.answerid)
              ? "0"
              : page.ansData!.answerid.toString());
    }
    return str;
  }

  getQuestionLayout() {
    String str = "";
    for (int i = 0; i < allqnaPages.length; i++) {
      Tabbar page = allqnaPages[i];
      str += (str.isEmpty ? "" : ",") + page.data["id"].toString();
    }
    return str;
  }

  RxInt tabIndex = 0.obs;
  void handleTabSelection() {
    tabIndex.value = tabController?.index ?? 0;
    update();
  }

  @override
  void onClose() {
    if (start.value != (data.timeAllowed! * 60)) {
      timer!.cancel();
    }

    super.onClose();
  }
}

class AnsData {
  String answerid = "";
}

class Tabbar {
  Tabbar({
    this.icon,
    this.text,
    this.data,
    this.ansData,
  });

  Widget? icon;
  String? text;
  var data;
  AnsData? ansData;
}
