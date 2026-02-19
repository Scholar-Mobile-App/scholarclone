import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/teacher_gallery_mogel.dart';

import '../../../core/utils/cs.dart';

class GallaryController extends GetxController {
  @override
  void onInit() {
    callServiceAPI();
    super.onInit();
  }

  TeacherGalleryModel? teacherGalleryModel;

  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];
  bool isAdmin = Get.arguments[2];

  RxInt tabIndex = 0.obs;

  Map<String, dynamic> resJson = {};

  RxBool isLoading = false.obs;

  String? getYoutubeThumbnail(String videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return null;
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }

  Future<void> callServiceAPI() async {
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      if (userInfo["user_profile_name"] == "Teacher")
        "standard_id": userInfo[CS.standard_division].toString().split("||")[0],
      CS.type: tabIndex.value == 0 ? "Photo" : "Video",
      CS.token: userInfo[CS.token],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: userInfo["user_profile_name"] == "Admin"
            ? "https://erp.triz.co.in/get_adminPhotoVideoAPI"
            : "https://erp.triz.co.in/photo_video_gallary/TeacherFetchData",
        isShowProgressDialog: false,
      );
    } else {
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      TeacherGalleryModel model = TeacherGalleryModel.fromJson(resJson);
      teacherGalleryModel = model;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
    isLoading.value = false;
  }
}
