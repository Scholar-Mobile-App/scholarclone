import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';

import 'take_attendance_controller.dart';

class TakeAttendanceScreen extends StatelessWidget {
  TakeAttendanceScreen({super.key});
  final TakeAttendanceController _controller =
      Get.put(TakeAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          elevation: 0,
          backgroundColor: CU.tprimaryColor,
          title: const Text(
            "Take Attendance",
            style: TextStyle(color: Colors.white),
          ),
          // systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
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
                  standardDivion(context),
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
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
              ),
            )
          ],
        ),
      ),
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
                index: studentInfo.studentId,
                onChanged: (value) {
                  studentInfo.attendance = "P";
                  _controller.attendanceStutas.value = "P";
                  _controller.val.value = -1;
                  _controller.isUpdate.value != _controller.isUpdate.value;
                  _controller.isUpdate.value = !_controller.isUpdate.value;
                },
                value:
                    studentInfo.attendance == "P" ? studentInfo.studentId : 1,
                title: "Present",
                isText: false,
                color: _controller.isUpdate.value ? Colors.green : Colors.green,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Obx(
              () => radioBotton(
                index: studentInfo.studentId! + 1,
                onChanged: (value) {
                  _controller.attendanceStutas.value = "A";
                  studentInfo.attendance = "A";
                  _controller.val.value = -1;
                  _controller.isUpdate.value = !_controller.isUpdate.value;
                },
                title: "Absent",
                isText: false,
                value: studentInfo.attendance == "A"
                    ? studentInfo.studentId! + 1
                    : 1,
                color: _controller.isUpdate.value ? Colors.red : Colors.red,
              ),
            )
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

  standardDivion(BuildContext context) {
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
            title: "Select Standard Division",
            list: _controller.divName,
            onChanged: (value) {
              var list = _controller.userInfo["standard_division"].split(",");
              var div =
                  _controller.userInfo["standard_division_title"].split(",");
              for (int i = 0; i < list.length; i++) {
                if (value == div[i].replaceAll("||", "-")) {
                  _controller.stdDiv.value = list[i];
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
            context: context,
          ),
          hSizeBox20,
          AppButton(
            text: "Search",
            onTap: _controller.stdDiv.value.isEmpty
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
}

radioBotton({
  Function(int?)? onChanged,
  int? index,
  int? value,
  String? title,
  bool isText = false,
  Color? color,
}) =>
    Column(
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: color),
          child: Radio(
            value: index!,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            groupValue: value,
            onChanged: onChanged,
            activeColor: color,
          ),
        ),
        if (isText)
          Text(
            title!,
            style: TextStyle(
              color: color,
            ),
          ),
      ],
    );
