import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/admin/admission_confirmation_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

class AdmissionConfirmationController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  RxList<AdmissionConfirmation> admissionConfirmationList =
      <AdmissionConfirmation>[].obs;

  Map<String, dynamic> resJson = {};

  @override
  void onInit() {
    callOutwardService();
    super.onInit();
  }

  Future<void> callOutwardService() async {
    isLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        callMethod: CallMethod.get,
        apiUrl:
            "https://erp.triz.co.in/admission/admission_confirmation?type=API&token=${userInfo[CS.token]}&sub_institute_id=${userInfo[CS.sub_institute_id]}&syear=${userInfo[CS.syear]}",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callOutwardService);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success.toString()) {
      AdmissionConfirmationModel model =
          AdmissionConfirmationModel.fromJson(resJson);
      admissionConfirmationList.value += model.data!;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  Future<void> callDeleteOutWard({required int id, required int index}) async {
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        apiUrl:
            "https://erp.triz.co.in/inward_outward/add_outward/$id?token=${userInfo[CS.token]}&type=API",
        isShowProgressDialog: false,
        callMethod: CallMethod.delete,
        body: {},
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callDeleteOutWard);
      return;
    }
    admissionConfirmationList.removeAt(index);
  }
}
