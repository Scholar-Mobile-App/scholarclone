import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/student/classwork_gallery_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

class ClassworkGalleryController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;
  Map<String, dynamic>? resJson;

  RxList<ClassworkGallery> classworkList = <ClassworkGallery>[].obs;

  RxDouble progress = 0.0.obs;

  RxString fromDate = "".obs;
  RxString toDate = "".obs;

  @override
  void onInit() {
    callService();
    Permission.storage.request();
    super.onInit();
  }

  Future<void> callService() async {
    final String from = DateFormat('yyyy-MM-dd').format(
        fromDate.value.isNotEmpty
            ? DateTime.parse(fromDate.value)
            : DateTime.now());
    final String to = DateFormat('yyyy-MM-dd').format(toDate.value.isNotEmpty
        ? DateTime.parse(toDate.value)
        : DateTime.now());

    isLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        callMethod: CallMethod.get,
        apiUrl:
            "https://erp.triz.co.in/front_desk/send_attachment/create?type=API&sub_institute_id=${userInfo[CS.sub_institute_id]}&syear=${userInfo[CS.syear] ?? syear}&token=${userInfo[CS.token]}&from_date=$from&to_date=$to&student_id=${userInfo[CS.student_id]}",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    ClassworkGalleryModel model = ClassworkGalleryModel.fromJson(resJson!);
    classworkList.value = model.sentData ?? [];
    isLoading.value = false;
  }

  Future<void> openFile(String filePath) async {
    final file = File(filePath);

    if (file.existsSync()) {
      log("File $filePath");
      final result = await OpenFilex.open(filePath);

      log(result.message);
      log(result.type.name);
      log(result.toString());
    } else {
      log('File not found: $filePath');
    }
  }
}
