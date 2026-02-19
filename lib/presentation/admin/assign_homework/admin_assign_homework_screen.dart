import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/admin/get_admin_student_list_model.dart';
import 'package:scholar_clone/presentation/admin/assign_homework/admin_assign_homework_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

class AdminAssignHomeWorkScreen extends StatelessWidget {
  AdminAssignHomeWorkScreen({super.key});
  final AdminAssignHomeworkController _controller =
      Get.put(AdminAssignHomeworkController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          elevation: 0,
          backgroundColor: CU.tprimaryColor,
          title: const Text(
            "Assign Homework",
            style: TextStyle(color: Colors.white),
          ),
          // systemOverlayStyle: SystemUiOverlayStyle.light,
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
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  selectData(),
                  if (_controller.studentList.isNotEmpty)
                    Column(
                      children: [
                        hSizeBox18,
                        addHomework(context),
                        hSizeBox18,
                        selectStudent(),
                        hSizeBox18,
                        Row(
                          children: [
                            wSizeBox20,
                            Expanded(
                              child: AppButton(
                                text: "Submit",
                                color: Colors.green,
                                onTap: _controller.checkData.isEmpty
                                    ? null
                                    : () {
                                        _controller.callService();
                                      },
                              ),
                            ),
                            wSizeBox20,
                            Expanded(
                              child: AppButton(
                                text: "Cancel",
                                color: Colors.red,
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ),
                            wSizeBox20,
                          ],
                        ),
                        hSizeBox20,
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

  Widget selectStudent() {
    return Container(
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
          const Text(
            "Select Students",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            color: Colors.grey[400],
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 1,
          ),
          hSizeBox20,
          Row(
            children: [
              SizedBox(
                height: 15,
                width: 15,
                child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    value: _controller.selectAll.value ? true : false,
                    activeColor: Colors.green,
                    onChanged: (_) {
                      if (!_controller.selectAll.value) {
                        _controller.selectAll.value = true;
                        for (int i = 0;
                            i < _controller.studentModel!.data!.length;
                            i++) {
                          if (!_controller.checkData.contains(_controller
                              .studentModel!.data![i].id
                              .toString())) {
                            _controller.checkData.add(
                              _controller.studentModel!.data![i].id.toString(),
                            );
                            _controller.email.add(
                              _controller.studentModel!.data![i].id.toString(),
                            );
                          }
                        }
                      } else {
                        _controller.checkData.value = [];
                        _controller.email.value = [];
                        _controller.selectAll.value = false;
                      }
                    }),
              ),
              wSizeBox10,
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
          hSizeBox16,
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _controller.studentModel!.data!.length,
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
            itemBuilder: (context, index) {
              return profile(
                _controller.studentModel!.data![index],
                index,
              );
            },
          )
        ],
      ),
    );
  }

  profile(AdminStudent studentList, int index) {
    return Obx(
      () => Row(
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
                  value: (_controller.checkData
                          .contains(studentList.id.toString()))
                      ? true
                      : false,
                  activeColor: Colors.green,
                  onChanged: (_) {
                    _controller.selectAll.value = false;
                    if (!_controller.checkData
                        .contains(studentList.enrollmentNo)) {
                      _controller.checkData.add(studentList.id.toString());
                      _controller.email.add(studentList.id.toString());
                    } else {
                      _controller.checkData.remove(studentList.id.toString());
                      _controller.email.remove(studentList.id.toString());
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
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
                          image: NetworkImage(studentList.studentImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              studentList.studentName ?? "",
                              style: TextStyle(
                                color: CU.tprimaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            wSizeBox10,
                            Text(
                              "${studentList.standardName} - ${studentList.divisionName}",
                              style: const TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        hSizeBox6,
                        Row(
                          children: [
                            Text(
                              "Roll No. ${studentList.rollNo}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "GR No. ${studentList.enrollmentNo}",
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
                              "+91${studentList.mobile}",
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
      ),
    );
  }

  Container addHomework(BuildContext context) {
    return Container(
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
          const Text(
            "Add Home Work",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            color: Colors.grey[400],
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 1,
          ),
          hSizeBox20,
          textField(
            title: "Title",
            hintText: "Type Here",
            onChanged: (value) {
              _controller.title.value = value;
            },
          ),
          textField(
            title: "Description",
            hintText: "Type Here",
            onChanged: (value) {
              _controller.discription.value = value;
            },
          ),
          dateTimeTextField(
            title: "Submission Date",
            date: _controller.selectedDate.value,
            onTap: (value) {
              _controller.selectedDate.value = value;
            },
            context: Get.context!,
          ),
          // filePickField(
          //   context: context,
          //   title: "HomeWork Image",
          //   imageFile: _controller.imageFile.value,
          //   onTap: (value) {
          //     _controller.imageFile.value = value;
          //   },
          // ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Attachment",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _controller.imageFile != null
                            ? _controller.imageFile.split('/').last.isEmpty
                                ? "Choose"
                                : _controller.imageFile.split('/').last
                            : "Choose",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        onPressed: () {
                          _controller.pickPhotos();
                        },
                        child: const Text(
                          "Choose File",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget selectData() {
    return Container(
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
              for (var i = 0; i < _controller.sectionModel!.data!.length; i++) {
                if (_controller.sectionModel!.data![i].shortName == value) {
                  _controller.sectionID.value =
                      _controller.sectionModel!.data![i].id!;
                  _controller.stdName.value = [];

                  await _controller
                      .callServiceStandared(_controller.sectionID.value);
                }
              }
            },
          ),
          dropDownTextField(
            title: "Select Standard",
            list: _controller.stdName,
            onChanged: (value) {
              for (int i = 0; i < _controller.stdName.length; i++) {
                if (_controller.standardModel!.data![i].name == value) {
                  _controller.stdId.value =
                      _controller.standardModel!.data![i].id!;
                  _controller.divName.value = [];
                  _controller.subjectName.value = [];
                  _controller.callServiceDivision(_controller.stdId.value);
                  _controller.callServiceSubject(_controller.stdId);
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
                  i < _controller.divisionModel!.data!.length;
                  i++) {
                if (_controller.divisionModel!.data![i].name == value) {
                  _controller.divId.value =
                      _controller.divisionModel!.data![i].id!;
                  break;
                }
              }
            },
          ),
          dropDownTextField(
            title: "Select Subject",
            list: _controller.subjectName,
            onChanged: (value) {
              for (int i = 0;
                  i < _controller.teacherSubjectModel!.data!.length;
                  i++) {
                if (_controller.teacherSubjectModel!.data![i].subjectName ==
                    value) {
                  _controller.subjectId.value =
                      _controller.teacherSubjectModel!.data![i].subjectId!;

                  _controller.selectSubject.value =
                      _controller.teacherSubjectModel!.data![i].subjectName!;

                  log(_controller.selectSubject.value);
                  break;
                }
              }
            },
          ),
          AppButton(
            text: "Search",
            onTap: _controller.selectSubject.value.isEmpty
                ? null
                : () {
                    _controller.callServiceSearch();
                  },
          )
        ],
      ),
    );
  }
}
