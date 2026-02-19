import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/CS.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/routes/app_routes.dart';
import 'package:scholar_clone/service/notification_service/helper.dart';

import 'student_profile_controller.dart';

class StudentProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userInfo;

  StudentProfileScreen({super.key, required this.userInfo});
  final StudentProfileController _controller =
      Get.put(StudentProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8.0,
        elevation: 0,
        backgroundColor: Colors.white,
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
                  _controller.studentProfileController.scaffoldKey.currentState!
                      .openDrawer();
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 60,
                child: userInfo[CS.school_logo] == null
                    ? Image.asset(AppImage.logo)
                    : Image.network(userInfo[CS.school_logo]),
              ),
            ),
            notification(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            hSizeBox20,
            Stack(
              alignment: Alignment.topCenter,
              children: [
                GestureDetector(
                  onTap: () {},
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
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Image.asset(
                              AppImage.check,
                              height: 22,
                              width: 22,
                              color: Colors.transparent,
                            ),
                            Column(
                              children: [
                                Text(
                                  "${userInfo[CS.first_name]} ${userInfo[CS.last_name]}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.textColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                if ((userInfo["enrollment_no"] ?? "") != "")
                                  Text(
                                      "GR.No ${userInfo["enrollment_no"] ?? ""}"),
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
                    borderRadius: 10.0,
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
                              url: userInfo[CS.image_path] + userInfo[CS.image],
                              height: 60.0,
                              width: 60.0)
                          : Image.asset(AppImage.admin),
                    ),
                  ),
                ),
              ],
            ),
            hSizeBox20,
            Row(
              children: [
                Expanded(
                  child: Info(
                    image: AppImage.birthday,
                    info: userInfo[CS.birthday],
                    title: "Birthdate",
                    textColor: CU.greenColor,
                  ),
                ),
                wSizeBox20,
                Expanded(
                  child: Info(
                    image: AppImage.callBg,
                    info: userInfo["mobile"].toString(),
                    title: "Contact Details",
                    textColor: CU.secondaryColor,
                  ),
                ),
              ],
            ),
            hSizeBox20,
            Container(
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
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Image.asset(
                                AppImage.address,
                                height: 26,
                                color: CU.primaryColor,
                              ),
                            ),
                            Text("Address",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: CU.primaryColor)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 4),
                          alignment: Alignment.centerLeft,
                          child: Text(userInfo[CS.address],
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: CU.textColorDark)),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        AppImage.addressBg,
                        height: 40,
                      ),
                    ),
                  )
                ],
              ),
            ),
            hSizeBox20,
            Container(
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
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Image.asset(
                                AppImage.parentDetails,
                                height: 26,
                                color: CU.secondaryColor,
                              ),
                            ),
                            Text("Parent Details",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: CU.secondaryColor)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 12, bottom: 6),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text("Father Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: CU.textColorlight)),
                              ),
                              Text(
                                  userInfo[CS
                                      .father_name] /*+ " " + widget.userInfo[CS.last_name]*/,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: CU.textColorDark)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 0, bottom: 6),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text("Mother Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: CU.textColorlight)),
                              ),
                              Text(
                                  userInfo[CS
                                      .mother_name] /*+ " " + widget.userInfo[CS.last_name]*/,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: CU.textColorDark)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        AppImage.parentBg,
                        height: 40,
                      ),
                    ),
                  )
                ],
              ),
            ),
            hSizeBox20,
            Info(
              image: "",
              info: userInfo["house"],
              title: "House",
              textColor: CU.errorColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget notification() {
    return Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: AppColor.textColorhint,
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
            );

            clearNotificationCount();
          },
        ),
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
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.title,
    required this.info,
    required this.image,
    required this.textColor,
  });

  final String title;
  final String info;
  final String image;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
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
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 20.0, bottom: 4),
                child: Text(
                  info,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: CU.textColorlight,
                  ),
                ),
              ),
            ],
          ),
          if (image.isNotEmpty)
            Positioned.fill(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  image,
                  height: 40,
                ),
              ),
            )
        ],
      ),
    );
  }
}
