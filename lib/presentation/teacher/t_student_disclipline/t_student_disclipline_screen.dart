import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/teacher/t_student_disclipline/t_student_disclipline_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class TStudentDiscliplineScreen extends StatelessWidget {
  TStudentDiscliplineScreen({super.key});

  final TStudentDiscliplineController _controller =
      Get.put(TStudentDiscliplineController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Student Discipline"),
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
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
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
                      children: [
                        hSizeBox10,
                        // textField(
                        //   title: "Sr No.",
                        //   hintText: "Type Here",
                        //   onChanged: (value) {
                        //     _controller.srNo.value = value;
                        //   },
                        // ),
                        dropDownTextField(
                          title: "Standard",
                          list: _controller.stdName,
                          onChanged: (value) {
                            for (int i = 0;
                                i < _controller.stdName.length;
                                i++) {
                              if (_controller.standardModel!.data![i].stdName ==
                                  value) {
                                _controller.stdId.value =
                                    _controller.standardModel!.data![i].stdId!;
                                _controller.divName.value = [];
                                _controller.callServiceDivision();
                                break;
                              }
                            }
                          },
                        ),
                        dropDownTextField(
                          title: "Division",
                          list: _controller.divName,
                          onChanged: (value) {
                            for (int i = 0;
                                i < _controller.divisionModel!.data!.length;
                                i++) {
                              if (_controller.divisionModel!.data![i].divName ==
                                  value) {
                                _controller.divId.value =
                                    _controller.divisionModel!.data![i].divId!;
                                _controller.studentName.value = [];
                                _controller.callServiceSearch();
                                break;
                              }
                            }
                          },
                        ),
                        dropDownTextField(
                          title: "Student Name",
                          list: _controller.studentName,
                          onChanged: (value) {
                            for (int i = 0;
                                i < _controller.studentList.length;
                                i++) {
                              if (_controller.studentList[i]["student_name"] ==
                                  value) {
                                _controller.studentsId.value =
                                    _controller.studentList[i]["id"];
                                break;
                              }
                            }
                          },
                        ),
                        // textField(
                        //   title: "Mobile No.",
                        //   hintText: "Type Here",
                        //   onChanged: (value) {
                        //     _controller.mobile.value = value;
                        //   },
                        // ),
                        dropDownTextField(
                          title: "Student Performance",
                          list: ["Excellent", "Very Good", "Good", "Poor"],
                          onChanged: (value) {
                            _controller.performance.value = value!;
                          },
                        ),
                        textField(
                          title: "Enter Message",
                          hintText: "Type Here",
                          maxLine: 3,
                          onChanged: (value) {
                            _controller.message.value = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  hSizeBox20,
                  AppButton(
                    text: "Save",
                    loader: _controller.isLoading.value,
                    onTap: _controller.isLoading.value
                        ? null
                        : () {
                            _controller.callServiceSubmit();
                          },
                  ),
                  hSizeBox30,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
