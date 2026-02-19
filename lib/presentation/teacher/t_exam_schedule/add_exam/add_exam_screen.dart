import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

import 'add_exam_controller.dart';

class AddExamScreen extends StatelessWidget {
  AddExamScreen({super.key});
  final AddExamController _controller = Get.put(AddExamController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Add Exam Schedule"),
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
                        title: "Select Standard",
                        key: _controller.standardKey,
                        list: _controller.stdName,
                        onChanged: (value) {
                          _controller.standard.value = value!;
                          for (int i = 0; i < _controller.stdList.length; i++) {
                            if (_controller.stdList[i].stdName == value) {
                              _controller.stdID.value =
                                  _controller.stdList[i].stdId!;
                              _controller.divName.value = [];
                              _controller.callServiceDivision();
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
                          for (int i = 0; i < _controller.divList.length; i++) {
                            if (_controller.divList[i].divName == value) {
                              _controller.divID.value =
                                  _controller.divList[i].divId!;
                              break;
                            }
                          }
                        },
                      ),
                      dateTimeTextField(
                        title: "Date",
                        date: _controller.selectedDate.value,
                        onTap: (value) {
                          _controller.selectedDate.value = value;
                        },
                        context: context,
                      ),
                      textField(
                        title: "Enter Title",
                        hintText: "Type Here",
                        maxLine: 1,
                        onChanged: (value) {
                          _controller.title.value = value;
                        },
                      ),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
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
                                        ? _controller.imageFile
                                                .split('/')
                                                .last
                                                .isEmpty
                                            ? "Choose"
                                            : _controller.imageFile
                                                .split('/')
                                                .last
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
                ),
                hSizeBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: AppButton(
                    text: "Submit",
                    onTap: _controller.imageFile.isEmpty ||
                            _controller.title.value == "" ||
                            _controller.stdID.value == 0 ||
                            _controller.divID.value == 0
                        ? null
                        : () {
                            _controller.callServiceSubmit(context);
                          },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
