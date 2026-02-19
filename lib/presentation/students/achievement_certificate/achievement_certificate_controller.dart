import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/student/achievement_cetificate_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

import '../../../core/utils/cs.dart';

class AchievementCertificateController extends GetxController {
  Content content = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];
  Map<String, dynamic> resJson = {};

  RxBool isLoading = false.obs;

  RxList<AchievementCertificateModel> certificateList =
      <AchievementCertificateModel>[].obs;
  @override
  void onInit() {
    callServiceTab();

    super.onInit();
  }

  Future<void> callServiceTab() async {
    isLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        callMethod: CallMethod.get,
        apiUrl:
            "https://erp.triz.co.in/document_details?type=API&sub_institute_id=${userInfo[CS.sub_institute_id]}&document_type=59&student_id=${userInfo[CS.student_id]}",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(
        Get.context!,
        callServiceTab(),
      );
      return;
    }

    AchievementCertificateModel model =
        AchievementCertificateModel.fromJson(resJson);
    certificateList.value = model as List<AchievementCertificateModel>;
    // if (resJson[CS.status].toString() == StatusCode.Success) {
    // } else if (resJson[CS.status].toString() == StatusCode.Error) {
    //   showDialog(
    //     builder: (context) => CU.showDiloag(context, resJson[CS.message]),
    //     barrierDismissible: false,
    //     context: Get.context!,
    //   );
    // }
    isLoading.value = false;
  }
}
