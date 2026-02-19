import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/teacher/approve_student_leave/approve_student_leave_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

import '../../../model/teacher/students_leaves_approve_model.dart';

class ApproveStudentLeaveScreen extends StatelessWidget {
  ApproveStudentLeaveScreen({super.key});
  final ApproveStudentLeaveController _controller =
      Get.put(ApproveStudentLeaveController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Student Leaves"),
        body: Stack(
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
            _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : _controller.studentsLeavesList.isEmpty
                    ? CU.getNodataDesign()
                    : ListView.separated(
                        itemCount: _controller.studentsLeavesList.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        separatorBuilder: (context, index) => hSizeBox10,
                        itemBuilder: (context, index) {
                          var data = _controller.studentsLeavesList[index];
                          return Container(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
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
                                profile(data),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Reason: ${data.title}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data.message ?? "",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (data.reply!.text == "" ||
                                    data.replyOn.toString() == "" ||
                                    data.replyBy == "")
                                  Column(
                                    children: [
                                      textFieldController(
                                        data.reply!,
                                        title: "",
                                        hintText: "Enter Reply...",
                                        maxLine: 3,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AppButton(
                                              text: "Approve",
                                              color: Colors.green,
                                              onTap: () {
                                                _controller.callServiceReply(
                                                  data,
                                                  "Approved",
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: AppButton(
                                              text: "Reject",
                                              color: Colors.red,
                                              onTap: () {
                                                _controller.callServiceReply(
                                                  data,
                                                  "Rejected",
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                else
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Reply : ",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    data.reply!.text,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Status : ",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                data.status ?? "",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                // data.replyOn.toString() ?? "",
                                                data.replyOn == null
                                                    ? ""
                                                    : "Date: ${DateFormat('dd-MM-yyyy hh:mm').format(data.replyOn!)}",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                data.replyBy ?? "",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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

  Widget profile(StudentLeaves list) {
    return Row(
      children: [
        Container(
          height: Get.width * 0.18,
          width: Get.width * 0.18,
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: list.studentImage!.isEmpty
                  ? const AssetImage("assets/images/profile.png")
                  : NetworkImage(list.studentImage!) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${list.studentName}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: CU.tprimaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${list.stdName}th Class",
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Date: ${DateFormat('dd-MM-yyyy').format(list.applyDate!)}",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        if (list.fileName != "")
          GestureDetector(
            onTap: () async {
              await launchURL(list.fileName!);
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Center(
                    child: Image.asset(
                      AppImage.attached,
                      height: 12.0,
                      width: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Attachment",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
