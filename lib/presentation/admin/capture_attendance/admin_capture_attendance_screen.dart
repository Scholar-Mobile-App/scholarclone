import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/utility.dart';
import 'package:scholar_clone/presentation/admin/capture_attendance/admin_capture_attendance_controller.dart';
import 'package:scholar_clone/presentation/teacher/take_attendance/take_attendance_screen.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';

class AdminCaptureAttendanceScreen extends StatelessWidget {
  AdminCaptureAttendanceScreen({super.key});
  final AdminCaptureAttendanceController _controller =
      Get.put(AdminCaptureAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Capture Attendance"),
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
                      if (_controller.isAdmin)
                        dropDownTextField(
                          title: "Select Section",
                          list: _controller.sectionName,
                          onChanged: (value) async {
                            for (var i = 0;
                                i < _controller.sectionModel!.data!.length;
                                i++) {
                              if (_controller
                                      .sectionModel!.data![i].shortName ==
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
                      if (_controller.isAdmin)
                        dropDownTextField(
                          title: "Select Standard",
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

                                _controller.selectStandard.value =
                                    _controller.standardModel!.data![i].name!;
                                _controller.callServiceDivision(
                                    _controller.stdId.value);

                                break;
                              }
                            }
                          },
                        ),
                      if (_controller.isAdmin)
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
                      if (!_controller.isAdmin)
                        dropDownTextField(
                          title: "Select Standard Division",
                          list: _controller.stdDivName,
                          onChanged: (value) {
                            _controller.selectStandard.value = value!;
                            var list = _controller.userInfo["standard_division"]
                                .split(",");
                            var div = _controller
                                .userInfo["standard_division_title"]
                                .split(",");

                            for (int i = 0; i < list.length; i++) {
                              if (value == div[i].replaceAll("||", "-")) {
                                _controller.selectStdDiv.value = list[i];
                              }
                            }
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
                      imageGrid(),
                      AppButton(
                        text: "Submit",
                        onTap: (_controller.selectStdDiv.value.isEmpty &&
                                _controller.divId.value == 0)
                            ? null
                            : () {
                                _controller.studentList.clear();

                                if (_controller.images.isEmpty) {
                                  showToast(
                                    context: context,
                                    message: "Please capture atleast one image",
                                    color: Colors.red,
                                    icons: Icons.error,
                                  );
                                } else {
                                  _controller.callServiceImageVideoSubmit();
                                }
                              },
                      ),
                    ],
                  ),
                ),
                hSizeBox20,
                if (_controller.studentList.isNotEmpty)
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
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
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Student\nDetails",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                radioBotton(
                                  index: 1,
                                  onChanged: (value) {
                                    for (var element
                                        in _controller.studentList) {
                                      element.attendance = "P";
                                      _controller.val.value = value!;
                                    }
                                    _controller.attendanceStutas.value = "P";
                                  },
                                  value: _controller.val.value,
                                  title: "Present",
                                  isText: true,
                                  color: Colors.green,
                                ),
                                wSizeBox20,
                                radioBotton(
                                  index: 2,
                                  onChanged: (value) {
                                    for (var element
                                        in _controller.studentList) {
                                      element.attendance = "A";
                                      _controller.val.value = value!;
                                    }
                                    _controller.attendanceStutas.value = "A";
                                  },
                                  value: _controller.val.value,
                                  title: "Absent",
                                  isText: true,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 1,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _controller.studentList.length,
                                itemBuilder: (context, index) {
                                  log(_controller.studentList.length
                                      .toString());

                                  return attendanceTile(
                                      _controller.studentList[index], index);
                                }),
                          ],
                        ),
                      ),
                      hSizeBox20,
                      AppButton(
                        text: "Submit",
                        onTap: _controller.attendanceStutas.value.isEmpty
                            ? null
                            : () {
                                _controller.callServiceSubmit();
                              },
                      ),
                      hSizeBox20,
                    ],
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  GridView imageGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemCount: _controller.images.length + 1,
      itemBuilder: (ctx, i) {
        return Obx(
          () => GestureDetector(
            onTap: _controller.images.length != i
                ? null
                : () async {
                    if (await checkPermission(Permission.camera)) {
                      XFile? picture = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        imageQuality: 80,
                        maxHeight: 500,
                        maxWidth: 500,
                      );

                      _controller.images.add(picture!.path);
                    }
                  },
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: Colors.green),
                  ),
                  clipBehavior: Clip.antiAlias,
                  height: 150,
                  child: _controller.images.length == i
                      ? const Icon(Icons.photo_camera)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(_controller.images[i]),
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    _controller.images.length == i ? Icons.close : Icons.check,
                    color: _controller.images.length == i
                        ? Colors.transparent
                        : Colors.green,
                    size: 28,
                  ),
                ),
                Positioned(
                  top: -7,
                  right: -7,
                  child: GestureDetector(
                    onTap: _controller.images.length == i
                        ? null
                        : () {
                            _controller.images.removeAt(i);
                          },
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: _controller.images.length == i
                          ? Colors.transparent
                          : Colors.red,
                      child: Icon(
                        _controller.images.length == i
                            ? Icons.close
                            : Icons.close,
                        color: _controller.images.length == i
                            ? Colors.transparent
                            : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  attendanceTile(StudentModel studentInfo, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${studentInfo.studentName}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Roll No : ${studentInfo.rollNo}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Enrollment No : ${studentInfo.enrollmentNo}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ],
              ),
            ),
            Obx(
              () => radioBotton(
                index: int.parse(studentInfo.enrollmentNo!),
                onChanged: (value) {
                  studentInfo.attendance = "P";
                  _controller.attendanceStutas.value = "P";
                  _controller.val.value = -1;
                  _controller.isUpdate.value != _controller.isUpdate.value;
                  _controller.isUpdate.value = !_controller.isUpdate.value;
                },
                value: studentInfo.attendance == "P"
                    ? int.parse(studentInfo.enrollmentNo!)
                    : 1,
                title: "Present",
                isText: false,
                color: _controller.isUpdate.value ? Colors.green : Colors.green,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Obx(() => radioBotton(
                  index: int.parse(studentInfo.enrollmentNo!) + 1,
                  onChanged: (value) {
                    _controller.attendanceStutas.value = "A";
                    studentInfo.attendance = "A";
                    _controller.val.value = -1;
                    _controller.isUpdate.value = !_controller.isUpdate.value;
                  },
                  title: "Absent",
                  isText: false,
                  value: studentInfo.attendance == "A"
                      ? int.parse(studentInfo.enrollmentNo!) + 1
                      : 1,
                  color: _controller.isUpdate.value ? Colors.red : Colors.red,
                ))
          ],
        ),
        Container(
          color: Colors.black,
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 1,
        ),
      ],
    );
  }
}
