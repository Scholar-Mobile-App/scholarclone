import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/model/teacher/attendances_model.dart';
import 'package:scholar_clone/presentation/teacher/my_attendance/my_attendance_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';

class MyAttendanceScreen extends StatelessWidget {
  MyAttendanceScreen({super.key});
  final MyAttendanceController _controller = Get.put(MyAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: teacherAppBar(text: "My Attendance"),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: monthTextField(
                title: "Select Month",
                date: _controller.fromDate.value,
                onTap: (value) {
                  _controller.fromDate.value = value;
                  _controller.callServiceMyAttendance();
                },
                context: context,
              ),
            ),
            Expanded(
              child: Obx(
                () => _controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : _controller.attendancesList.isEmpty
                        ? Center(
                            child: Text(
                              "No Attendances History Found",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.all(20),
                            itemCount: _controller.attendancesList.length,
                            separatorBuilder: (context, index) => hSizeBox10,
                            itemBuilder: (context, index) {
                              final AttendancesModel attendances =
                                  _controller.attendancesList[index];
                              return Stack(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.all(16).copyWith(left: 40),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
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
                                        Text(
                                          DateFormat("dd MMM yyyy").format(
                                              attendances.day ??
                                                  DateTime.now()),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        hSizeBox10,
                                        Row(
                                          children: [
                                            SvgPicture.asset(AppImage.punchIn),
                                            wSizeBox10,
                                            Text(
                                              attendances.punchinTime == null
                                                  ? "-"
                                                  : DateFormat("hh:mm aa")
                                                      .format(attendances
                                                          .punchinTime!),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff686868),
                                              ),
                                            ),
                                            wSizeBox20,
                                            SvgPicture.asset(AppImage.punchOut),
                                            wSizeBox10,
                                            Text(
                                              attendances.punchoutTime == null
                                                  ? "-"
                                                  : DateFormat("hh:mm aa")
                                                      .format(attendances
                                                              .punchoutTime ??
                                                          DateTime.now()),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff686868),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
        ));
  }
}
