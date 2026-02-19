import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/teacher/t_complain/t_complain_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class TeacherComplainScreen extends StatelessWidget {
  TeacherComplainScreen({super.key});
  final TeacherComplainController _controller =
      Get.put(TeacherComplainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(
        text: "View Complain",
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.addComplain, arguments: [
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
            : _controller.complainList.isEmpty
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
                        itemCount: _controller.complainList.length,
                        separatorBuilder: (context, index) => hSizeBox10,
                        itemBuilder: (context, index) {
                          var complain = _controller.complainList[index];
                          return Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(
                                top: 15, left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 3,
                                  color: (complain.complaintSolution ==
                                          "COMPLETED")
                                      ? Colors.green
                                      : Colors.red),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Complain By : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: CU.secondaryColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        complain.complaintBy.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    if (complain.complaintAttachment != "")
                                      GestureDetector(
                                        onTap: () {
                                          downloadExport(
                                            context: context,
                                            fileUrl:
                                                complain.complaintAttachment ??
                                                    "",
                                            filename:
                                                complain.complaintAttachment ??
                                                    "",
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
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Title :",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: CU.blue,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  " ${complain.title.toString()}",
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
                                            complain.description ?? "",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.deepPurple,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    (complain.complaintSolution == "COMPLETED")
                                        ? Container(
                                            child: Image.asset(AppImage.approve,
                                                height: 30),
                                          )
                                        : Container(
                                            child: Image.asset(AppImage.reject,
                                                height: 30),
                                          ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          if (complain.complaintAttachment !=
                                              "")
                                            hSizeBox6,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Date : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: CU.secondaryColor,
                                                  fontSize: 9,
                                                ),
                                              ),
                                              Text(
                                                DateFormat("dd-MM-yyyy")
                                                    .format(complain.date!),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Status : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: CU.blue,
                                                  fontSize: 9,
                                                ),
                                              ),
                                              Text(
                                                complain.complaintSolution ??
                                                    "",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: (complain
                                                              .complaintSolution ==
                                                          "COMPLETED")
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          if (complain.complaintSolutionBy !=
                                              "")
                                            Row(
                                              children: [
                                                Text(
                                                  "Solution By : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: CU.blue,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                                Text(
                                                  "${complain.complaintSolutionBy}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.green,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (complain.complaintSolutionBy !=
                                              "")
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          if (complain.createdDate.toString() !=
                                              "")
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Solution On : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: CU.blue,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat("dd-MM-yyyy")
                                                      .format(complain
                                                          .createdDate!),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.deepPurple,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    )
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
}
