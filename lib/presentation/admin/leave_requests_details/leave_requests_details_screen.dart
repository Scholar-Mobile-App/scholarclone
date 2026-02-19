import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/admin/leave_requests_details/leave_requests_details_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

class LeaveRequestsDetailsScreen extends StatelessWidget {
  LeaveRequestsDetailsScreen({super.key});
  final LeaveRequestsDetailsController _controller =
      Get.put(LeaveRequestsDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Leave Requests"),
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
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .25),
                  blurRadius: 2,
                )
              ],
            ),
            child: ListView(
              children: [
                Text(
                  _controller.leaveRequest.employeeName ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                hSizeBox10,
                textFieldController(
                  _controller.leaveType,
                  title: "Leave Type",
                  isOnlyRead: true,
                ),
                textFieldController(
                  _controller.dayType,
                  title: "Day Type",
                  isOnlyRead: true,
                ),
                textFieldController(
                  _controller.fromDate,
                  title: "From Date",
                  isOnlyRead: true,
                ),
                if (_controller.leaveRequest.toDate != null)
                  textFieldController(
                    _controller.toDate,
                    title: "To Date",
                    isOnlyRead: true,
                  ),
                if (_controller.leaveRequest.slot != null &&
                    _controller.dayType.text == "0.5")
                  textFieldController(
                    _controller.slot,
                    title: "Slot",
                    isOnlyRead: true,
                  ),
                textFieldController(
                  _controller.hrRemark,
                  title: "HR Remark",
                  hintText: "Enter HR Remark",
                  maxLine: 3,
                ),
                textFieldController(
                  _controller.hodRemark,
                  title: "HOD Remark",
                  hintText: "Enter HOD Remark",
                  maxLine: 3,
                ),
                dropDownTextField(
                  title: "Take Action",
                  list: [
                    "Approved_lwp",
                    "Cancelled",
                    "Rejected",
                    "Pending",
                    "Approved"
                  ],
                  onChanged: (value) {
                    _controller.selectStatus.value = value ?? "";
                  },
                ),
                Obx(
                  () => AppButton(
                    text: "Apply",
                    loader: _controller.isLoading.value,
                    onTap: _controller.selectStatus.value.isEmpty
                        ? null
                        : () => _controller.callServiceACtionLeave(),
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
