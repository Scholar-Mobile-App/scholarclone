import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import 'fees_collect_controller.dart';

class FeesCollectScreen extends StatelessWidget {
  FeesCollectScreen({super.key});
  final FeesCollectController _controller = Get.put(FeesCollectController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Fees Collect"),
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
            ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      dropDownTextField(
                        title: "Select Section",
                        key: _controller.sectionKey,
                        list: _controller.sectionNameList,
                        onChanged: (value) {
                          _controller.setction.value = value!;
                          _controller.standardKey.currentState?.reset();
                          _controller.divisionKey.currentState?.reset();
                          for (int i = 0;
                              i < _controller.sectionList.length;
                              i++) {
                            if (_controller.sectionList[i].shortName == value) {
                              _controller.sectionID.value =
                                  _controller.sectionList[i].id!;
                              _controller.stdName.value = [];
                              _controller.callServiceStandard(
                                  _controller.sectionID.value);
                              break;
                            }
                          }
                        },
                      ),
                      dropDownTextField(
                        title: "Select Standard",
                        key: _controller.standardKey,
                        list: _controller.stdName,
                        onChanged: (value) {
                          _controller.standard.value = value!;
                          for (int i = 0; i < _controller.stdList.length; i++) {
                            if (_controller.stdList[i].name == value) {
                              _controller.stdID.value =
                                  _controller.stdList[i].id!;
                              _controller.divName.value = [];
                              _controller
                                  .callServiceDivision(_controller.stdID.value);

                              break;
                            }
                          }
                        },
                      ),
                      dropDownTextField(
                          title: "Select Division",
                          key: _controller.divisionKey,
                          list: _controller.divName,
                          onChanged: (value) {
                            for (int i = 0;
                                i < _controller.divList.length;
                                i++) {
                              if (_controller.divList[i]["name"] == value) {
                                _controller.divID.value =
                                    _controller.divList[i]["id"];
                                log("123 ${_controller.divID.value}");
                                break;
                              }
                            }
                          }),
                      AppButton(
                        text: "Search",
                        onTap: () {
                          _controller.callServiceSearch();
                        },
                      ),
                    ],
                  ),
                ),
                hSizeBox20,
                if (_controller.studentList.isNotEmpty) attendance(),
              ],
            )
          ],
        ),
      ),
    );
  }

  attendance() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _controller.studentList.length,
            separatorBuilder: (context, index) => Container(
              color: Colors.black,
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 1,
            ),
            itemBuilder: (context, index) => attendanceTile(
              _controller.studentList[index],
              index,
            ),
          ),
        ],
      ),
    );
  }

  attendanceTile(Student studentInfo, int index) {
    return Container(
      color: Colors.white,
      width: Get.width,
      child: Row(
        children: [
          Container(
            height: Get.width * 0.15,
            width: Get.width * 0.15,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: (studentInfo.studentImage != "" &&
                        studentInfo.studentImage != null)
                    ? NetworkImage(studentInfo.studentImage!)
                    : const ExactAssetImage('assets/images/profile.png')
                        as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  studentInfo.studentName ?? "",
                  style: TextStyle(
                    color: CU.tprimaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                hSizeBox10,
                Row(
                  children: [
                    Text(
                      "Roll No. ${studentInfo.rollNo}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    wSizeBox20,
                    Text(
                      "GR No. ${studentInfo.enrollmentNo}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: AppButton(
              text: "Collect Fees",
              onTap: () {
                Get.toNamed(
                  AppRoutes.feesCollectDetails,
                  arguments: [
                    _controller.data,
                    _controller.userInfo,
                    studentInfo
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
