import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/model/student/my_leave_history_model.dart';
import 'package:scholar_clone/model/teacher/leave_type_model.dart';
import 'package:scholar_clone/presentation/teacher/leave_history/leave_history_controller.dart';
import 'package:scholar_clone/presentation/teacher/my_leave/my_leave_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';

class LeaveHistoryScreen extends StatelessWidget {
  LeaveHistoryScreen({super.key});
  final LeaveHistoryController _controller = Get.put(LeaveHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Leave History"),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20).copyWith(bottom: 0),
            child: dropDownTextField(
              title: "Leave Type",
              list: Get.find<MyLeaveController>()
                  .typeOfLeaveList
                  .map((e) => e.leaveType ?? '')
                  .where((name) => name.isNotEmpty)
                  .toList(),
              onChanged: (value) {
                _controller.laveType.value = Get.find<MyLeaveController>()
                        .typeOfLeaveList
                        .firstWhereOrNull(
                            (element) => element.leaveType == value!) ??
                    LeaveTypeModel();

                _controller.callServiceMyLeaveHistory(
                    leaveTypeId: _controller.laveType.value.id);
              },
            ),
          ),
          Obx(
            () => _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : _controller.leaveHistoryList.isEmpty
                    ? Center(
                        child: Text(
                          "No Leave History Found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.all(20),
                          itemCount: _controller.leaveHistoryList.length,
                          separatorBuilder: (context, index) => hSizeBox10,
                          itemBuilder: (context, index) {
                            final MyLeaveHistoryModel leaveHistory =
                                _controller.leaveHistoryList[index];
                            return Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: AppColor.secondaryColor),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(Get.find<MyLeaveController>()
                                                .typeOfLeaveList
                                                .firstWhereOrNull((element) =>
                                                    element.id ==
                                                    leaveHistory.leaveTypeId)
                                                ?.leaveType ??
                                            ""),
                                        Text(
                                          "${DateFormat("dd MMM yyyy").format(leaveHistory.fromDate ?? DateTime.now())} - ${DateFormat("dd MMM yyyy").format(leaveHistory.toDate ?? DateTime.now())} (${leaveHistory.dayType == "0.5" ? (leaveHistory.slot ?? "").isEmpty ? "Half Day" : leaveHistory.slot == "first_half" ? "First Half" : "Second Half" : "Full Day"})",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xff686868),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: leaveHistory.status == "approved"
                                          ? Color(0xff479F76)
                                          : leaveHistory.status == "rejected"
                                              ? Colors.redAccent
                                              : Color(0xffFD9843),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      leaveHistory.status == "approved"
                                          ? "Approved"
                                          : leaveHistory.status == "rejected"
                                              ? "Rejected"
                                              : "Pending",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
