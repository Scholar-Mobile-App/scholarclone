import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import 'task_controller.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});
  final TaskController _controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(
        text: "View Task",
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.addTask, arguments: [
                _controller.data,
                _controller.userInfo,
              ]);
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
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.taskList.isEmpty
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
                        itemCount: _controller.taskList.length,
                        separatorBuilder: (context, index) => hSizeBox10,
                        itemBuilder: (context, index) {
                          var task = _controller.taskList[index];
                          return Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(
                                top: 15, left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 3,
                                color: (task.status == "COMPLETED")
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Task By : ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              task.allocator.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      hSizeBox6,
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Title : ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.purple,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${task.taskTitle}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Colors.deepPurple,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${task.taskDescription}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.deepPurple,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                (task.status == "COMPLETED")
                                    ? Container(
                                        child: Image.asset(AppImage.approve,
                                            height: 30),
                                      )
                                    : Container(
                                        child: Image.asset(AppImage.reject,
                                            height: 30),
                                      ),
                                wSizeBox10,
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (task.taskAttachment != "")
                                        GestureDetector(
                                          onTap: () {
                                            downloadExport(
                                              context: context,
                                              fileUrl: task.taskAttachment!,
                                              filename: task.taskAttachment!,
                                            );
                                          },
                                          child: Container(
                                            child: Image.asset(
                                              AppImage.icnAttached,
                                              height: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Date : ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              DateFormat("MM-dd-yyyy")
                                                  .format(task.createdOn!),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Status : ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.purple,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${task.status}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    (task.status == "COMPLETED")
                                                        ? Colors.green
                                                        : Colors.red,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Allocate To : ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.purple,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${task.allocatedTo}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.green,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Updated On : ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.purple,
                                              fontSize: 8,
                                            ),
                                          ),
                                          Text(
                                            DateFormat("MM-dd-yyyy")
                                                .format(task.taskDate!),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 8,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
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
