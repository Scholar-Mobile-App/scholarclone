import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/circular_model.dart';
import 'package:scholar_clone/model/student/event_model.dart';

class CircularEventsController extends GetxController {
  TabController? tabController;
  Map<String, dynamic> userInfo = Get.arguments;

  Map<String, dynamic> resJson = <String, dynamic>{};
  Map<String, dynamic> evtJson = <String, dynamic>{};

  RxList<Circular> clist = <Circular>[].obs;
  RxList<Event> elist = <Event>[].obs;

  RxBool isCircularLoading = false.obs;
  RxBool isEventLoading = false.obs;

  List<String> tabPages = [
    CS.circular,
    CS.events,
  ];

  @override
  void onInit() async {
    await callServiceCircular();
    callServiceEvent();
    super.onInit();
  }

  Future<void> callServiceCircular() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.student_id: userInfo[CS.student_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.token: userInfo[CS.token],
      CS.action: "circular",
    };

    isCircularLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: CS.circularfetchData,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceCircular);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      CircularModel model = CircularModel.fromJson(resJson);

      clist.clear();
      for (var i = 0; i < model.data!.length; i++) {
        clist.add(model.data![i]);
      }

      isCircularLoading.value = false;
    } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
        resJson[CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isCircularLoading.value = false;
    }
  }

  Future<void> callServiceEvent() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.student_id: userInfo[CS.student_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.token: userInfo[CS.token],
      CS.action: "event",
    };

    isEventLoading.value = true;

    if (await CU.checkInternet()) {
      evtJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: CS.circularfetchData,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceCircular);
      return;
    }

    if (evtJson[CS.status].toString() == StatusCode.Success) {
      EventModel model = EventModel.fromJson(evtJson);

      elist.clear();
      for (var i = 0; i < model.data!.length; i++) {
        elist.add(model.data![i]);
      }

      isEventLoading.value = false;
    } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
        resJson[CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isEventLoading.value = false;
    }
  }
}
