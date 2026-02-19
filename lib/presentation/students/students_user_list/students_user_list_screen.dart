import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import 'students_user_list_controller.dart';

class StudentUserListScreen extends StatelessWidget {
  StudentUserListScreen({super.key});

  final StudentUserListController _controller =
      Get.put(StudentUserListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8.0,
        elevation: 0,
        title: const Text(''),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Stack(
        children: [
          Container(
            height: Get.height * .2,
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
          ListView.separated(
            padding: const EdgeInsets.only(top: 50, bottom: 30),
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _controller.userInfo.length,
            separatorBuilder: (context, index) => hSizeBox30,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.offNamed(
                        AppRoutes.studentMain,
                        arguments: [
                          _controller.userInfo[index],
                          _controller.homeData
                        ],
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin:
                          const EdgeInsets.only(right: 10, left: 10, top: 50),
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
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Text(
                                          _controller.userInfo[index]
                                                  [CS.roll_no] ??
                                              "-",
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
                                  ),
                                ),
                                Expanded(child: Container()),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: Column(
                                      children: [
                                        Text(
                                          _controller.userInfo[index]
                                                  [CS.std_name] +
                                              " - " +
                                              _controller.userInfo[index]
                                                  [CS.division],
                                          textAlign: TextAlign.center,
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
                                  ),
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
                                    "${_controller.userInfo[index][CS.first_name]} ${_controller.userInfo[index][CS.last_name]}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColor.textColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _controller.userInfo[index][CS.section],
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
                        child: _controller.userInfo[index][CS.image] != null ||
                                _controller.userInfo[index][CS.image]
                                    .toString()
                                    .isNotEmpty
                            ? CU.loadImage(
                                url: _controller.userInfo[index]
                                        [CS.image_path] +
                                    _controller.userInfo[index][CS.image],
                                height: 60.0,
                                width: 60.0)
                            : Image.asset(AppImage.admin),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
