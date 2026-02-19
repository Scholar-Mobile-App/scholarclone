import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

import 't_proxy_management_controller.dart';

class TProxyManagementScreen extends StatelessWidget {
  TProxyManagementScreen({super.key});
  final TProxyManagementController _controller =
      Get.put(TProxyManagementController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Proxy Management"),
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
            Column(
              children: [
                searchAndFilterBox(),
                hSizeBox10,
                _controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : _controller.proxyList.isEmpty
                        ? CU.getNodataDesign()
                        : Expanded(
                            child: ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              itemCount: _controller.proxyList.length,
                              separatorBuilder: (context, index) => hSizeBox16,
                              itemBuilder: (context, index) {
                                var proxy = _controller.proxyList[index];

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
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              proxy.subName ?? "",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            DateFormat('dd MMMM yyyy').format(
                                              DateTime.parse(
                                                proxy.proxyDate.toString(),
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: CU.textColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      hSizeBox8,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Teacher: ${proxy.teacherName}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Proxy Teacher: ${proxy.proxyTeacherName}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      hSizeBox8,
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Period: ${proxy.periodName}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Class: ${proxy.standardName} - ${proxy.divisionName}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
              ],
            ),
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
                date: _controller.fromDate,
                onTap: (value) {
                  _controller.fromDate = value;
                  _controller.callService();
                }),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: dateRangeTimeTextField(
              title: "To Date",
              date: _controller.toDate,
              onTap: (value) {
                _controller.toDate = value;
                _controller.callService();
              },
              context: Get.context!,
            ),
          ),
        ]),
      );
}
