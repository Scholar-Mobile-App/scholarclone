import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:get/get.dart';

class OnlineReceiptView extends StatelessWidget {
  const OnlineReceiptView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Fees Receipt"),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        color: Colors.white,
        child: HtmlWidget(
          Get.arguments,
        ),
      ),
    );
  }
}
