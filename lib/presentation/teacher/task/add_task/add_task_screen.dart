import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/teacher/task/add_task/add_task_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});
  final AddTAskController _controller = Get.put(AddTAskController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Add Task"),
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
                      textField(
                        title: "Title",
                        hintText: "Type Here",
                        maxLine: 1,
                        onChanged: (value) {
                          _controller.title.value = value;
                        },
                      ),
                      textField(
                        title: "Description",
                        hintText: "Type Here",
                        maxLine: 3,
                        onChanged: (value) {
                          _controller.description.value = value;
                        },
                      ),
                      dropDownTextField(
                        title: "Allocated To",
                        key: _controller.allocatedKey,
                        list: _controller.allocateNameList,
                        onChanged: (value) {
                          for (int i = 0;
                              i < _controller.toMeetList.length;
                              i++) {
                            if (_controller.toMeetList[i].staffName == value) {
                              _controller.allocate.value =
                                  _controller.toMeetList[i].id!;
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Task Attachment",
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppButton(
                    text: "Save",
                    onTap: () {
                      _controller.callService(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
