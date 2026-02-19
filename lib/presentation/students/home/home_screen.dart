import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/presentation/students/home/home_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/routes/app_routes.dart';
import 'package:scholar_clone/service/notification_service/helper.dart';

import '../../../core/utils/cs.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.userInfo,
    required this.homeDataModel,
  });
  final Map<String, dynamic> userInfo;
  final HomeDataModel homeDataModel;

  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8.0,
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
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
                  color: AppColor.secondaryColor,
                ),
                onPressed: () {
                  _controller.studentMainController.scaffoldKey.currentState!
                      .openDrawer();
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 52,
                child: userInfo[CS.school_logo] == null
                    ? Image.asset(AppImage.logo)
                    : CachedNetworkImage(
                        imageUrl: userInfo[CS.school_logo],
                        errorWidget: (context, url, error) {
                          return Image.asset(AppImage.logo);
                        },
                      ),
              ),
            ),
            notification(),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: Get.height * .15,
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.offNamedUntil(
                        //   AppRoutes.studentMain,
                        //   arguments: userInfo[index],
                        //   (route) => false,
                        // );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(top: 50),
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              offset: const Offset(3, 3),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        userInfo[CS.roll_no],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.secondaryColor,
                                        ),
                                      ),
                                      hSizeBox4,
                                      Text(
                                        "Roll No",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColor.textColorlight,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        userInfo[CS.std_name] +
                                            " - " +
                                            userInfo[CS.division],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.greenColor,
                                        ),
                                      ),
                                      hSizeBox4,
                                      Text(
                                        "STD",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColor.textColorlight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            hSizeBox20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                Column(
                                  children: [
                                    Text(
                                      "${userInfo[CS.first_name]} ${userInfo[CS.last_name]}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.textColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      userInfo[CS.section],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColor.textColorlight,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  AppImage.check,
                                  height: 22,
                                  width: 22,
                                  color: Colors.green,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipPolygon(
                        sides: 5,
                        borderRadius: 10.0, // Defaults to 0.0 degrees
                        // Defaults to 0.0 degrees
                        boxShadows: [
                          PolygonBoxShadow(color: Colors.grey, elevation: 1.0),
                        ],

                        child: Container(
                          height: 50,
                          width: 50,
                          color: Colors.black,
                          child: userInfo[CS.image] != null ||
                                  userInfo[CS.image].toString().isNotEmpty
                              ? CU.loadImage(
                                  url: userInfo[CS.image_path] +
                                      userInfo[CS.image],
                                  height: 60.0,
                                  width: 60.0)
                              : Image.asset(AppImage.admin),
                        ),
                      ),
                    ),
                  ],
                ),
                hSizeBox20,
                Obx(
                  () => (!_controller.isLoading.value &&
                          _controller.apiStatus.value == 1)
                      ? Stack(
                          children: [
                            Positioned(
                              top: 0,
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColor.redColor.withValues(alpha: .2),
                                border: Border.all(color: AppColor.redColor),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50.0,
                                    width: 50.0,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      AppImage.coin,
                                    ),
                                  ),
                                  wSizeBox10,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Fees",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: CU.textColorDark,
                                        ),
                                      ),
                                      Text(
                                        "Previous ₹ ${_controller.previousFees.value}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: CU.textColorDark,
                                        ),
                                      ),
                                      Text(
                                        "Current ₹ ${_controller.currentFees.value}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: CU.textColorDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: 100,
                                    child: AppButton(
                                      text: "Pay",
                                      color: AppColor.redColor,
                                      onTap: () {
                                        Get.toNamed(
                                          AppRoutes.feesDetails,
                                          arguments: [Content(), userInfo],
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 50),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeDataModel.data!.length,
                  separatorBuilder: (context, index) => hSizeBox20,
                  itemBuilder: (context, i) {
                    var data = homeDataModel.data![i];
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
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
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
                                  // Container(
                                  //   child: Wrap(
                                  //       direction: Axis.horizontal,
                                  //       children: List.generate(
                                  //           data.contents!.length, (index) {
                                  //         return Container(
                                  //           color: Colors.red,
                                  //           child: Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             mainAxisSize: MainAxisSize.min,
                                  //             children: [
                                  //               GestureDetector(
                                  //                 onTap: () {
                                  //                   log(data.contents![index]
                                  //                       .screenName!);

                                  //                   onScreenNavigation(
                                  //                       screen: data
                                  //                           .contents![index]
                                  //                           .screenName!,
                                  //                       data: data
                                  //                           .contents![index]);
                                  //                 },
                                  //                 child: Container(
                                  //                   padding:
                                  //                       const EdgeInsets.all(
                                  //                           6.0),
                                  //                   child: ClipRRect(
                                  //                     borderRadius:
                                  //                         const BorderRadius
                                  //                                 .all(
                                  //                             (Radius.circular(
                                  //                                 45))),
                                  //                     child: CU.loadImage(
                                  //                       url: data
                                  //                           .contents![index]
                                  //                           .subTitleIcon,
                                  //                       height: 50.0,
                                  //                       width: 50.0,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               Container(
                                  //                 // alignment: Alignment.center,
                                  //                 child: Text(
                                  //                   data.contents![index]
                                  //                       .subTitle!,
                                  //                   textAlign: TextAlign.center,
                                  //                   maxLines: 2,
                                  //                   overflow: TextOverflow.clip,
                                  //                   style: TextStyle(
                                  //                     fontSize: 10,
                                  //                     fontWeight:
                                  //                         FontWeight.bold,
                                  //                     color: CU.textColorDark,
                                  //                   ),
                                  //                 ),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         );
                                  //       })),
                                  // ),
                                  GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 4,
                                    childAspectRatio: .8,
                                    children: List.generate(
                                      data.contents!.length,
                                      (index) => Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              log(data.contents![index]
                                                  .screenName!);

                                              onScreenNavigation(
                                                  screen: data.contents![index]
                                                      .screenName!,
                                                  data: data.contents![index]);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        (Radius.circular(45))),
                                                child: CU.loadImage(
                                                  url: data.contents![index]
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
                                              data.contents![index].subTitle!,
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
                                      ),
                                    ),
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget notification() {
    return Stack(
      children: <Widget>[
        IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () async {
              await Get.toNamed(
                AppRoutes.studentNotificationHub,
                arguments: [
                  Content(
                    screenName: "notification_hub",
                    subTitle: "Notification Hub",
                    subTitleApi: "https://erp.triz.co.in/notificationHubAPI",
                    subTitleApiParam:
                        "type,student_id,sub_institute_id,mobile_no,imei",
                    subTitleIcon:
                        "https://erp.triz.co.in/storage/homescreen/icon/Notification_Hub.png",
                  ),
                  userInfo
                ],
              )!
                  .then((value) => clearNotificationCount());
            }),
        if (LocalStorage.notificationCount.value > 0)
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 14,
                minHeight: 14,
              ),
              child: Text(
                LocalStorage.notificationCount.value.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
      ],
    );
  }

  onScreenNavigation({
    required String screen,
    Content? data,
  }) {
    switch (screen.toString()) {
      //LMS
      case "lms_subject":
        Get.toNamed(
          AppRoutes.learn,
          arguments: [data, userInfo],
        );
        break;

      case "virtual_classroom":
        Get.toNamed(
          AppRoutes.virtualClassroom,
          arguments: [data, userInfo],
        );
        break;

      case "social_collabrative":
        Get.toNamed(
          AppRoutes.socialCollabrative,
          arguments: [data, userInfo],
        );
        break;

      case "leaderboard":
        Get.toNamed(
          AppRoutes.leaderboard,
          arguments: [data, userInfo],
        );
        break;

      case "lms_pal":
        Get.toNamed(
          AppRoutes.pal,
          arguments: [data, userInfo],
        );
        break;

      case "portfolio":
        Get.toNamed(
          AppRoutes.portfolio,
          arguments: [data, userInfo],
        );
        break;

      //Activity
      case "child_remark":
        Get.toNamed(
          AppRoutes.studentDiscipline,
          arguments: [data, userInfo],
        );
        break;

      case "exam_schedule":
        Get.toNamed(
          AppRoutes.examSchedule,
          arguments: [data, userInfo],
        );
        break;

      case "student_attendance":
        Get.toNamed(
          AppRoutes.studentAttendance,
          arguments: [data, userInfo],
        );
        break;

      case "circular_events":
        Get.toNamed(
          AppRoutes.circularEvents,
          arguments: userInfo,
        );
        break;

      case "academic_calendar":
        Get.toNamed(
          AppRoutes.academicCalendar,
          arguments: [data, userInfo],
        );
        break;

      case "result_pdf":
        Get.toNamed(
          AppRoutes.resultsPDF,
          arguments: [data, userInfo],
        );
        break;

      case "achievement_certificate":
        Get.toNamed(
          AppRoutes.achievementCertificate,
          arguments: [data, userInfo],
        );
        break;

      // Profile Gallery
      case "subjects":
        Get.toNamed(
          AppRoutes.teacherList,
          arguments: userInfo,
        );
        break;

      case "health_details":
        Get.toNamed(
          AppRoutes.healthDetails,
          arguments: [data, userInfo],
        );
        break;

      case "photos_gallery":
      case "video_gallery":
        Get.toNamed(
          AppRoutes.photoGallery,
          arguments: [data, userInfo],
        );
        break;

      //Main
      case "notification_hub":
        Get.toNamed(
          AppRoutes.studentNotificationHub,
          arguments: [data, userInfo],
        );
        break;

      case "assignment":
      case "home_work":
        Get.toNamed(
          AppRoutes.homework,
          arguments: [data, userInfo],
        );
        break;

      case "fees":
        Get.toNamed(
          AppRoutes.feesDetails,
          arguments: [data, userInfo],
        );
        break;

      //Utility
      case "leave_application":
        Get.toNamed(
          AppRoutes.leave,
          arguments: [data, userInfo],
        );
        break;

      case "parent_communication":
        Get.toNamed(
          AppRoutes.parentCommunication,
          arguments: [data, userInfo],
        );
        break;

      case "holiday_list":
        Get.toNamed(
          AppRoutes.holidayList,
          arguments: [data, userInfo],
        );
        break;

      case "time_table":
        Get.toNamed(
          AppRoutes.timeTable,
          arguments: [data, userInfo],
        );
        break;

      case "student_certificate":
        Get.toNamed(
          AppRoutes.certificate,
          arguments: [data, userInfo],
        );
        break;

      case "wrt_progress":
        Get.toNamed(
          AppRoutes.wrtProgressReport,
          arguments: [data, userInfo],
        );
        break;

      // School Details
      case "about_us":
        Get.toNamed(
          AppRoutes.aboutUs,
          arguments: [data, userInfo],
        );
        break;

      case "principal_desk":
        Get.toNamed(
          AppRoutes.principalDesk,
          arguments: [data, userInfo],
        );
        break;

      case "school_information":
        Get.toNamed(
          AppRoutes.schoolInformation,
          arguments: [data, userInfo],
        );
        break;

      case "achievement":
        Get.toNamed(
          AppRoutes.achievement,
          arguments: [data, userInfo],
        );
        break;

      case "school_timing":
        Get.toNamed(
          AppRoutes.schoolTiming,
          arguments: [data, userInfo],
        );
        break;

      case "rules":
        Get.toNamed(
          AppRoutes.rules,
          arguments: [data, userInfo],
        );
        break;

      case "facility":
        Get.toNamed(
          AppRoutes.facility,
          arguments: [data, userInfo],
        );
        break;

      case "acadamic_activity":
        Get.toNamed(
          AppRoutes.acadamicActivity,
          arguments: [data, userInfo],
        );
        break;

      case "reach_us":
        Get.toNamed(
          AppRoutes.reachUs,
          arguments: [data, userInfo],
        );
        break;

      // Students Details
      case "student_transport":
        Get.toNamed(
          AppRoutes.transport,
          arguments: [data, userInfo],
        );
        break;

      case "student_hostel":
        Get.toNamed(
          AppRoutes.hostel,
          arguments: [data, userInfo],
        );
        break;

      case "student_infirmary":
        Get.toNamed(
          AppRoutes.infirmary,
          arguments: [data, userInfo],
        );
        break;

      case "student_vaccination":
        Get.toNamed(
          AppRoutes.vaccination,
          arguments: [data, userInfo],
        );
        break;
      case "height_weight":
        Get.toNamed(
          AppRoutes.heightWeight,
          arguments: [data, userInfo],
        );
        break;

      case "classwork_gallery":
        Get.toNamed(
          AppRoutes.classworkGallery,
          arguments: [data, userInfo],
        );
        break;

      case "student_consent":
        Get.toNamed(
          AppRoutes.consent,
          arguments: [data, userInfo],
        );
        break;

      case "capture_photos":
        Get.toNamed(
          AppRoutes.studentFaceAttendance,
          arguments: [data, userInfo],
        );
        break;

      default:
    }
  }
}
