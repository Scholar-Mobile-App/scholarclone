import 'package:dio/dio.dart' as dio;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../core/utils/cs.dart';
import '../../../model/teacher/assign_homework/section_model.dart';

class AddPhotoVideoController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxInt tabIndex = 0.obs;
  RxInt stdId = 0.obs;
  RxInt divId = 0.obs;

  RxString albumtitle = "".obs;
  RxString phototitle = "".obs;
  RxString youTubeLink = "".obs;

  RxList<String> images = <String>[].obs;
  RxList<String> videosThumbnais = <String>[].obs;
  RxList<String> videosPath = <String>[].obs;
  RxList<String> stdName = <String>[].obs;
  RxList<String> divName = <String>[].obs;
  RxList<String> subjectName = <String>[].obs;

  Map<String, dynamic> resJson = <String, dynamic>{};

  StandardModel? standardModel;
  DivisionModel? divisionModel;

  RxString albumTitleError = "".obs;
  RxString photoTitleError = "".obs;
  RxString attechmentError = "".obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    callServiceStandared();
    super.onInit();
  }

  bool valid() {
    final RxBool isValid = true.obs;
    albumTitleError.value = '';
    photoTitleError.value = '';
    attechmentError.value = '';

    if (albumtitle.value.isEmpty) {
      albumTitleError.value = "The title field is required.";
      CU.showToast(Get.context!, albumTitleError.value);
      isValid.value = false;
    } else if (phototitle.value.isEmpty) {
      photoTitleError.value = "The album title field is required.";
      CU.showToast(Get.context!, photoTitleError.value);
      isValid.value = false;
    } else if (tabIndex.value == 0) {
      if (images.isEmpty) {
        attechmentError.value = "The attachment field is required.";
        CU.showToast(Get.context!, attechmentError.value);
        isValid.value = false;
      }
    } else {
      if (youTubeLink.value.isEmpty) {
        attechmentError.value = "The Youtube link field is required.";
        CU.showToast(Get.context!, attechmentError.value);
        isValid.value = false;
      }
    }

    return isValid.value;
  }

  pickPhotos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png"],
      allowMultiple: true,
    );
    result!.files.forEach((element) async {
      images.add(element.path!);
    });
  }

  pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["mp4"],
      allowMultiple: true,
    );
    result!.files.forEach((element) async {
      videosPath.add(element.path!);

      addVideoThumbnail(element.path!);
    });
  }

  Future<void> addVideoThumbnail(String videoPath) async {
    // Generate thumbnail
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      quality: 50,
    );

    // Add thumbnail path to the list
    videosThumbnais.add(thumbnailPath!);
  }

  Future<void> callServiceStandared() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.type: "API",
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_teacher_timetablewiseStandard",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandared);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      StandardModel model = StandardModel.fromJson(resJson);

      standardModel = model;

      for (int i = 0; i < model.data!.length; i++) {
        stdName.add(model.data![i].stdName!);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: true,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceDivision() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.type: "API",
      "standard_id": stdId,
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_teacher_timetablewiseDivision",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandared);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      DivisionModel model = DivisionModel.fromJson(resJson);
      divisionModel = model;
      for (int i = 0; i < model.data!.length; i++) {
        divName.add(model.data![i].divName!);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceSubmit() async {
    if (valid()) {
      isLoading.value = true;

      dio.FormData formData = dio.FormData.fromMap({
        CS.user_id: userInfo[CS.teacher_id],
        "standard_id": stdId.value,
        "division_id": divId.value,
        "date_": DateTime.now(),
        "album_title": albumtitle.value,
        "title": phototitle.toString(),
        CS.syear: userInfo[CS.syear] ?? syear,
        CS.sub_institute_id: userInfo[CS.sub_institute_id],
        CS.token: userInfo[CS.token],
        "type": tabIndex.value == 0 ? "Photo" : "Video",
        if (tabIndex.value != 0) "youtube_link": youTubeLink.value
      });

      if (tabIndex.value == 0 && images.isNotEmpty) {
        for (int i = 0; i < (images.length); i++) {
          formData.files.addAll([
            MapEntry(
              "attachment[$i]",
              await dio.MultipartFile.fromFile(images[i]),
            )
          ]);
        }
      }
      if (await CU.checkInternet()) {
        resJson = await ApiClient.call(
          Get.context!,
          body: formData,
          isFormData: false,
          apiUrl: "https://erp.triz.co.in/add_adminPhotoVideoAPI",
          isShowProgressDialog: false,
        );
      } else {
        CU.showNoInternetDialog(Get.context!, callServiceSubmit);
        return;
      }

      if (resJson[CS.status].toString() == StatusCode.Success) {
        Fluttertoast.showToast(
          msg: resJson[CS.message],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        isLoading.value = false;
        Get.back();
      } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
          resJson[CS.status].toString() == StatusCode.Authentication) {
        showDialog(
          builder: (context) => CU.showDiloag(context, resJson[CS.message]),
          barrierDismissible: false,
          context: Get.context!,
        );
        isLoading.value = false;
      }
      isLoading.value = false;
    }
  }
}
