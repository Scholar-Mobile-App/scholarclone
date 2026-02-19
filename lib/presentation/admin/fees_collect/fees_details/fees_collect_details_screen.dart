import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

import 'fees_collect_details_controller.dart';

class FeesCollectDetailsScreen extends StatelessWidget {
  FeesCollectDetailsScreen({super.key});
  final FeesCollectDetailsController _con =
      Get.put(FeesCollectDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Fees Collect"),
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
          Obx(
            () => _con.isLoading.value
                ? CU.getCircularProgressIndicator()
                : ListView(
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
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${_con.studentInfo.studentName}",
                                        style: TextStyle(
                                          color: CU.tprimaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "  ${_con.studentInfo.standardName}-${_con.studentInfo.divisionName}",
                                        style: TextStyle(
                                          color: CU.heliotropeColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  hSizeBox10,
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Roll No. ${_con.studentInfo.rollNo}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      wSizeBox20,
                                      Text(
                                        "GR No. ${_con.studentInfo.enrollmentNo}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  hSizeBox10,
                                  Text(
                                    "${_con.studentInfo.mobile}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              height: 1,
                              width: Get.width,
                              color: AppColor.textColorlight,
                            ),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: _con.studentFeesDetailModel!.data!
                                      .pending?.length ??
                                  0,
                              separatorBuilder: (context, index) => Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 12),
                                height: 1,
                                width: Get.width,
                                color: AppColor.textColorlight,
                              ),
                              itemBuilder: (context, index) {
                                var studentFeesDetail = _con
                                    .studentFeesDetailModel!
                                    .data!
                                    .pending![index];
                                return Row(
                                  children: [
                                    Obx(
                                      () => SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: Checkbox(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          value: (_con.checkData
                                                  .contains(studentFeesDetail))
                                              ? true
                                              : false,
                                          activeColor: Colors.green,
                                          onChanged: (_) {
                                            if (!_con.checkData
                                                .contains(studentFeesDetail)) {
                                              _con.checkData
                                                  .add(studentFeesDetail);
                                            } else {
                                              _con.checkData
                                                  .remove(studentFeesDetail);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    wSizeBox20,
                                    Expanded(
                                      child: Text(
                                        studentFeesDetail.month ?? "",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Rs ${studentFeesDetail.remain ?? 0}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                            hSizeBox30,
                            const Text(
                              "Total Amount",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(),
                              ),
                              child: Text(
                                "Rs ${_con.totalRemain}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            textFieldController(
                              _con.bankName.value,
                              hintText: "Bank Name",
                              title: "Bank Name",
                            ),
                            textFieldController(
                              _con.transactionID.value,
                              hintText: "Transaction ID",
                              title: "Transaction ID",
                            ),
                            const SizedBox(height: 30),
                            AppButton(
                              text: "Pay Now",
                              onTap: _con.checkData.isEmpty
                                  ? null
                                  : () {
                                      _con.callServicePayNow();
                                    },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
