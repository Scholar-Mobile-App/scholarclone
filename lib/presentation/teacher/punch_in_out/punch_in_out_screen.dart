import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/teacher/punch_in_out/a.dart';
import 'package:scholar_clone/presentation/teacher/punch_in_out/punch_in_out_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

class PunchInOutScreen extends StatelessWidget {
  PunchInOutScreen({super.key});
  final PunchInOutController _con = Get.put(PunchInOutController());

  @override
  Widget build(BuildContext context) {
    log(DateTime.now().toString());
    return Scaffold(
      appBar: teacherAppBar(text: "Punch In-Out"),
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
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        // height: Get.width,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .25),
                              blurRadius: 2,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Obx(
                              () => Text(
                                _con.currentTime.value,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.greenColor,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat("dd/MM/yyyy").format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                height: 300,
                                width: 300,
                                child: RippleButtonDemo(
                                  title: _con.punchInOutInfoModel.value
                                              .buttonDisable ??
                                          false
                                      ? "${_con.punchInOutInfoModel.value.hrmsAttendance?.timestampDiff ?? "-"}\nTotal Hours"
                                      : _con.punchInOutInfoModel.value.button ==
                                              "out"
                                          ? "Check Out"
                                          : "Check In",
                                  onTap: (_con.punchInOutInfoModel.value
                                              .buttonDisable ??
                                          false)
                                      ? null
                                      : () => _con.determinePosition(),
                                ),
                              ),
                            ),
                            if (kDebugMode) Text(_con.currentAddress.value),
                          ],
                        ),
                      ),
                      hSizeBox20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(AppImage.checkInn),
                              hSizeBox4,
                              Text(
                                "${_con.punchInOutInfoModel.value.hrmsAttendance?.punchinTime == null ? "-" : DateFormat('hh:mm a').format(_con.punchInOutInfoModel.value.hrmsAttendance?.punchinTime ?? DateTime.now())}\ncheck-in",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset(AppImage.checkOut),
                              hSizeBox4,
                              Text(
                                "${_con.punchInOutInfoModel.value.hrmsAttendance?.punchoutTime == null ? "-" : DateFormat('hh:mm a').format(_con.punchInOutInfoModel.value.hrmsAttendance?.punchoutTime ?? DateTime.now())}\ncheck-out",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset(AppImage.totalTime),
                              hSizeBox4,
                              Text(
                                "${_con.punchInOutInfoModel.value.hrmsAttendance?.timestampDiff ?? "-"}\nTotal Hours",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
          ),
          Obx(
            () => Visibility(
              visible: _con.isPunchLoading.value,
              child: Container(
                height: Get.height,
                width: Get.width,
                color: Colors.black.withValues(alpha: .2),
                child:
                    const Center(child: CircularProgressIndicator.adaptive()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
