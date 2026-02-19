import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';
import 'package:scholar_clone/presentation/admin/capture_photos/admin_capture_photos_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class AdminCapturePhotoScreen extends StatelessWidget {
  AdminCapturePhotoScreen({super.key});
  final AdminCapturePhotoController _controller =
      Get.put(AdminCapturePhotoController());

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
                  child: Column(
                    children: [
                      dropDownTextField(
                        title: "Select Section",
                        list: _controller.sectionName,
                        onChanged: (value) async {
                          for (var i = 0;
                              i < _controller.sectionModel!.data!.length;
                              i++) {
                            if (_controller.sectionModel!.data![i].shortName ==
                                value) {
                              _controller.selectSection.value =
                                  _controller.sectionModel!.data![i].title!;
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
                        title: "Select Standard",
                        list: _controller.stdName,
                        onChanged: (value) {
                          for (int i = 0; i < _controller.stdName.length; i++) {
                            if (_controller.standardModel!.data![i].name ==
                                value) {
                              _controller.stdId.value =
                                  _controller.standardModel!.data![i].id!;
                              _controller.divName.value = [];

                              _controller.selectStandard.value =
                                  _controller.standardModel!.data![i].name!;
                              _controller
                                  .callServiceDivision(_controller.stdId.value);

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
                            if (_controller.divisionModel!.data![i].name ==
                                value) {
                              _controller.divId.value =
                                  _controller.divisionModel!.data![i].id!;
                              _controller.selectDivision.value =
                                  _controller.divisionModel!.data![i].name!;
                              break;
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: AppButton(
                    text: "Search",
                    onTap: _controller.divId.value != 0
                        ? () {
                            _controller.studentList.clear();
                            _controller.callServiceSearch();
                          }
                        : null,
                  ),
                ),
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
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _controller.studentList.length,
                      separatorBuilder: (context, index) => Container(
                        color: Colors.black,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 1,
                      ),
                      itemBuilder: (context, index) => attendanceTile(
                        _controller.studentList[index],
                        index,
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  attendanceTile(Student studentInfo, int index) {
    return GestureDetector(
      onTap: () {
        _controller.isAttedance
            ? Get.toNamed(
                AppRoutes.studentAttendancePhoto,
                arguments: [
                  _controller.data,
                  _controller.userInfo,
                  studentInfo,
                  _controller.selectSection.value
                ],
              )
            : null;
      },
      child: Container(
        child: Row(
          children: [
            Container(
              height: Get.width * 0.15,
              width: Get.width * 0.15,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: (studentInfo.studentImage != "" &&
                          studentInfo.studentImage != null)
                      ? NetworkImage(studentInfo.studentImage!)
                      : const ExactAssetImage('assets/images/profile.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
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
                hSizeBox10,
                Row(
                  children: [
                    Text(
                      "Roll No. ${studentInfo.rollNo}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    wSizeBox20,
                    Text(
                      "GR No. ${studentInfo.enrollmentNo}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
