import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/teacher/my_leave/my_leave_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class MyLeaveScreen extends StatelessWidget {
  MyLeaveScreen({super.key});
  final MyLeaveController _controller = Get.put(MyLeaveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "My Leaves"),
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
            _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: .25),
                                blurRadius: 8,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "My Leaves",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff393939),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Get.toNamed(
                                      AppRoutes.applyLeave,
                                      arguments: [
                                        _controller.data,
                                        _controller.userInfo
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 5,
                                      backgroundColor: AppColor.greenColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Text(
                                      "Apply Leave",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              hSizeBox20,
                              CircularPercentIndicator(
                                radius: 70.0,
                                lineWidth: 15.0,
                                percent: .25,
                                center: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _controller.leaveSummary.value
                                              .remainingLeaves ??
                                          "",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "Leaves\nRemain",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                                progressColor: Color(0xffFFBEB2),
                                backgroundColor: AppColor.greenColor,
                              ),
                              hSizeBox20,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              color: Color(0xffFFBEB2),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          wSizeBox10,
                                          Text(
                                            _controller.leaveSummary.value
                                                    .usedLeaves ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Used Leaves",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.textColor,
                                        ),
                                      ).paddingOnly(left: 30),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              color: AppColor.greenColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          wSizeBox10,
                                          Text(
                                            _controller.leaveSummary.value
                                                    .totalLeaves ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Total Leaves",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.textColor,
                                        ),
                                      ).paddingOnly(left: 30),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        hSizeBox20,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Leave Type",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff393939),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => Get.toNamed(
                                AppRoutes.leaveHistory,
                                arguments: [
                                  _controller.data,
                                  _controller.userInfo
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                backgroundColor: AppColor.greenColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text(
                                "Leave History",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        hSizeBox20,
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: List.generate(
                            _controller.leaveTypeList.length,
                            (index) {
                              return leaveType(
                                icon: leaveTypeIcon(_controller
                                        .leaveTypeList[index].leaveType ??
                                    ""),
                                totalLeaves:
                                    _controller.leaveTypeList[index].total ??
                                        "",
                                type: _controller
                                        .leaveTypeList[index].leaveType ??
                                    "",
                                usedLeaves:
                                    _controller.leaveTypeList[index].used ?? "",
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget leaveType({
    required String icon,
    required String type,
    required String usedLeaves,
    required String totalLeaves,
  }) {
    return Container(
      width: ((Get.width - 40 - 32) / 3),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .25),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                usedLeaves,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: .8,
                ),
              ),
              Text(
                "/$totalLeaves",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withValues(alpha: .6),
                  height: 0,
                ),
              ),
            ],
          ),
          hSizeBox4,
          Text(
            type,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black.withValues(alpha: .6),
            ),
          ),
        ],
      ),
    );
  }

  String leaveTypeIcon(String type) {
    switch (type) {
      case 'Medical Leave':
        return AppImage.medical;
      case 'Compassionate':
        return AppImage.compassionate;
      case 'Maternity':
        return AppImage.maternity;
      case 'Replacement':
        return AppImage.replacement;
      case 'Hospitalization':
        return AppImage.hospital;
      case 'Marriage':
        return AppImage.marriage;
      default:
        return AppImage.annual;
    }
  }
}
