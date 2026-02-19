import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import 'admin_student_disclipline_controller.dart';

class AdminStudentDiscliplineScreen extends StatelessWidget {
  AdminStudentDiscliplineScreen({super.key});

  final AdminStudentDiscliplineController _controller =
      Get.put(AdminStudentDiscliplineController());

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
                        dropDownTextField(
                          key: _controller.sectionKey,
                          title: "Select Section",
                          list: _controller.sectionName,
                          onChanged: (value) async {
                            _controller.stdName.clear();
                            for (var i = 0;
                                i < _controller.sectionModel!.data!.length;
                                i++) {
                              if (_controller
                                      .sectionModel!.data![i].shortName ==
                                  value) {
                                _controller.sectionID.value =
                                    _controller.sectionModel!.data![i].id!;
                                _controller.stdName.value = [];

                                await _controller.callServiceStandared(
                                    _controller.sectionID.value);
                              }
                            }
                          },
                        ),
                        dropDownTextField(
                          key: _controller.standardKey,
                          title: "Standard",
                          list: _controller.stdName,
                          onChanged: (value) {
                            for (int i = 0;
                                i < _controller.stdName.length;
                                i++) {
                              if (_controller.standardModel!.data![i].name ==
                                  value) {
                                _controller.stdId.value =
                                    _controller.standardModel!.data![i].id!;
                                _controller.divName.value = [];
                                _controller.callServiceDivision(
                                    _controller.stdId.value);
                                break;
                              }
                            }
                          },
                        ),
                        dropDownTextField(
                          key: _controller.divKey,
                          title: "Division",
                          list: _controller.divName,
                          onChanged: (value) {
                            for (int i = 0;
                                i < _controller.divisionModel!.data!.length;
                                i++) {
                              if (_controller.divisionModel!.data![i].name ==
                                  value) {
                                _controller.divId.value =
                                    _controller.divisionModel!.data![i].id!;
                                _controller.divName.value = [];
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
                        textField(
                          title: "Mobile No.",
                          hintText: "Type Here",
                          onChanged: (value) {
                            _controller.mobile.value = value;
                          },
                        ),
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
