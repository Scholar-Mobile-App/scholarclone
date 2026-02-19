import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

import '../../../core/utils/cs.dart';

class ResultsPDFController extends GetxController
    with GetTickerProviderStateMixin {
  Content content = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];
  Map<String, dynamic> resJson = {};

  RxList<TermData> termData = <TermData>[].obs;
  RxList<Tabs> allPages = <Tabs>[].obs;

  RxInt tabindex = 0.obs;

  RxBool isLoading = false.obs;

  TabController? controller;

  RxList<ResultData> resultList = <ResultData>[].obs;

  @override
  void onInit() {
    userInfo['term_data'].forEach((e) {
      termData.add(TermData.fromJson(e));
      allPages.add(Tabs(text: TermData.fromJson(e).title));
    });

    controller = TabController(length: allPages.length, vsync: this);
    callServiceTab(userInfo["term_data"][0]["term_id"]);

    super.onInit();
  }

  Future<void> callServiceTab(termId) async {
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.type: 'API',
      'term_id': termId,
      CS.student_id: userInfo[CS.student_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/studentResultPDFAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(
        Get.context!,
        callServiceTab(userInfo["term_data"][tabindex.value]["term_id"]),
      );
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      ResultPdfDataModel model = ResultPdfDataModel.fromJson(resJson);

      resultList.value = model.data ?? [];
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

class Tabs {
  Tabs({
    required this.text,
  });

  Widget? icon;
  String text;
  var data;
}

class TermData {
  final String termId;
  final String title;
  TermData({required this.termId, required this.title});
  factory TermData.fromJson(Map<String, dynamic> json) => TermData(
        termId: json["term_id"].toString(),
        title: json["title"],
      );
}

class ResultPdfDataModel {
  int? status;
  String? message;
  List<ResultData>? data;

  ResultPdfDataModel({
    this.status,
    this.message,
    this.data,
  });

  factory ResultPdfDataModel.fromJson(Map<String, dynamic> json) =>
      ResultPdfDataModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ResultData>.from(
                json["data"]!.map((x) => ResultData.fromJson(x))),
      );
}

class ResultData {
  String? title;
  String? resultType;
  int? termId;
  String? studentId;
  String? pdfLink;

  ResultData({
    this.title,
    this.resultType,
    this.termId,
    this.studentId,
    this.pdfLink,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
        title: json["title"],
        resultType: json["result_type"],
        termId: json["term_id"],
        studentId: json["student_id"],
        pdfLink: json["pdf_link"],
      );
}
