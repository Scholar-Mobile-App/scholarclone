import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/teacher_task_model.dart';

class TaskController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  RxList<Task> taskList = <Task>[].obs;

  Map<String, dynamic> resJson = {};

  @override
  void onInit() {
    callServiceAllocate();
    super.onInit();
  }

  Future<void> callServiceAllocate() async {
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      if (userInfo["user_profile_name"] == "Teacher")
        CS.teacher_id: userInfo[CS.teacher_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: userInfo["user_profile_name"] == "Admin"
            ? "https://erp.triz.co.in/get_taskAPI"
            : "https://erp.triz.co.in/get_teachertaskAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceAllocate);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      TeacherTaskModel model = TeacherTaskModel.fromJson(resJson);
      taskList.value += model.data!;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
