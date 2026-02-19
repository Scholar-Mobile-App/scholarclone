import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';
import 'package:scholar_clone/presentation/teacher/send_notification/send_notification_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

class SendNotificationScreen extends StatelessWidget {
  SendNotificationScreen({super.key});

  final SendNotificationController _controller =
      Get.put(SendNotificationController());

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
                        studentselection(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                          child: Text(
                            "Enter Notification text",
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        addHomeWorkform(),
                        Center(
                          child: Obx(
                            () => AppButton(
                              loader: _controller.isAPIcalling.value,
                              text: "Send",
                              onTap: _controller.email.isEmpty ||
                                      _controller.message.value.isEmpty
                                  ? null
                                  : () {
                                      _controller.callServiceSendNoti();
                                    },
                            ),
                          ),
                        ),
                        hSizeBox20
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
                              _controller.studentList[i].id.toString())) {
                            _controller.checkData
                                .add(_controller.studentList[i].id.toString());
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
              Obx(
                () => SizedBox(
                  height: 15,
                  width: 15,
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    value: (_controller.checkData.contains(list.id.toString()))
                        ? true
                        : false,
                    activeColor: Colors.green,
                    onChanged: (_) {
                      _controller.selectAll.value = false;
                      if (!_controller.checkData.contains(list.id.toString())) {
                        _controller.checkData.add(list.id.toString());
                        _controller.email.add(list.id.toString());
                      } else {
                        _controller.checkData.remove(list.id.toString());
                        _controller.email.remove(list.id.toString());
                      }
                    },
                  ),
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
            title: "",
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
