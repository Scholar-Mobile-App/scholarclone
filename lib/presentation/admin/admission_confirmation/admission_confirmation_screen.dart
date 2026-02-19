import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/model/admin/admin_outward_model.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import '../../../core/utils/constant_sizebox.dart';
import 'admission_confirmation_controller.dart';

import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';

class AdmissionConfirmationScreen extends StatelessWidget {
  AdmissionConfirmationScreen({super.key});
  final AdmissionConfirmationController _con =
      Get.put(AdmissionConfirmationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        "Admission Confirmation",
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(
                  AppRoutes.createAdmissionConfirmation,
                  arguments: [_con.data, _con.userInfo, false, Outward()],
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xff5C4AC7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          wSizeBox20,
        ],
      ),
      body: Obx(
        () => _con.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _con.admissionConfirmationList.isEmpty
                ? CU.getNodataDesign()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    itemCount: _con.admissionConfirmationList.length,
                    separatorBuilder: (context, index) => hSizeBox16,
                    itemBuilder: (context, index) {
                      var admissionConfirmation =
                          _con.admissionConfirmationList[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 1),
                              blurRadius: 6,
                              color: const Color(0xff003B95).withOpacity(.1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${index + 1}. ${admissionConfirmation.firstName ?? ""} ${admissionConfirmation.middleName ?? ""} ${admissionConfirmation.lastName ?? ""}",
                                    style: const TextStyle(
                                      fontFamily: CS.josefinSans,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  "#${admissionConfirmation.enquiryNo ?? ""}",
                                  style: TextStyle(
                                    color: AppColor.purple,
                                    fontFamily: CS.josefinSans,
                                  ),
                                ),
                              ],
                            ),
                            hSizeBox4,
                            Text(
                              admissionConfirmation.mobile ?? "",
                              style: const TextStyle(
                                fontFamily: CS.josefinSans,
                                fontSize: 12,
                                color: Color(0xff3A9AD6),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    admissionConfirmation.email ?? "",
                                    style: const TextStyle(
                                      fontFamily: CS.josefinSans,
                                      fontSize: 14,
                                      color: Color(0xff3A9AD6),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes.createAdmissionConfirmation,
                                      arguments: [
                                        _con.data,
                                        _con.userInfo,
                                        true,
                                        admissionConfirmation
                                      ],
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    AppImage.edit,
                                    height: 16,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 1,
                              color: Colors.black.withOpacity(.2),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Inquiry",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        DateFormat("dd-MM-yyyy").format(
                                            admissionConfirmation.createdOn ??
                                                DateTime.now()),
                                        style: const TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                wSizeBox10,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Followup",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        DateFormat("dd-MM-yyyy").format(
                                            admissionConfirmation.createdOn ??
                                                DateTime.now()),
                                        style: const TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                wSizeBox10,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "DOB",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        DateFormat("dd-MM-yyyy").format(
                                            admissionConfirmation.dateOfBirth ??
                                                DateTime.now()),
                                        style: const TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            hSizeBox14,
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Age",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        "${admissionConfirmation.age} Years",
                                        style: const TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                wSizeBox10,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Previous School",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        admissionConfirmation
                                                .previousSchoolName ??
                                            "",
                                        style: const TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                wSizeBox10,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Previous Standard",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        admissionConfirmation
                                                .previousStandard ??
                                            "",
                                        style: const TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            hSizeBox14,
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Admission Standard",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        admissionConfirmation
                                                .admissionStandard ??
                                            "",
                                        style: const TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                wSizeBox10,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Remarks",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        admissionConfirmation.remarks ?? "",
                                        style: const TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(child: SizedBox())
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
