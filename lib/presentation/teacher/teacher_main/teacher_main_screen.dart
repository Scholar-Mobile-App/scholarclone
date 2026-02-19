import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/presentation/teacher/t_drawer/teacher_drawer_screen.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import '../../../core/utils/cs.dart';
import 'teacher_main_controller.dart';

class TeacherMainScreen extends StatelessWidget {
  TeacherMainScreen({super.key});
  final TeacherMainController _controller = Get.put(TeacherMainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TeacherDrawer(),
      key: _controller.scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 8.0,
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Image.asset(
                  AppImage.menu,
                  height: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  _controller.scaffoldKey.currentState!.openDrawer();
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 52,
                child: _controller.userInfo![CS.school_logo] == null
                    ? Image.asset(AppImage.logo)
                    : Image.network(
                        _controller.userInfo![CS.school_logo],
                      ),
                // height: 60,
                // child: CU.loadImage(
                //   url: _controller.userInfo![CS.school_logo]!,
                //   height: 60.0,
                //   errorIcon: AppImage.profile,
                // ),
              ),
            ),
            notification(),
          ],
        ),
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
          Obx(
            () => _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    physics: const ClampingScrollPhysics(),
                    itemCount: _controller.homeData!.data!.length,
                    separatorBuilder: (context, index) => hSizeBox20,
                    itemBuilder: (context, index) {
                      var data = _controller.homeData!.data![index];
                      // double screenRatio = (Get.width / Get.height) - 0.50;

                      return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(20)),
                                        image: DecorationImage(
                                          image: !CU.isEmptyOrNull(data
                                                  .mainTitleBackgroundImage!)
                                              ? NetworkImage(data
                                                  .mainTitleBackgroundImage!)
                                              : const ExactAssetImage(
                                                      'assets/images/profile.png')
                                                  as ImageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 20,
                                  bottom: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.mainTitle!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: HexColor(data.mainItleColor!),
                                      ),
                                    ),
                                    hSizeBox20,
                                    GridView.count(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      crossAxisCount: 4,
                                      childAspectRatio: 0.8,
                                      children: List.generate(
                                          data.contents!.length, (i) {
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _controller.typeIndex.value =
                                                    index;
                                                _controller.screenIndex.value =
                                                    i;

                                                log(data
                                                    .contents![i].screenName!);

                                                onScreenNavigation(
                                                    screen: data.contents![i]
                                                        .screenName!,
                                                    data: data.contents![i]);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          (Radius.circular(
                                                              45))),
                                                  child: CU.loadImage(
                                                    url: data.contents![i]
                                                        .subTitleIcon,
                                                    height: 50.0,
                                                    width: 50.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                data.contents![i].subTitle!,
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: CU.textColorDark,
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                          // Stack(
                          //   children: [

                          //   ],
                          // ),

                          );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget notification() {
    return const Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.transparent,
            size: 32,
          ),
          onPressed: null,
        ),
        // Positioned(
        //   right: 0,
        //   child: Container(
        //     padding: const EdgeInsets.all(1),
        //     decoration: BoxDecoration(
        //       color: Colors.red,
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     constraints: const BoxConstraints(
        //       minWidth: 14,
        //       minHeight: 14,
        //     ),
        //     child: Text(
        //       0.toString(),
        //       style: const TextStyle(
        //         color: Colors.white,
        //         fontSize: 13,
        //       ),
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        // )
      ],
    );
  }

  onScreenNavigation({
    required String screen,
    Content? data,
  }) {
    switch (screen.toString()) {
      //User
      case "t_own_profile":
        Get.toNamed(
          AppRoutes.ownProfile,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_proxy":
        Get.toNamed(
          AppRoutes.tProxy,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_message":
        Get.toNamed(
          AppRoutes.tMessage,
          arguments: [data, _controller.userInfo],
        );
        break;

      //LMS

      case "t_teach":
        Get.toNamed(
          AppRoutes.teach,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_virtual_classroom":
        Get.toNamed(
          AppRoutes.tVirtualClassroom,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_teacher_resource":
        Get.toNamed(
          AppRoutes.teacherResource,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_teacher_dairy":
        Get.toNamed(
          AppRoutes.lessonPlanning,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_social_collobrative":
        Get.toNamed(
          AppRoutes.tsocialCollobrative,
          arguments: [data, _controller.userInfo],
        );
        break;

      //Student
      case "t_student_profile":
        Get.toNamed(
          AppRoutes.studentProfileList,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_take_attendance":
        Get.toNamed(
          AppRoutes.takeAttendance,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_homework":
        Get.toNamed(
          AppRoutes.assignHomeWorkList,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_circular":
        Get.toNamed(
          AppRoutes.circularList,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_parent_comm":
        Get.toNamed(
          AppRoutes.replyParentCommunication,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_approve_leave":
        Get.toNamed(
          AppRoutes.approveStudentLeave,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_disclipline":
        Get.toNamed(
          AppRoutes.tStudentDisclipline,
          arguments: [data, _controller.userInfo],
        );
        break;
      case "t_marks":
        Get.toNamed(
          AppRoutes.tmarks,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_sms_parent":
        Get.toNamed(
          AppRoutes.sendSMS,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_notification_parent":
        Get.toNamed(
          AppRoutes.sendNotification,
          arguments: [data, _controller.userInfo],
        );
        break;
      case "t_email_parent":
        Get.toNamed(
          AppRoutes.sendEmail,
          arguments: [data, _controller.userInfo],
        );
        break;

      //Utility

      case "t_calander":
        Get.toNamed(
          AppRoutes.tCalander,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_timetable":
        Get.toNamed(
          AppRoutes.teacherTimetable,
          arguments: [data, _controller.userInfo],
        );
        break;

      case CS.t_video_gallary:
      case "t_photo_gallary":
        Get.toNamed(
          AppRoutes.gallary,
          arguments: [
            data,
            _controller.userInfo,
            false,
          ],
        );
        break;

      case "t_wrt_progress":
        Get.toNamed(
          AppRoutes.tWRTProgress,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_notification_report":
        Get.toNamed(
          AppRoutes.teacherNotificationReport,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_exam_schedule":
        Get.toNamed(
          AppRoutes.tExamSchedule,
          arguments: [data, _controller.userInfo],
        );
        break;

      //miscellaneous
      case "t_requisition":
        Get.toNamed(
          AppRoutes.tRequisition,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_task":
        Get.toNamed(
          AppRoutes.task,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_complain":
        Get.toNamed(
          AppRoutes.tComplain,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_visitor":
        Get.toNamed(
          AppRoutes.teacherVisitor,
          arguments: [data, _controller.userInfo],
        );
        break;

      // HRMS
      case "t_punch_inout":
        Get.toNamed(
          AppRoutes.punchInOut,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_my_attendance":
        Get.toNamed(
          AppRoutes.myAttendance,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_my_leave":
        Get.toNamed(
          AppRoutes.myLeave,
          arguments: [data, _controller.userInfo],
        );
        break;

      case "t_capture_photos":
        Get.toNamed(
          AppRoutes.teacherCapturePhoto,
          arguments: [
            data,
            _controller.userInfo,
            true,
          ],
        );
        break;

      case "t_capture_attendance":
        Get.toNamed(
          AppRoutes.adminCaptureAttendance,
          arguments: [
            data,
            _controller.userInfo,
            false,
          ],
        );
        break;

      default:
    }
  }
}
