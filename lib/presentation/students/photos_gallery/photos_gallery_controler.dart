import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/student/photos_gallery_model.dart';

class PhotoGalleryController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isPhoto = true.obs;
  RxBool isLoading = false.obs;

  Map<String, dynamic>? resJson;

  PhotosGalleryModel? photosGalleryModel;

  @override
  void onInit() {
    isPhoto.value = data.screenName == "photos_gallery";
    callService();
    super.onInit();
  }

  Future<void> callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.type: "API",
      CS.student_id: userInfo[CS.student_id],
      CS.token: userInfo[CS.token],
      CS.action: isPhoto.value ? "Photo" : "Video",
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

    if (resJson![CS.status].toString() == StatusCode.Success) {
      PhotosGalleryModel model = PhotosGalleryModel.fromJson(resJson!);
      photosGalleryModel = model;
      isLoading.value = false;
    } else if (resJson![CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson![CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );

      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
