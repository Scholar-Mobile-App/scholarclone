import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

import 'exam_schedule_controller.dart';

class ExamScheduleScreen extends StatelessWidget {
  ExamScheduleScreen({super.key});
  final ExamScheduleController _controller = Get.put(ExamScheduleController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          _controller.data.subTitle!,
          rounded: false,
        ),
        body: _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.examScheduleList.isEmpty
                ? CU.getNodataDesign()
                : ListView.separated(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  DateFormat('dd MMM, yyyy').format(exam.date!),
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
      ),
    );
  }
}
