import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

import 't_notification_report_controller.dart';

class TeacherNotificationReportScreen extends StatelessWidget {
  TeacherNotificationReportScreen({super.key});
  final TeacherNotificationReportController _controller =
      Get.put(TeacherNotificationReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Notification Report"),
      body: Obx(
        () => Stack(
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
            Column(
              children: [
                searchAndFilterBox(),
                hSizeBox20,
                Expanded(
                  child: _controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : _controller.notificationList.isEmpty
                          ? CU.getNodataDesign()
                          : ListView.separated(
                              padding: const EdgeInsets.all(20),
                              itemCount: _controller.notificationList.length,
                              separatorBuilder: (context, index) => hSizeBox10,
                              itemBuilder: (context, index) {
                                var notification =
                                    _controller.notificationList[index];
                                return Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: Colors.grey.shade100,
                                        spreadRadius: 1,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        notification.stuName ?? "",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${notification.stdName ?? ""} - ${notification.divName ?? ""}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            notification.notificationDate ?? "",
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      hSizeBox4,
                                      Text(
                                        notification.notificationType ?? "",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      hSizeBox4,
                                      Text(
                                        notification.notificationDescription ??
                                            "",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
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

  searchAndFilterBox() => Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.grey.shade100,
              spreadRadius: 1,
            )
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: dateRangeTimeTextField(
                context: Get.context!,
                title: "From Date",
                date: _controller.fromDate.value,
                onTap: (value) {
                  _controller.fromDate.value = value;
                  _controller.callService();
                }),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: dateRangeTimeTextField(
              title: "To Date",
              date: _controller.toDate.value,
              onTap: (value) {
                _controller.toDate.value = value;
                _controller.callService();
              },
              context: Get.context!,
            ),
          ),
        ]),
      );
}
