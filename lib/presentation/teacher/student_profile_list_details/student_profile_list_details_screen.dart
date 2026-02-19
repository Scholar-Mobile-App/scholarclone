import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import '../../../core/utils/app_color.dart';

class StudentProfileListDetailScreen extends StatelessWidget {
  StudentProfileListDetailScreen({super.key});

  final StudentProfileListDetailController _controller =
      Get.put(StudentProfileListDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Student Profiles"),
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
            child: Column(children: [
              hSizeBox20,
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
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
                                    "${_controller.student.rollNo}",
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
                                    "${_controller.student.standardName} - ${_controller.student.divisionName}",
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
                            Text(
                              "${_controller.student.studentName}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.bold),
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
                        child: _controller.student.studentImage != null ||
                                _controller.student.studentImage
                                    .toString()
                                    .isNotEmpty
                            ? CU.loadImage(
                                url: _controller.student.studentImage,
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
                    child: info(
                      header: "Birthdate",
                      details: _controller.student.dob ?? "",
                      textColor: CU.greenColor,
                      image: AppImage.birthday,
                    ),
                  ),
                  wSizeBox20,
                  Expanded(
                    child: info(
                      header: "Contact Details",
                      details: _controller.student.mobile ?? "",
                      textColor: CU.secondaryColor,
                      image: AppImage.callBg,
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
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 4),
                            alignment: Alignment.centerLeft,
                            child: Text("${_controller.student.address}",
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
            ]),
          ),
        ],
      ),
    );
  }

  Container info({
    required String header,
    required String details,
    required Color textColor,
    required String image,
  }) {
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
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 20.0, bottom: 4),
                  child: Text(
                    details,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(header,
                      style: TextStyle(fontSize: 14, color: CU.textColorlight)),
                ),
              ],
            ),
          ),
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

class StudentProfileListDetailController extends GetxController {
  Student student = Get.arguments;
}
