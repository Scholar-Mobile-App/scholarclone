import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/admin/admin_outward_model.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import 'admin_inward_controller.dart';

class AdminInwardScreen extends StatelessWidget {
  AdminInwardScreen({super.key});
  final AdminInwardController _con = Get.put(AdminInwardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        "Inward",
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(
                  AppRoutes.addAdminInward,
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
            : _con.inwardList.isEmpty
                ? CU.getNodataDesign()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    itemCount: _con.inwardList.length,
                    separatorBuilder: (context, index) => hSizeBox16,
                    itemBuilder: (context, index) {
                      var inward = _con.inwardList[index];
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
                                    "${index + 1}. ${inward.placeId ?? ""}",
                                    style: const TextStyle(
                                      fontFamily: CS.josefinSans,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  "#${inward.outwardNumber ?? ""}",
                                  style: TextStyle(
                                    color: AppColor.purple,
                                    fontFamily: CS.josefinSans,
                                  ),
                                ),
                              ],
                            ),
                            hSizeBox4,
                            Text(
                              inward.fileName ?? "",
                              style: TextStyle(
                                fontFamily: CS.josefinSans,
                                fontSize: 12,
                                color: Colors.black.withOpacity(.6),
                              ),
                            ),
                            hSizeBox4,
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    inward.attachment ?? "",
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
                                        AppRoutes.addAdminInward,
                                        arguments: [
                                          _con.data,
                                          _con.userInfo,
                                          true,
                                          inward
                                        ],
                                      );
                                    },
                                    child: SvgPicture.asset(AppImage.edit)),
                                wSizeBox10,
                                GestureDetector(
                                    onTap: () => _con.callDeleteInWard(
                                        id: inward.id ?? 0, index: index),
                                    child: SvgPicture.asset(AppImage.delete)),
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
                                        "Subject",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        inward.title ?? "",
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
                                        "Description",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        inward.description ?? "",
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
                                        "File Location",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        inward.fileLocationId ?? "",
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
                                        "Inward Date",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        DateFormat("dd-MM-yyyy").format(
                                            inward.outwardDate ??
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
                                        "Academic Year",
                                        style: TextStyle(
                                          fontFamily: CS.josefinSans,
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.6),
                                        ),
                                      ),
                                      hSizeBox6,
                                      Text(
                                        inward.acedemicYear ?? "-",
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
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
