import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/student/homework_model.dart';

class HomeworkController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;
  Map<String, dynamic>? resJson;

  RxList<Homework> homeworkList = <Homework>[].obs;

  RxDouble progress = 0.0.obs;

  @override
  void onInit() {
    callService();
    Permission.storage.request();
    super.onInit();
  }

  Future<void> callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.action: "Homework",
      CS.student_id: userInfo[CS.student_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    isLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: data.subTitleApi,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }
    if (resJson![CS.status].toString() == StatusCode.Success.toString()) {
      HomeworkModel model = HomeworkModel.fromJson(resJson!);
      for (var i = 0; i < model.data!.length; i++) {
        homeworkList.add(model.data![i]);
      }
      isLoading.value = false;
    } else if (resJson![CS.status].toString() == StatusCode.Error) {
      homeworkList.value = [];
      isLoading.value = false;
    }
  }

  Future<void> openFile(String filePath) async {
    final file = File(filePath);

    if (file.existsSync()) {
      log("File  ${file.path} + $filePath");
      final result = await OpenFilex.open(filePath);

      log(result.message);
      log(result.type.name);
      log(result.toString());
    } else {
      log('File not found: $filePath');
    }
  }
}
