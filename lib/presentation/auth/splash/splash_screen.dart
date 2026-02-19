import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/presentation/auth/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.amber,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppImage.splashBg),
          ),
        ),
      ),
    );
  }
}
