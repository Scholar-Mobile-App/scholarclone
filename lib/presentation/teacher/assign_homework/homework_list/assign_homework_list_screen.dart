import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/teacher/assign_homework/homework_list/assign_homework_list_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class AssignHomeWorkListScreen extends StatelessWidget {
  AssignHomeWorkListScreen({super.key});
  final AssignHomeWorkListController _controller =
      Get.put(AssignHomeWorkListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(
        text: "Homework",
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.assignHomeWork,
                  arguments: [_controller.data, _controller.userInfo],
                );
              },
              child: const Text(
                "Add",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          wSizeBox20,
        ],
      ),
      body: Obx(
        () => Stack(
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
            Column(
              children: [
                searchAndFilterBox(),
                hSizeBox20,
                Expanded(
                  child: _controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : _controller.homeworkList.isEmpty
                          ? CU.getNodataDesign()
                          : ListView.separated(
                              padding: const EdgeInsets.all(20),
                              itemCount: _controller.homeworkList.length,
                              separatorBuilder: (context, index) => hSizeBox10,
                              itemBuilder: (context, index) {
                                var notification =
                                    _controller.homeworkList[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              notification.studentName ?? "",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          if ((notification.fileName ?? "")
                                              .isNotEmpty)
                                            GestureDetector(
                                              onTap: () {
                                                log("...............${notification.fileName ?? ""}");
                                                downloadExport(
                                                  context: Get.context!,
                                                  fileUrl:
                                                      notification.fileName ??
                                                          "",
                                                  filename: "circular",
                                                );
                                              },
                                              child: Image.asset(
                                                AppImage.icnAttached,
                                                height: 16.0,
                                                width: 16.0,
                                              ),
                                            ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              notification.subjectName ?? "",
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "${notification.standardName ?? ""} - ${notification.divisionName ?? ""}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      hSizeBox4,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              notification.title ?? "",
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            notification.date ?? "",
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      hSizeBox4,
                                      Text(
                                        notification.description ?? "",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  searchAndFilterBox() => Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
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
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: dateRangeTimeTextField(
                context: Get.context!,
                title: "From Date",
                date: _controller.fromDate.value,
                onTap: (value) {
                  _controller.fromDate.value = value;
                  _controller.callService();
                }),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: dateRangeTimeTextField(
              title: "To Date",
              date: _controller.toDate.value,
              onTap: (value) {
                _controller.toDate.value = value;
                _controller.callService();
              },
              context: Get.context!,
            ),
          ),
        ]),
      );
}
