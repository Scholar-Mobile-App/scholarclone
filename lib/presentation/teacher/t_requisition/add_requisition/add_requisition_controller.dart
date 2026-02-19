import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/ip_info_api.dart';
import 'package:scholar_clone/core/utils/utility.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/admin_item_list_model.dart';

class AddRequisitionController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  final GlobalKey<FormFieldState> itemKey = GlobalKey<FormFieldState>();

  RxList<AdminItem> itemList = <AdminItem>[].obs;
  RxList<String> itemName = <String>[].obs;

  Rx<DateTime> requisitionDate = DateTime.now().obs;
  Rx<DateTime> expectedDeliveryDate = DateTime.now().obs;

  RxString qty = "".obs;
  RxString unit = "".obs;
  RxString remarks = "".obs;
  RxString imageFile = "".obs;

  RxInt itemID = 0.obs;

  Map<String, dynamic> resJson = {};

  @override
  void onInit() {
    callServiceItems();
    super.onInit();
  }

  bool valid() {
    final RxBool isValid = true.obs;

    if (itemID.value == 0) {
      CU.showToast(Get.context!, "Please select a Item");
      isValid.value = false;
    } else if (qty.value.isEmpty) {
      CU.showToast(Get.context!, "The item qty field is required.");
      isValid.value = false;
    } else if (remarks.value.isEmpty) {
      CU.showToast(Get.context!, "The remarks field is required.");
      isValid.value = false;
    }

    return isValid.value;
  }

  pickPhotos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "pdf"],
      allowMultiple: false,
    );

    imageFile.value = result!.files.first.path!;
  }

  Future<void> callServiceItems() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(Get.context!,
          body: body,
          apiUrl: "http://dev.triz.co.in/get_adminItemListAPI",
          isShowProgressDialog: false);
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceItems);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      AdminItemListModel model = AdminItemListModel.fromJson(resJson);

      itemList.value = model.data!;

      if (itemList.isNotEmpty) {
        for (var i = 0; i < model.data!.length; i++) {
          itemName.add(itemList[i].title!);
        }
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callService(context) async {
    if (valid()) {
      Map<String, dynamic> body = <String, dynamic>{
        CS.token: userInfo[CS.token],
        CS.syear: userInfo[CS.syear] ?? syear,
        CS.sub_institute_id: userInfo[CS.sub_institute_id],
        "requisition_by": userInfo["user_profile_name"] == "Admin"
            ? userInfo[CS.user_id]
            : userInfo[CS.teacher_id],
        "item_id": itemID.value,
        "item_unit": unit.value,
        "item_qty": qty.value,
        "expected_delivery_time": expectedDeliveryDate.value,
        "remarks": remarks.value,
        "created_by": userInfo["user_profile_name"] == "Admin"
            ? userInfo[CS.user_id]
            : userInfo[CS.teacher_id],
        "created_ip_address": await IpInfoApi.getIpAddress(),
      };

      if (await CU.checkInternet()) {
        resJson = await ApiClient.call(
          context,
          body: body,
          apiUrl: "https://erp.triz.co.in/add_teacherRequisitionAPI",
          isShowProgressDialog: false,
        );
      } else {
        CU.showNoInternetDialog(context, callService);
        return;
      }

      if (resJson[CS.status].toString() == StatusCode.Success) {
        showToast(
          context: context,
          message: resJson[CS.message],
          color: Colors.green,
          icons: Icons.check_circle_outline,
        );
        Get.back();
      } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
          resJson[CS.status].toString() == StatusCode.Authentication) {
        showDialog(
          builder: (context) => CU.showDiloag(context, resJson[CS.message]),
          barrierDismissible: false,
          context: context,
        );
      }
    }
  }
}
