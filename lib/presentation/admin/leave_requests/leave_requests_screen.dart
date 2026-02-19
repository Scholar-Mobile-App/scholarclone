import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/admin/leave_requests/leave_requests_controller.dart';
import 'package:scholar_clone/model/admin/leave_authorisation_model.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class LeaveRequestsScreen extends StatelessWidget {
  LeaveRequestsScreen({super.key});
  final LeaveRequestsController _controller =
      Get.put(LeaveRequestsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Leave Requests"),
      body: Stack(
        children: [
          // Container(
          //   width: Get.width,
          //   height: 80,
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.elliptical(Get.width / 2, 30),
          //       bottomRight: Radius.elliptical(Get.width / 2, 30),
          //     ),
          //   ),
          // ),
          Column(
            children: [
              hSizeBox20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: dateTimeTextField(
                        title: "From Date",
                        date: _controller.fromDate.value,
                        onTap: (value) {
                          _controller.fromDate.value = value;
                          _controller.callServiceLeaveRequest();
                        },
                        context: context,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: dateTimeTextField(
                        title: "To Date",
                        date: _controller.toDate.value,
                        firstDate: _controller.fromDate.value,
                        onTap: (value) {
                          _controller.toDate.value = value;
                          _controller.callServiceLeaveRequest();
                        },
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
              hSizeBox10,
              Expanded(
                child: Obx(
                  () => _controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : _controller.leaveRequestList.isEmpty
                          ? Center(
                              child: Text(
                                "No Leave History Found",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              itemCount: _controller.leaveRequestList.length,
                              separatorBuilder: (context, index) => hSizeBox10,
                              itemBuilder: (context, index) {
                                final GetEmployeeLeaveList leaveRequest =
                                    _controller.leaveRequestList[index];

                                return Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Get.toNamed(
                                        AppRoutes.leaveRequestsDetails,
                                        arguments: [
                                          _controller.data,
                                          _controller.userInfo,
                                          leaveRequest
                                        ],
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(16)
                                            .copyWith(left: 40),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: .25),
                                              blurRadius: 2,
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    leaveRequest.employeeName ??
                                                        "",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Icon(Icons.open_in_new_rounded)
                                              ],
                                            ),
                                            hSizeBox4,
                                            Text(
                                              leaveRequest.comment ?? "",
                                              // "I am requesting leave from April 18th to April 22nd due to personal reasons.....",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff686868),
                                              ),
                                            ),
                                            hSizeBox4,
                                            Text(
                                              DateFormat("dd MMM yyyy").format(
                                                  leaveRequest.createdAt ??
                                                      DateTime.now()),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff393939),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(16)),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
