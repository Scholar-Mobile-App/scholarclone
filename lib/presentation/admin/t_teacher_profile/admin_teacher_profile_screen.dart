import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import 'admin_teacher_profile_controller.dart';

class AdminTeacherProfileScreen extends StatelessWidget {
  AdminTeacherProfileScreen({super.key});
  final AdminTeacherProfileController _controller =
      Get.put(AdminTeacherProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Teacher Profile"),
        body: _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.teacherProfileList.isEmpty
                ? CU.getNodataDesign()
                : Stack(
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
                      ListView.separated(
                        itemCount: _controller.teacherProfileList.length,
                        separatorBuilder: (context, index) => hSizeBox10,
                        itemBuilder: (context, index) {
                          var teacherProfile =
                              _controller.teacherProfileList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.teacherProfile,
                                arguments: teacherProfile,
                              );
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: Get.width * 0.15,
                                        width: Get.width * 0.15,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: teacherProfile.image != ""
                                                ? NetworkImage(
                                                    teacherProfile.image!)
                                                : const ExactAssetImage(
                                                        AppImage.profile)
                                                    as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      wSizeBox10,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              teacherProfile.userFullName ?? "",
                                              style: TextStyle(
                                                color: CU.tprimaryColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            hSizeBox4,
                                            Text(
                                              teacherProfile.userProfileName ??
                                                  "",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            hSizeBox4,
                                            Text(
                                              teacherProfile.mobile ?? "",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            hSizeBox4,
                                            Text(
                                              "D.O.B: ${DateFormat('yyyy-MM-dd').format(teacherProfile.birthdate!)}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
      ),
    );
  }
}
