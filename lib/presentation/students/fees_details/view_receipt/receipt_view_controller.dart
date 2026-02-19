import 'package:dio/dio.dart';
import 'package:get/get.dart' as GET;
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

class ReceiptViewController extends GET.GetxController {
  Future<void> callServiceReport(
      context, Map<String, dynamic> userInfo, String receiptId) async {
    if (await CU.checkInternet()) {
      Response response = await Dio().get(
          "https://erp.triz.co.in/ajax_PDF_FeesReceipt?action=fees_collect_receipt&type=API&sub_institute_id=${userInfo[CS.sub_institute_id]}&syear=${userInfo[CS.syear]}&student_id=${userInfo[CS.student_id]}&receipt_id_html=$receiptId");

      if (response.statusCode == 200) {
        downloadExport(
          context: context,
          fileUrl: response.data,
          filename: response.data,
        );
      }

      // resJson = await ApiClient.call(
      //   callMethod: CallMethod.get,
      //   GET.Get.context,
      //   apiUrl:
      //       "https://erp.triz.co.in/ajax_PDF_FeesReceipt?action=fees_collect_receipt&type=API&sub_institute_id=1&syear=2021&student_id=100234&receipt_id_html=104",
      //   isShowProgressDialog: false,
      // );
    } else {
      CU.showNoInternetDialog(GET.Get.context!, callServiceReport);
      return;
    }

    // downloadExport(
    //   context: context,
    //   fileUrl: task.taskAttachment!,
    //   filename: task.taskAttachment!,
    // );
  }
}
