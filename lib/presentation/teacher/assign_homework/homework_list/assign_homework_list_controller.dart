import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework_list_model.dart';

class AssignHomeWorkListController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  RxList<HomeworkList> homeworkList = <HomeworkList>[].obs;

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  Map<String, dynamic> resJson = {};

  Future<void> callService() async {
    isLoading.value = true;
    homeworkList.clear();

    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      "action": "Homework",
      "teacher_id": userInfo[CS.teacher_id],
      "syear": userInfo[CS.syear],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      "from_date": DateFormat('yyyy-MM-dd').format(fromDate.value),
      "to_date": DateFormat('yyyy-MM-dd').format(toDate.value)
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        callMethod: CallMethod.post,
        body: body,
        apiUrl: "https://erp.triz.co.in/teacherHomeworkAssignmentAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson[CS.status] == 1) {
      log("...................${resJson[CS.status]}");
      AssignHomeworkListModel model = AssignHomeworkListModel.fromJson(resJson);
      homeworkList.value += model.data!;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      Get.back();
    }
    isLoading.value = false;
  }
}
