import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

import 't_teacher_resource_controller.dart';

class TeacherResourceScreen extends StatelessWidget {
  TeacherResourceScreen({super.key});

  final TeacherResourceController _controller =
      Get.put(TeacherResourceController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Teacher Resource"),
        body: _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.resourceList.isEmpty
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
                            horizontal: 20, vertical: 20),
                        itemCount: _controller.resourceList.length,
                        separatorBuilder: (context, index) => hSizeBox10,
                        itemBuilder: (context, index) {
                          var resource = _controller.resourceList[index];

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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 3,
                                      backgroundColor: CU.heliotropeColor,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "  By ${resource.teacherName}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: CU.textColorlight,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    if (resource.fileName!.isNotEmpty)
                                      GestureDetector(
                                        onTap: () async {
                                          downloadExport(
                                            context: context,
                                            fileUrl: resource.fileName!,
                                            filename: resource.fileName!,
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.attach_file,
                                              color: CU.secondaryColor,
                                              size: 15,
                                            ),
                                            Text(
                                              " Attechment",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: CU.secondaryColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                hSizeBox14,
                                Text(
                                  "${resource.subjectName}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                hSizeBox6,
                                Text(
                                  resource.title ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: CU.textColorlight,
                                    fontSize: 12,
                                  ),
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
                                      "  ${resource.chapterName}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: CU.textColorlight,
                                        fontSize: 8,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text(
                                      "Topic:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 8,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "  ${resource.topicName}",
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
                      )
                    ],
                  ),
      ),
    );
  }
}
