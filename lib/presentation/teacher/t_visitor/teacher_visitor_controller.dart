import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/teacher/visitor_model.dart';

class TeacherVisitorController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  RxList<Visitor> visitorList = <Visitor>[].obs;

  Map<String, dynamic> resJson = {};

  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Future<void> callService() async {
    visitorList.clear();
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      "from_date": DateFormat('yyyy-MM-dd').format(fromDate.value),
      "to_date": DateFormat('yyyy-MM-dd').format(toDate.value),
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      if (userInfo["user_profile_name"] == "Teacher")
        CS.teacher_id: userInfo[CS.teacher_id],
      CS.token: userInfo[CS.token],
      if (userInfo["user_profile_name"] == "Teacher") CS.type: "API"
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: userInfo["user_profile_name"] == "Admin"
            ? "https://erp.triz.co.in/get_adminVisitorListAPI"
            : "https://erp.triz.co.in/get_visitorAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      VisitorModel model = VisitorModel.fromJson(resJson);
      visitorList.value += model.data!;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
