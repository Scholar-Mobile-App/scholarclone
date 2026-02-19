import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/model/teacher/leave_type_model.dart';
import 'package:scholar_clone/presentation/teacher/apply_leave/apply_leave_controller.dart';
import 'package:scholar_clone/presentation/teacher/my_leave/my_leave_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

class ApplyLeaveScreen extends StatelessWidget {
  ApplyLeaveScreen({super.key});
  final ApplyLeaveController _con = Get.put(ApplyLeaveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Apply Leave"),
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
            () => Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  dropDownTextField(
                    title: "Leave Type",
                    list: Get.find<MyLeaveController>()
                        .typeOfLeaveList
                        .map((e) => e.leaveType ?? '')
                        .where((name) => name.isNotEmpty)
                        .toList(),
                    onChanged: (value) {
                      _con.laveType.value = Get.find<MyLeaveController>()
                              .typeOfLeaveList
                              .firstWhereOrNull(
                                  (element) => element.leaveType == value!) ??
                          LeaveTypeModel();

                      log(_con.laveType.value.leaveType ?? "");
                    },
                  ),
                  dropDownTextField(
                    title: "Day Type",
                    list: ["Full", "Half"],
                    onChanged: (value) {
                      _con.selectDayType.value = value ?? "";
                    },
                  ),
                  dateTimeTextField(
                    title: "From Date",
                    date: _con.fromDate.value,
                    onTap: (value) {
                      _con.fromDate.value = value;
                    },
                    context: context,
                    firstDate: DateTime.now(),
                  ),
                  if (_con.selectDayType.value == "Full")
                    dateTimeTextField(
                      title: "To Date",
                      initialDate: _con.fromDate.value,
                      date: _con.toDate.value,
                      onTap: (value) {
                        _con.toDate.value = value;
                      },
                      context: context,
                      firstDate: _con.fromDate.value,
                    ),
                  if (_con.selectDayType.value == "Half")
                    dropDownTextField(
                      title: "Slot",
                      list: ["First Half", "Second Half"],
                      onChanged: (value) {
                        _con.selectSlot.value = value ?? "";
                      },
                    ),
                  textFieldController(
                    _con.comment,
                    title: "Comment",
                    hintText: "Write comment...",
                    maxLine: 4,
                  ),
                  AppButton(
                    text: "Apply Leave",
                    onTap: () {
                      _con.callServiceApplyLeave();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
