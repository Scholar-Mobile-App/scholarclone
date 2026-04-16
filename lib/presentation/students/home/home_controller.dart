import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/student_main/student_main_controller.dart';

class HomeController extends GetxController {
  final StudentMainController studentMainController =
      Get.put(StudentMainController());

  final StudentMainController studentProfileController =
      Get.find<StudentMainController>();

  final RxInt previousFees = 0.obs;
  final RxInt currentFees = 0.obs;
  final RxInt apiStatus = 0.obs;

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  final RxBool isLoading = false.obs;

  Map<String, dynamic>? resJson;
  Future<void> callService() async {
    isLoading.value = true;
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        callMethod: CallMethod.get,
        apiUrl:
            "https://erp.triz.co.in/pending_fees?student_id=${studentProfileController.data[CS.student_id]}&sub_institute_id=${studentProfileController.data[CS.sub_institute_id]}&syear=${studentProfileController.data[CS.syear] ?? syear}&type=API",
        isShowProgressDialog: false,
      );
    } else {
      isLoading.value = false;
      return;
    }

    if (resJson != null) {
      previousFees.value = resJson?["previous_fees"] ?? 0;
      currentFees.value = resJson?["current_fees"] ?? 0;
      apiStatus.value = resJson?["api_status"] ?? 0;
    }

    isLoading.value = false;
  }
}
