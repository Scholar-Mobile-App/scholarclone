import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/teacher_list/teacher_list_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import '../../../core/utils/app_image.dart';

class TeacherListScreen extends StatelessWidget {
  TeacherListScreen({super.key});
  final TeacherListController _controller = Get.put(TeacherListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        "Teacher List",
        rounded: false,
      ),
      body: Stack(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          Obx(
            () => Column(
              children: [
                Expanded(
                  child: _controller.isLoading.value == true
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: _controller.filterteacherList.length,
                          separatorBuilder: (context, index) => hSizeBox10,
                          itemBuilder: (context, index) {
                            log(_controller.filterteacherList[index].image!);

                            return Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
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
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.grey,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: _controller
                                                        .filterteacherList[
                                                            index]
                                                        .image ==
                                                    null ||
                                                _controller
                                                    .filterteacherList[index]
                                                    .image!
                                                    .isEmpty
                                            ? Image.asset(AppImage.logo)
                                            : CachedNetworkImage(
                                                imageUrl: _controller
                                                    .filterteacherList[index]
                                                    .image!,
                                                placeholder: (context, url) =>
                                                    Image.asset(AppImage.logo),
                                                errorWidget: (context, url, error) =>
                                                    Image.asset(AppImage.logo),
                                              )
                                        // : CU.loadImage(
                                        //     url: _controller
                                        //         .filterteacherList[index]
                                        //         .image!,
                                        //     height: 56.0,
                                        //     boxFit: BoxFit.cover,
                                        //   ),
                                        ),
                                  ),
                                  wSizeBox16,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _controller.filterteacherList[index]
                                              .teacherName!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          _controller.filterteacherList[index]
                                              .subjectName!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: [
                                              "English",
                                              "Social Science"
                                            ].contains(_controller
                                                    .filterteacherList[index]
                                                    .subjectName)
                                                ? CU.secondaryColor
                                                : [
                                                    "Gujarati",
                                                    "Activity",
                                                    "Hindi"
                                                  ].contains(_controller
                                                        .filterteacherList[
                                                            index]
                                                        .subjectName)
                                                    ? CU.greenColor
                                                    : CU.textSubjectName,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
