import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../../widgets/app_bar.dart';
import 'receipt_view_controller.dart';

class ReceiptViewScreen extends StatelessWidget {
  final String htmltext;
  final Map<String, dynamic> userInfo;
  final String receiptID;

  ReceiptViewScreen({
    super.key,
    required this.htmltext,
    required this.userInfo,
    required this.receiptID,
  });

  final ReceiptViewController _controller = Get.put(ReceiptViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Receipt", rounded: false, actions: [
        IconButton(
          onPressed: () {
            _controller.callServiceReport(context, userInfo, receiptID);
          },
          icon: const Icon(Icons.download),
        ),
      ]),
      body: HtmlWidget(htmltext),
    );
  }
}
