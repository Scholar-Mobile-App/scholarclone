import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/student/leave_model.dart';

class LeaveController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(handleTabSelection);
    callServiceStatusTab();
    super.onInit();
  }

  RxInt tabIndex = 0.obs;
  void handleTabSelection() {
    tabIndex.value = tabController?.index ?? 0;
    update();
  }

  TabController? tabController;

  RxList<Choice> choices = [
    const Choice(
      title: 'Leave',
      icon: AppImage.leave,
    ),
    const Choice(
      title: 'Status',
      icon: AppImage.status,
    ),
  ].obs;

  TextEditingController fromDateCon = TextEditingController();
  TextEditingController toDateCon = TextEditingController();
  TextEditingController txtday = TextEditingController();
  TextEditingController txthours = TextEditingController();
  TextEditingController description = TextEditingController();

  RxString fromDateError = "".obs;
  RxString toDateError = "".obs;
  RxString descriptionError = "".obs;

  Rx<File> profileImage = File("").obs;
  dio.MultipartFile? multipartFile;

  DateTime? toFromDate;
  DateTime fromdate = DateTime.now();
  String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  Rx<Item?> selectedItem = Rx<Item?>(null);

  void selectItem(Item? item) {
    selectedItem.value = item;
  }

  List<Item> users = [
    const Item('Sick Leave'),
    const Item('Full Leave'),
    const Item('Half Leave'),
    const Item('Short Leave'),
  ];

  Map<String, dynamic>? responseJson;
  Map<String, dynamic>? resJson;
  RxList<Leave> leaveList = <Leave>[].obs;

  RxBool isLoading = false.obs;

  Future<void> selectDate(BuildContext context, TextEditingController txtdate,
      DateTime startDate) async {
    log("SelectData=====>");
    log(fromdate.toString());
    log(startDate.toString());
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: txtdate == fromDateCon ? fromdate : startDate,
        firstDate: startDate,
        lastDate: DateTime(2101));
    if (picked != fromdate) {
      if (txtdate == fromDateCon) {
        toFromDate = picked;
      }
      txtdate.text = DateFormat('yyyy-MM-dd').format(picked!);
    }
  }

  Future picImage(bool fromGallery) async {
    XFile? pickedFile;
    try {
      pickedFile = await ImagePicker().pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
        maxHeight: 500,
        maxWidth: 500,
      );
    } catch (e) {
      print(e);
    }
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 300, ratioY: 300),
        compressQuality: 50,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Edit',
            statusBarColor: AppColor.primaryColor,
            toolbarColor: AppColor.bgColor,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Edit',
          ),
        ],
      );
      if (croppedFile != null) {
        profileImage.value = File(croppedFile.path);
        print("===IMAGE SIZE==");
        print(profileImage.value.readAsBytesSync().lengthInBytes);
        multipartFile = dio.MultipartFile.fromFileSync(
          File(croppedFile.path).path,
          filename: path.basename(File(croppedFile.path).path),
        );
      }
    } else {
      return;
    }
  }

  bool valid() {
    RxBool isValid = true.obs;

    if (fromDateCon.text.isEmpty) {
      fromDateError.value = "Please select from date";
      isValid.value = false;
    }

    if (toDateCon.text.isEmpty) {
      toDateError.value = "Please select to date";
      isValid.value = false;
    }

    if (description.text.isEmpty) {
      descriptionError.value = "Please select your description";
      isValid.value = false;
    }

    // if (profileImage.value.path.isEmpty) {
    //   Fluttertoast.showToast(
    //     msg: "Please upload your image",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.TOP,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0,
    //   );
    //   isValid.value = false;
    // }

    return isValid.value;
  }

  Future<void> callService() async {
    dio.FormData body = dio.FormData.fromMap({
      CS.student_id: userInfo[CS.student_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.message: description.text,
      CS.apply_date: currentDate,
      CS.from_date: fromDateCon.text,
      CS.to_date: toDateCon.text,
      CS.type: "API",
      CS.title: selectedItem.value!.name,
      CS.token: userInfo[CS.token],
      CS.attechment:
          profileImage.value.path.isEmpty ? null : profileImage.value.path,
    });

    if (profileImage.value.path.isNotEmpty) {
      body.files.add(
        MapEntry(CS.attechment,
            await dio.MultipartFile.fromFile(profileImage.value.path)),
      );
    }

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        isFormData: false,
        apiUrl: CS.addleaveapplication,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    toDateCon.clear();
    fromDateCon.clear();
    description.clear();
    profileImage.value = File("");
    selectedItem.value = null;

    if (resJson![CS.status].toString() == StatusCode.Success) {
      Fluttertoast.showToast(
        msg: "Leave request successfully sent",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else if (resJson![CS.status].toString() == StatusCode.Error ||
        resJson![CS.status].toString() == StatusCode.Authentication) {
      showDialog(
          builder: (context) => CU.showDiloag(context, resJson![CS.message]),
          barrierDismissible: false,
          context: Get.context!);
    }
  }

  Future<void> callServiceStatusTab() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.student_id: userInfo[CS.student_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.type: "API",
      CS.token: userInfo[CS.token],
    };

    isLoading.value = true;

    if (await CU.checkInternet()) {
      responseJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: CS.studentLeaveApplicationAPI,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStatusTab);
      return;
    }

    if (responseJson![CS.status].toString() == StatusCode.Success) {
      try {
        LeaveModel model = LeaveModel.fromJson(responseJson!);

        for (var i = 0; i < model.data!.length; i++) {
          leaveList.add(model.data![i]);
        }
      } catch (e) {
        // Handle date parsing errors gracefully
        print("Error parsing leave data: $e");
        Fluttertoast.showToast(
          msg: "Error loading leave data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      isLoading.value = false;
    } else if (responseJson![CS.status].toString() == StatusCode.Error ||
        responseJson![CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, responseJson![CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isLoading.value = false;
    }
  }
}

class Choice {
  const Choice({
    required this.title,
    required this.icon,
  });

  final String title;
  final String icon;
}

class Item {
  final String name;
  const Item(this.name);
}
