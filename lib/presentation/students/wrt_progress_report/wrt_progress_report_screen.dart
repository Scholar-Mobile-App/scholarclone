import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/wrt_progress_report/wrt_progress_report_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

import '../../widgets/app_text_field.dart';

class WRTProgressReportScreen extends StatelessWidget {
  WRTProgressReportScreen({super.key});

  final WRTProgressReportController _con =
      Get.put(WRTProgressReportController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(
          text: 'WRT Progress Reports',
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
            Column(
              children: [
                searchAndFilterBox(_con, context),
                Expanded(
                  child: _con.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : _con.wrtProgress == null
                          ? CU.getNodataDesign()
                          : Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    downloadExport(
                                      context: Get.context!,
                                      fileUrl: _con.wrtProgress!.fileName!,
                                      filename: CU.getFileNameOfURL(
                                          _con.wrtProgress!.fileName!),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, left: 15, right: 15),
                                    padding: const EdgeInsets.all(20),
                                    alignment: Alignment.center,
                                    height: Get.width * 0.25,
                                    width: Get.width,
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
                                    child: Text(
                                      _con.wrtProgress!.title ?? "",
                                      style: TextStyle(
                                        color: AppColor.tprimaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  searchAndFilterBox(WRTProgressReportController controller, context) =>
      Container(
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
            ]),
        child: Column(
          children: [
            dropDownTextField(
              title: "Select Exam Type",
              key: controller.examKey,
              list: controller.examName,
              onChanged: (value) {
                controller.selectExamName.value = value!;
                for (int i = 0; i < controller.examTypeList.length; i++) {
                  if (controller.examTypeList[i].examTitle == value) {
                    controller.examID.value = controller.examTypeList[i].id!;
                    break;
                  }
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: dateRangeTimeWRT(
                      context: Get.context!,
                      title: "From Date",
                      date: _con.fromDate.value.isEmpty
                          ? ""
                          : _con.fromDate.value,
                      onTap: (val) {
                        if (val != null) {
                          _con.fromDate.value = val.toString();
                        }
                      }),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: dateRangeTimeWRT(
                    context: Get.context!,
                    title: "To Date",
                    date: _con.toDate.value.isEmpty ? "" : _con.toDate.value,
                    onTap: (val) {
                      if (val != null) {
                        _con.toDate.value = val.toString();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            AppButton(
              text: "Search",
              onTap: () {
                _con.callService(context);
              },
            )
          ],
        ),
      );
}
