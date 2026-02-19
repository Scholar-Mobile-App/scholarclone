import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/teacher/own_profile/own_profile_screen.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import 'teacher_profile_controller.dart';

class TeacherProfileScreen extends StatelessWidget {
  TeacherProfileScreen({super.key});
  final TeacherProfileController _controller =
      Get.put(TeacherProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Teacher Profile"),
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(Get.width / 2, 30),
                bottomRight: Radius.elliptical(Get.width / 2, 30),
              ),
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
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              _controller.adminTeacherProfile.userFullName ??
                                  "",
                              style: TextStyle(
                                fontSize: 14,
                                color: CU.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: _controller.adminTeacherProfile.image!,
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
                  ],
                ),
                hSizeBox20,
                Row(
                  children: [
                    Expanded(
                      child: TeacherInfo(
                        image: AppImage.birthday,
                        info: DateFormat('yyyy-MM-dd')
                            .format(_controller.adminTeacherProfile.birthdate!),
                        title: "Birthdate",
                        textColor: CU.greenColor,
                      ),
                    ),
                    wSizeBox20,
                    Expanded(
                      child: TeacherInfo(
                        image: AppImage.callBg,
                        info: _controller.adminTeacherProfile.mobile!,
                        title: "Contact Details",
                        textColor: CU.secondaryColor,
                      ),
                    ),
                  ],
                ),
                hSizeBox20,
                Row(
                  children: [
                    Expanded(
                      child: TeacherInfo(
                        image: "",
                        info: _controller.adminTeacherProfile.email ?? "",
                        title: "Email",
                        textColor: CU.textColorlight,
                      ),
                    ),
                    wSizeBox20,
                    Expanded(
                      child: TeacherInfo(
                        image: "",
                        info: _controller.adminTeacherProfile.joinYear!,
                        title: "Joining Year",
                        textColor: CU.textColorlight,
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
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Image.asset(
                                    AppImage.address,
                                    height: 26,
                                    color: CU.primaryColor,
                                  ),
                                ),
                                Text(
                                  "Address",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: CU.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 12.0, bottom: 4),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _controller.adminTeacherProfile.address!,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: CU.textColorDark,
                                ),
                              ),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
