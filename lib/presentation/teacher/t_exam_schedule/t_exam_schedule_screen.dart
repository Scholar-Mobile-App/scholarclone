import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import 't_exam_schedule_controller.dart';

class TeacherExamScheduleScreen extends StatelessWidget {
  TeacherExamScheduleScreen({super.key});
  final TeacherExamScheduleController _controller =
      Get.put(TeacherExamScheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(
        text: "Exam Schedule",
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(
                AppRoutes.addExam,
                arguments: [_controller.data, _controller.userInfo],
              );
            },
            child: const Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? const CircularProgressIndicator.adaptive()
            : _controller.examScheduleList.isEmpty
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        physics: const ClampingScrollPhysics(),
                        itemCount: _controller.examScheduleList.length,
                        separatorBuilder: (context, index) => hSizeBox10,
                        itemBuilder: (context, index) {
                          var exam = _controller.examScheduleList[index];

                          return Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.grey.shade100,
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            exam.title ?? "",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          TextButton.icon(
                                            onPressed: () {
                                              downloadExport(
                                                context: context,
                                                fileUrl: exam.fileName!,
                                                filename: exam.fileName!,
                                                open: true,
                                              );
                                            },
                                            icon: Image.asset(
                                              AppImage.attached,
                                              height: 12.0,
                                              width: 12.0,
                                              color: Colors.blue,
                                            ),
                                            label: const Text(
                                              "Attachment",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      DateFormat('dd MMM, yyyy')
                                          .format(exam.date!),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: CU.textColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
