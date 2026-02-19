import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import '../../../core/utils/cu.dart';
import 'admin_student_profile_list_controller.dart';

class AdminStudentProfileListScreen extends StatelessWidget {
  AdminStudentProfileListScreen({super.key});
  final AdminStudentProfileListController _controller =
      Get.put(AdminStudentProfileListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Student Profile"),
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
                  section(),
                  hSizeBox20,
                  if (_controller.studentList.isNotEmpty)
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => attendanceTile(
                            _controller.studentList[index], index),
                        itemCount: _controller.studentList.length,
                      ),
                    ),
                  hSizeBox20,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget section() {
    return Container(
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
          dropDownTextField(
            title: "Select Section",
            list: _controller.sectionNameList,
            onChanged: (value) {
              _controller.section.value = value!;
              _controller.studentList.value = [];
              for (var i = 0; i < _controller.sectionList.length; i++) {
                if (_controller.sectionList[i].shortName == value) {
                  _controller.sectionID.value = _controller.sectionList[i].id!;
                  _controller.callServiceStandared(_controller.sectionID.value);
                }
              }
            },
          ),
          dropDownTextField(
            title: "Select Standard",
            list: _controller.stdName,
            onChanged: (value) {
              for (int i = 0; i < _controller.stdName.length; i++) {
                if (_controller.standardModel!.data![i].name == value) {
                  _controller.stdId.value =
                      _controller.standardModel!.data![i].id!;
                  _controller.divName.value = [];
                  _controller.callServiceDivision(_controller.stdId.value);
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
                if (_controller.divisionModel!.data![i].name == value) {
                  _controller.divId.value =
                      _controller.divisionModel!.data![i].id!;
                  break;
                }
              }
            },
          ),
          hSizeBox20,
          AppButton(
            text: "Search",
            onTap: _controller.sectionID.value == 0
                ? null
                : () {
                    _controller.studentList.value = [];
                    _controller.callServiceAllocate(_controller.stdDiv.value);
                  },
          ),
          hSizeBox20,
        ],
      ),
    );
  }

  attendanceTile(Student studentInfo, int index) => GestureDetector(
        onTap: () {
          Get.toNamed(
            AppRoutes.studentProfileListDetail,
            arguments: studentInfo,
          );

          // Get.to(() => StudentProfileScreen(userInfo: ,));
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => widget.isAttedanceScreen
          //         ? StudentAttendancePhotosScreen(
          //             studentModel: studentList[index],
          //             section: setction,
          //           )
          //         : TeacherStudentProfileScreen(
          //             student_list[index],
          //             standard,
          //             setction,
          //           ),
          //   ),
          // );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    height: Get.width * 0.15,
                    width: Get.width * 0.15,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(studentInfo.studentImage!),
                            fit: BoxFit.cover)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        studentInfo.studentName ?? "",
                        style: TextStyle(
                          color: CU.tprimaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Roll No. ${studentInfo.rollNo}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "GR No. ${studentInfo.enrollmentNo}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 1,
            ),
          ],
        ),
      );
}
