import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/teacher/lesson_planning/lesson_planning_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

class LessonPlanningScreen extends StatelessWidget {
  LessonPlanningScreen({super.key});
  final LessonPlanningController _controller =
      Get.put(LessonPlanningController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Teacher Dairy"),
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
          Obx(
            () => _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
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
                            dropDownTextField(
                              title: "Select Standard",
                              key: _controller.standardKey,
                              list: _controller.stdName,
                              onChanged: (value) {
                                _controller.standard.value = value!;
                                for (int i = 0;
                                    i < _controller.stdList.length;
                                    i++) {
                                  if (_controller.stdList[i].stdName == value) {
                                    _controller.stdID.value =
                                        _controller.stdList[i].stdId!;
                                    _controller.divName.value = [];
                                    _controller.callServiceDivision();
                                    _controller.callServiceSubject(
                                        _controller.stdID.value);
                                    break;
                                  }
                                }
                              },
                            ),
                            dropDownTextField(
                              title: "Select Division",
                              key: _controller.divisionKey,
                              list: _controller.divName,
                              onChanged: (value) {
                                for (int i = 0;
                                    i < _controller.divList.length;
                                    i++) {
                                  if (_controller.divList[i].divName == value) {
                                    _controller.divID.value =
                                        _controller.divList[i].divId!;
                                    break;
                                  }
                                }
                              },
                            ),
                            dropDownTextField(
                              title: "Select Subject",
                              list: _controller.subjectName,
                              onChanged: (value) {
                                for (int i = 0;
                                    i < _controller.subjectList.length;
                                    i++) {
                                  if (_controller.subjectList[i].subName ==
                                      value) {
                                    _controller.subjectId.value =
                                        _controller.subjectList[i].subId!;

                                    _controller.selectSubject.value =
                                        _controller.subjectList[i].subName!;
                                    break;
                                  }
                                }
                              },
                            ),
                            textField(
                              title: "Enter Title",
                              hintText: "Type Here",
                              onChanged: (value) {
                                _controller.title.value = value;
                              },
                            ),
                            dateTimeTextField(
                              title: "Date",
                              date: _controller.selectedDate.value,
                              onTap: (value) {
                                _controller.selectedDate.value = value;
                              },
                              context: Get.context!,
                            ),
                          ],
                        ),
                      ),
                      hSizeBox20,
                      Center(
                        child: AppButton(
                          text: "Submit",
                          onTap: _controller.title.isEmpty
                              ? null
                              : () {
                                  _controller.callServiceSubmit(context);
                                },
                        ),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
