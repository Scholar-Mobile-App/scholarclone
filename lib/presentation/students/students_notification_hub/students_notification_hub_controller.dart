import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/student/notification_model.dart';

class StudentNotificationHubController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic>? resJson;

  RxList<Note> notificationList = <Note>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Future<void> callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.student_id: userInfo[CS.student_id],
      CS.mobile_no: userInfo[CS.mobile],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
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
    if (resJson![CS.status].toString() == StatusCode.Success.toString()) {
      NotificationModel model = NotificationModel.fromJson(resJson!);
      for (var i = 0; i < model.data!.length; i++) {
        notificationList.add(model.data![i]);
      }
      isLoading.value = false;
    } else if (resJson![CS.status].toString() == StatusCode.Error) {
      notificationList.value = [];
      isLoading.value = false;
    }
  }

  getAgo(strDate) {
    try {
      Duration diff = DateTime.now()
          .difference(DateFormat("yyyy-MM-dd hh:mm:ss").parse(strDate));
      if (diff.inMinutes == 0) {
        return "Just Now";
      } else if (diff.inMinutes < 60) {
        return "${diff.inMinutes} Min ago";
      } else if (diff.inHours < 24) {
        return "${diff.inHours} Hours ago";
      } else if (diff.inDays < 2) {
        return "${diff.inDays} Day ago";
      } else {
        return DateFormat('dd MMM yy hh:mm a')
            .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(strDate));
      }
    } catch (e) {
      return strDate;
    }
  }
}
