import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import 't_message_controller.dart';

class TMessageScreen extends StatelessWidget {
  TMessageScreen({super.key});
  final TMessageController _controller = Get.put(TMessageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(
        text: "Own Message",
      ),
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(Get.width / 2, 30),
                bottomRight: Radius.elliptical(Get.width / 2, 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
