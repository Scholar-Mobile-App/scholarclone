import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import 'add_visitor_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

import '../../../../core/utils/constant_sizebox.dart';

class AddVisitorScreen extends StatelessWidget {
  AddVisitorScreen({super.key});
  final AddVisitorController _controller = Get.put(AddVisitorController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Add Visitor"),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Appointment Type',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            checkBox(
                              text: "   Direct Appointment",
                              value: _controller.directAppointment.value,
                              onTap: (val) {
                                _controller.appointmentType.value = "Direct";

                                _controller.directAppointment.value =
                                    !_controller.directAppointment.value;
                                log(_controller.directAppointment.value
                                    .toString());
                              },
                            ),
                            checkBox(
                              text: "   Prior Appointment",
                              value: !_controller.directAppointment.value,
                              onTap: (val) {
                                _controller.appointmentType.value = "Prior";

                                _controller.directAppointment.value =
                                    !_controller.directAppointment.value;
                              },
                            )
                          ],
                        ),
                      ),
                      hSizeBox10,
                      dropDownTextField(
                        key: _controller.visitorKey,
                        title: "Visitor Type",
                        list: _controller.visitorNameList,
                        onChanged: (value) {
                          for (int i = 0;
                              i < _controller.toVisitorList.length;
                              i++) {
                            if (_controller.toVisitorList[i].title == value) {
                              _controller.visitorID.value =
                                  _controller.toVisitorList[i].id!;
                              break;
                            }
                          }
                        },
                      ),
                      textField(
                        title: "Visitor Name",
                        hintText: "Type Here",
                        maxLine: 1,
                        onChanged: (value) {
                          _controller.visitorName.value = value;
                        },
                      ),
                      textField(
                        title: "Visitor Contact",
                        hintText: "Type Here",
                        maxLine: 3,
                        onChanged: (value) {
                          _controller.visitorContact.value = value;
                        },
                      ),
                      textField(
                        title: "Visitor Email",
                        hintText: "Type Here",
                        onChanged: (value) {
                          _controller.visitorEmail.value = value;
                        },
                      ),
                      textField(
                        title: "Coming From",
                        hintText: "Type Here",
                        onChanged: (value) {
                          _controller.comingFrom.value = value;
                        },
                      ),
                      dropDownTextField(
                        title: "To Meet",
                        key: _controller.meetKey,
                        list: _controller.meetNameList,
                        onChanged: (value) {
                          for (int i = 0;
                              i < _controller.toMeetList.length;
                              i++) {
                            if (_controller.toMeetList[i].staffName == value) {
                              _controller.meetID.value =
                                  _controller.toMeetList[i].id!;
                              break;
                            }
                          }
                        },
                      ),
                      textField(
                        title: "Relation With",
                        hintText: "Type Here",
                        onChanged: (value) {
                          _controller.relation.value = value;
                        },
                      ),
                      textField(
                        title: "Purpose",
                        hintText: "Type Here",
                        maxLine: 3,
                        onChanged: (value) {
                          _controller.purpose.value = value;
                        },
                      ),
                      textField(
                        title: "Visitor id Card No.",
                        hintText: "Type Here",
                        onChanged: (value) {
                          _controller.visitorIdCard.value = value;
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Visitor Photo",
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
                      ),
                      hSizeBox10,
                      dateTimeTextField(
                        title: "Meet Date",
                        date: _controller.selectedDate.value,
                        onTap: (value) {
                          _controller.selectedDate.value = value;
                        },
                        context: context,
                      ),
                      timeField(
                          context: context,
                          title: "Checkin Time",
                          time: _controller.time.value,
                          onTap: (value) {
                            _controller.time.value = value;
                            _controller.inTime.value =
                                '${_controller.time.value.hour}:${_controller.time.value.minute}';
                          }),
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

checkBox({
  String? text,
  bool? value,
  Function(bool?)? onTap,
}) =>
    Row(
      children: [
        SizedBox(
          height: 15,
          width: 15,
          child: Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            value: value,
            activeColor: Colors.green,
            onChanged: onTap,
          ),
        ),
        GestureDetector(
          child: Text(text ?? ""),
        )
      ],
    );
