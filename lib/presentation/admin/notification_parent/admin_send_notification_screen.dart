import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

import 'admin_send_notification_controller.dart';

class AdminSendNotificationScreen extends StatelessWidget {
  AdminSendNotificationScreen({super.key});
  final AdminSendNotificationController _controller =
      Get.put(AdminSendNotificationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Send Notification"),
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
            _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                list: _controller.sectionName,
                                onChanged: (value) async {
                                  for (var i = 0;
                                      i <
                                          _controller
                                              .sectionModel!.data!.length;
                                      i++) {
                                    if (_controller
                                            .sectionModel!.data![i].shortName ==
                                        value) {
                                      _controller.sectionID.value = _controller
                                          .sectionModel!.data![i].id!;
                                      _controller.stdName.value = [];

                                      await _controller.callServiceStandared(
                                          _controller.sectionID.value);
                                    }
                                  }
                                },
                              ),
                              dropDownTextField(
                                title: "Select Standard",
                                list: _controller.stdName,
                                onChanged: (value) {
                                  for (int i = 0;
                                      i < _controller.stdName.length;
                                      i++) {
                                    if (_controller
                                            .standardModel!.data![i].name ==
                                        value) {
                                      _controller.stdId.value = _controller
                                          .standardModel!.data![i].id!;
                                      _controller.divName.value = [];

                                      _controller.callServiceDivision(
                                          _controller.stdId.value);

                                      break;
                                    }
                                  }
                                },
                              ),
                              dropDownTextField(
                                title: "Select Division",
                                list: _controller.divName,
                                onChanged: (value) {
                                  for (int i = 0;
                                      i <
                                          _controller
                                              .divisionModel!.data!.length;
                                      i++) {
                                    if (_controller
                                            .divisionModel!.data![i].name ==
                                        value) {
                                      _controller.divId.value = _controller
                                          .divisionModel!.data![i].id!;
                                      break;
                                    }
                                  }
                                },
                              ),
                              AppButton(
                                text: "Search",
                                onTap: _controller.divId.value == 0
                                    ? null
                                    : () {
                                        _controller.callServiceAllocate();
                                      },
                              )
                            ],
                          ),
                        ),
                        hSizeBox30,
                        _controller.isStudentLoading.value
                            ? const Center(
                                child: CircularProgressIndicator.adaptive())
                            : Column(
                                children: [
                                  if (_controller.studentList.isNotEmpty)
                                    Column(
                                      children: [
                                        studentselection(),
                                        addHomeWorkform(),
                                        Center(
                                          child: AppButton(
                                            text: "Send",
                                            loader:
                                                _controller.isAPIcalling.value,
                                            onTap: _controller.email.isEmpty ||
                                                    _controller
                                                        .message.value.isEmpty
                                                ? null
                                                : () {
                                                    _controller
                                                        .callServiceSendNoti(
                                                            context);
                                                  },
                                          ),
                                        ),
                                      ],
                                    ),
                                  hSizeBox20
                                ],
                              ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Container studentselection() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 15,
                width: 15,
                child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    value: (_controller.selectAll.value) ? true : false,
                    activeColor: Colors.green,
                    onChanged: (_) {
                      if (!_controller.selectAll.value) {
                        _controller.selectAll.value = true;
                        for (int i = 0;
                            i < _controller.studentList.length;
                            i++) {
                          if (!_controller.checkData.contains(
                              _controller.studentList[i].enrollmentNo)) {
                            _controller.checkData
                                .add(_controller.studentList[i].enrollmentNo!);
                            _controller.email
                                .add(_controller.studentList[i].id.toString());
                          }
                        }
                      } else {
                        _controller.checkData.value = [];
                        _controller.email.value = [];
                        _controller.selectAll.value = false;
                      }
                    }),
              ),
              wSizeBox16,
              const Text(
                "Select All",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          hSizeBox18,
          ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return profile(_controller.studentList[index], index);
            },
            separatorBuilder: (context, index) {
              return Container(
                color: Colors.grey[500],
                margin: const EdgeInsets.only(
                  left: 30,
                  top: 10,
                  bottom: 10,
                ),
                height: 1,
              );
            },
            itemCount: _controller.studentList.length,
          )
        ],
      ),
    );
  }

  profile(Student list, int index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 15,
                width: 15,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  value: (_controller.checkData.contains(list.enrollmentNo))
                      ? true
                      : false,
                  activeColor: Colors.green,
                  onChanged: (_) {
                    _controller.selectAll.value = false;
                    if (!_controller.checkData.contains(list.enrollmentNo)) {
                      _controller.checkData.add(list.enrollmentNo!);
                      _controller.email.add(list.id.toString());
                    } else {
                      _controller.checkData.remove(list.enrollmentNo);
                      _controller.email.remove(list.id.toString());
                    }
                  },
                ),
              ),
              wSizeBox16,
              Container(
                child: Row(
                  children: [
                    Container(
                      height: Get.width * 0.15,
                      width: Get.width * 0.15,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(list.studentImage ?? ""),
                              fit: BoxFit.cover)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              list.studentName ?? "",
                              style: TextStyle(
                                color: CU.tprimaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${list.standardName} - ${list.divisionName}",
                              style: const TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Roll No. ${list.rollNo}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "GR No. ${list.enrollmentNo}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "+91${list.mobile}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );

  addHomeWorkform() {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          textField(
            title: "Enter Notification text",
            hintText: "Enter Your Notification text...",
            maxLine: 5,
            onChanged: (value) {
              _controller.message.value = value;
            },
          ),
        ],
      ),
    );
  }
}
