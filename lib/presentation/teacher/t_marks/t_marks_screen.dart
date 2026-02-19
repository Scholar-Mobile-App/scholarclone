import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/teacher/t_marks/t_marks_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class TeacherMarkScreen extends StatelessWidget {
  TeacherMarkScreen({super.key});
  final TeacherMarkController _controller = Get.put(TeacherMarkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Marks Entry"),
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
            ListView(
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
                  child: Obx(
                    () => Column(
                      children: [
                        dropDownTextField(
                          title: "Select Term",
                          list: _controller.termName,
                          onChanged: (value) {
                            _controller.sectionName.clear();
                            _controller.stdName.clear();

                            for (int i = 0;
                                i < _controller.userInfo["term_data"].length;
                                i++) {
                              if (_controller.userInfo["term_data"][i]
                                      ["title"] ==
                                  value) {
                                _controller.term.value = _controller
                                    .userInfo["term_data"][i]["title"];
                                _controller.termId.value = _controller
                                    .userInfo["term_data"][i]["term_id"];
                                _controller.callServiceStandard();

                                break;
                              }
                            }
                          },
                        ),
                        dropDownTextField(
                          title: "Select Standard",
                          list: _controller.stdName,
                          onChanged: (value) {
                            _controller.subjectName.clear();
                            for (int i = 0;
                                i < _controller.stdName.length;
                                i++) {
                              if (_controller.standardModel!.data![i].stdName ==
                                  value) {
                                _controller.stdId.value =
                                    _controller.standardModel!.data![i].stdId!;
                                _controller.gradeId.value = _controller
                                    .standardModel!.data![i].gradeId!;
                                _controller.selectStandard.value = _controller
                                    .standardModel!.data![i].stdName!;
                                _controller.divName.value = [];
                                _controller.callServiceDivision();
                                _controller.callServiceSubject(
                                    _controller.stdId.value);

                                break;
                              }
                            }
                          },
                        ),
                        dropDownTextField(
                          title: "Select Division",
                          list: _controller.divName,
                          onChanged: (value) {
                            for (int i = 0;
                                i < _controller.divisionModel!.data!.length;
                                i++) {
                              if (_controller.divisionModel!.data![i].divName ==
                                  value) {
                                _controller.divId.value =
                                    _controller.divisionModel!.data![i].divId!;
                                _controller.selectDivision.value = _controller
                                    .divisionModel!.data![i].divName!;
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
                              if (_controller.subjectList[i].subName == value) {
                                _controller.subjectId.value =
                                    _controller.subjectList[i].subId!;

                                _controller.selectSubject.value =
                                    _controller.subjectList[i].subName!;

                                _controller.callServiceExam();
                                break;
                              }
                            }
                          },
                        ),
                        dropDownTextField(
                          title: "Select Exam",
                          list: _controller.examName,
                          onChanged: (value) {
                            for (int i = 0;
                                i < _controller.examList.length;
                                i++) {
                              if (_controller.examList[i].title == value) {
                                _controller.selectExam.value =
                                    _controller.examList[i].title!;
                                _controller.examId.value =
                                    _controller.examList[i].id!;
                                break;
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                hSizeBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppButton(
                    text: "Search",
                    onTap: _controller.examId.value == 0
                        ? null
                        : () {
                            Get.toNamed(
                              AppRoutes.marksEntryResult,
                              arguments: [
                                _controller.data,
                                _controller.userInfo,
                                _controller.selectDivision.value,
                                _controller.selectExam.value,
                                _controller.selectStandard.value,
                                _controller.selectSubject.value,
                                _controller.divId.value,
                                _controller.stdId.value,
                                _controller.examId.value,
                                _controller.termId.value,
                              ],
                            );
                          },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
