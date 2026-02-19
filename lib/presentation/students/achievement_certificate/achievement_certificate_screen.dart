import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'achievement_certificate_controller.dart';

class AchievementCertificateScreen extends StatelessWidget {
  AchievementCertificateScreen({super.key});
  final AchievementCertificateController _controller =
      Get.put(AchievementCertificateController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
