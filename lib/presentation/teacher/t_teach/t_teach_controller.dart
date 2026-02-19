import 'package:get/get.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/teacher/teach_model.dart';

class TeachController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxList<Teach> teachList = <Teach>[].obs;

  RxBool isLoading = false.obs;

  Map<String, dynamic> resJson = {};

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Future<void> callService() async {
    isLoading.value = true;
    var string = userInfo[CS.standard_division];
    var ans = string.split("||");

    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.token: userInfo[CS.token],
      CS.type: "API",
      "standard_id": ans[0].trim(),
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_teacher_timetablewiseSubject",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      TeachModel model = TeachModel.fromJson(resJson);
      teachList.value += model.data!;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
