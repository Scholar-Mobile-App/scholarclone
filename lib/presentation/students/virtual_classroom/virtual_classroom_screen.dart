import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/utility.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

import 'virtual_classroom_controller.dart';

class VirtualClassroomScreen extends StatelessWidget {
  VirtualClassroomScreen({super.key});
  final VirtualClassroomController _controller =
      Get.put(VirtualClassroomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        "Virtual Classroom",
        rounded: false,
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.virtualClassroomList.isEmpty
                ? CU.getNodataDesign()
                : Stack(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: CU.primaryColor,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                      ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        physics: const ClampingScrollPhysics(),
                        itemCount: _controller.virtualClassroomList.length,
                        separatorBuilder: (context, index) => hSizeBox10,
                        itemBuilder: (context, index) {
                          var virtualClassroom =
                              _controller.virtualClassroomList[index];
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
                                hSizeBox14,
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 3,
                                      backgroundColor: CU.heliotropeColor,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "  By ${virtualClassroom.teacherName}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: CU.textColorlight,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    if (virtualClassroom.toTime != null)
                                      Image.asset(
                                        AppImage.icnTime,
                                        height: 12,
                                        color: CU.textColorlight,
                                      ),
                                    wSizeBox4,
                                    Text(
                                      virtualClassroom.toTime != null
                                          ? _controller.convertTo12HourFormat(
                                              virtualClassroom.toTime ?? "")
                                          : "",

                                      // virtualClassroom.toTime != null
                                      //     ? " ${virtualClassroom.toTime.toString().substring(0, 5)} PM"
                                      //     : "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: CU.textColorlight,
                                        fontSize: 12,
                                      ),
                                    ),
                                    wSizeBox10,
                                    Icon(
                                      Icons.video_call,
                                      color: CU.secondaryColor,
                                      size: 15,
                                    ),
                                    Text(
                                      " Remaining",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: CU.secondaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                hSizeBox14,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${virtualClassroom.subjectName}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        wSizeBox6,
                                        if (virtualClassroom.eventDate != null)
                                          Text(
                                            "${DateFormat("dd-MM-yyyy").format(virtualClassroom.eventDate!)} ${_controller.convertTo12HourFormat(virtualClassroom.fromTime ?? "")}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: CU.textColorlight,
                                              fontSize: 12,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      height: 24,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          log(virtualClassroom.eventDate
                                              .toString());
                                          try {
                                            await launchURL(
                                              virtualClassroom.url!,
                                            );
                                          } catch (e) {
                                            showToast(
                                              context: context,
                                              message:
                                                  "Could not launch ${virtualClassroom.url!}",
                                              color: Colors.green,
                                              icons: Icons.check_circle_outline,
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          elevation: 0,
                                        ),
                                        child: const Text(
                                          "JOIN",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  height: 0.3,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Chapter:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 8,
                                      ),
                                    ),
                                    Text(
                                      "  ${virtualClassroom.chapterName!}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: CU.textColorlight,
                                        fontSize: 8,
                                      ),
                                    ),
                                    wSizeBox20,
                                    const Text(
                                      "Topic:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 8,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "  ${virtualClassroom.topicName!}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: CU.textColorlight,
                                          fontSize: 8,
                                        ),
                                      ),
                                    )
                                  ],
                                )
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
