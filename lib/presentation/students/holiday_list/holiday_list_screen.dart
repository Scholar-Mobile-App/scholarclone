import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/holiday_list/holiday_list_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

class HolidayListScreen extends StatelessWidget {
  HolidayListScreen({super.key});
  final HolidayListController _controller = Get.put(HolidayListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          "Holiday List",
          rounded: false,
        ),
        body: Stack(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 5.0,
                  ),
                ],
              ),
            ),
            _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : _controller.holidayList.isEmpty
                    ? CU.getNodataDesign()
                    : ListView.separated(
                        itemCount: _controller.holidayList.length,
                        separatorBuilder: (context, index) => hSizeBox10,
                        itemBuilder: (context, index) {
                          var data = _controller.holidayList[index];
                          return Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(
                                bottom: 15, left: 15, right: 15),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.title ?? "",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          hSizeBox6,
                                          Text(
                                            data.description ?? "",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      data.schoolDate.toString().isNotEmpty
                                          ? DateFormat('dd MMMM yyyy')
                                              .format(data.schoolDate!)
                                          : "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.textColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
          ],
        ),
      ),
    );
  }
}
