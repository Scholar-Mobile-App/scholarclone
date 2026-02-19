import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';
import 'package:scholar_clone/presentation/admin/admin_main/admin_main_controller.dart';
import 'dart:developer';

import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/routes/app_routes.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/utils/cs.dart';

class AdminMainScreen extends StatelessWidget {
  AdminMainScreen({super.key});
  final AdminMainController _controller = Get.put(AdminMainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.scaffoldKey,
      drawer: Drawer(
        backgroundColor: CU.secondaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              hBox(100),
              GestureDetector(
                onTap: () {
                  // Get.toNamed(
                  //   AppRoutes.ownProfile,
                  //   arguments: [
                  //     _controller.homeData!.data![_controller.typeIndex.value]
                  //         .contents![_controller.screenIndex.value],
                  //     _controller.userInfo,
                  //   ],
                  // );

                  onScreenNavigation(
                    screen: CS.t_own_profile,
                    // data: data.contents![i],
                  );
                },
                child: Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: _controller.userInfo![CS.image],
                      placeholder: (context, url) {
                        return Image.asset(AppImage.profile);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppImage.profile);
                      },
                    ),
                  ),
                ),
              ),
              hSizeBox10,
              Text(
                "${_controller.userInfo!["first_name"]}  ${_controller.userInfo!["last_name"]}",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              hSizeBox20,
              DrawerList(
                title: "Home",
                onTap: () {
                  Get.back();
                },
              ),
              DrawerList(
                title: "My Profile",
                onTap: () {
                  Get.toNamed(
                    AppRoutes.adminOwnProfile,
                    arguments: _controller.userInfo,
                  );
                },
              ),
              // DrawerList(
              //   title: "Rate",
              //   onTap: () {
              //     Get.back();
              //     LaunchReview.launch(
              //       androidAppId: packageName,
              //       iOSAppId: buildNumber,
              //     );
              //   },
              // ),
              DrawerList(
                title: "Share",
                onTap: () {
                  Get.back();
                  Share.share(
                    '$shareMessage\n\n$shareAppUrl',
                    subject: 'text',
                  );
                },
              ),
              DrawerList(
                title: "Logout",
                onTap: () {
                  LocalStorage.clearLocalData();
                  Get.offNamedUntil(AppRoutes.splash, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
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
                      double screenRatio = (Get.width / Get.height) - 0.50;

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
                                        image: !CU.isEmptyOrNull(
                                                data.mainTitleBackgroundImage!)
                                            ? NetworkImage(
                                                data.mainTitleBackgroundImage!)
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
                                              _controller.screenIndex.value = i;

                                              log(data
                                                  .contents![i].screenName!);

                                              onScreenNavigation(
                                                screen: data
                                                    .contents![i].screenName!,
                                                data: data.contents![i],
                                                controller: _controller,
                                              );

                                              log("USER INFO${_controller.userInfo}");
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        (Radius.circular(45))),
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
                        ),
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
}

class DrawerList extends StatelessWidget {
  final String title;
  final Function() onTap;
  const DrawerList({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.fromLTRB(24, 16, 16, 12),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

onScreenNavigation({
  required String screen,
  Content? data,
  AdminMainController? controller,
}) {
  switch (screen.toString()) {
    //User
    case "t_teacher_profile":
      Get.toNamed(
        AppRoutes.adminTeacherProfile,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_proxy":
      Get.toNamed(
        AppRoutes.tProxy,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_message":
      Get.toNamed(
        AppRoutes.tMessage,
        arguments: [data, controller!.userInfo],
      );
      break;

    //LMS

    //Student
    case "t_student_profile":
      Get.toNamed(
        AppRoutes.adminStudentProfileList,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_take_attendance":
      Get.toNamed(
        AppRoutes.takeAttendance,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_homework":
      Get.toNamed(
        AppRoutes.adminAssignHomeWork,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_circular":
      Get.toNamed(
        AppRoutes.adminAddCircular,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_parent_comm":
      Get.toNamed(
        AppRoutes.replyParentCommunication,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_approve_leave":
      Get.toNamed(
        AppRoutes.adminApproveLeave,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_disclipline":
      Get.toNamed(
        AppRoutes.adminStudentDiscipline,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_sms_parent":
      Get.toNamed(
        AppRoutes.adminSendSMS,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_notification_parent":
      Get.toNamed(
        AppRoutes.adminSendNotification,
        arguments: [data, controller!.userInfo],
      );
      break;
    case "t_email_parent":
      Get.toNamed(
        AppRoutes.adminSendEmail,
        arguments: [data, controller!.userInfo],
      );
      break;

    //Utility

    case "t_calander":
      Get.toNamed(
        AppRoutes.tCalander,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_timetable":
      Get.toNamed(
        AppRoutes.teacherTimetable,
        arguments: [data, controller!.userInfo],
      );
      break;

    case CS.t_video_gallary:
    case "t_photo_gallary":
      Get.toNamed(
        AppRoutes.gallary,
        arguments: [data, controller!.userInfo, true],
      );
      break;

    case "t_enquiry":
      Get.toNamed(
        AppRoutes.admissionEnquiry,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_registration":
      Get.toNamed(
        AppRoutes.admissionRegistration,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_confirmation":
      Get.toNamed(
        AppRoutes.admissionConfirmation,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_feescollect":
      Get.toNamed(
        AppRoutes.feesCollect,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_wrt_progress":
      Get.toNamed(
        AppRoutes.tWRTProgress,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_exam_schedule":
      Get.toNamed(
        AppRoutes.tExamSchedule,
        arguments: [data, controller!.userInfo],
      );
      break;

    //miscellaneous
    case "t_requisition":
      Get.toNamed(
        AppRoutes.tRequisition,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_task":
      Get.toNamed(
        AppRoutes.task,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_complain":
      Get.toNamed(
        AppRoutes.tComplain,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_visitor":
      Get.toNamed(
        AppRoutes.teacherVisitor,
        arguments: [data, controller!.userInfo],
      );
      break;

    // HRMS

    case "t_punch_inout":
      Get.toNamed(
        AppRoutes.punchInOut,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_my_leave":
      Get.toNamed(
        AppRoutes.myLeave,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_my_attendance":
      Get.toNamed(
        AppRoutes.myAttendance,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_leave_authorisation":
      Get.toNamed(
        AppRoutes.leaveRequests,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_inward":
      Get.toNamed(
        AppRoutes.adminInward,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_outward":
      Get.toNamed(
        AppRoutes.adminOutward,
        arguments: [data, controller!.userInfo],
      );
      break;

    case "t_capture_photos":
      Get.toNamed(
        AppRoutes.adminCapturePhotos,
        arguments: [
          data,
          controller!.userInfo,
          true,
        ],
      );
      break;

    case "t_capture_attendance":
      Get.toNamed(
        AppRoutes.adminCaptureAttendance,
        arguments: [
          data,
          controller!.userInfo,
          true,
        ],
      );
      break;

    default:
  }
}
