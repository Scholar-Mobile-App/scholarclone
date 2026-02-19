import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import 'circular_list_controller.dart';

class CircularListScreen extends StatelessWidget {
  CircularListScreen({super.key});
  final CircularListController _controller = Get.put(CircularListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(
        text: "Circular",
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.addCircular,
                  arguments: [_controller.data, _controller.userInfo],
                );
              },
              child: const Text(
                "Add",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          wSizeBox20,
        ],
      ),
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
                      : _controller.circularList.isEmpty
                          ? CU.getNodataDesign()
                          : ListView.separated(
                              padding: const EdgeInsets.all(20),
                              itemCount: _controller.circularList.length,
                              separatorBuilder: (context, index) => hSizeBox10,
                              itemBuilder: (context, index) {
                                var notification =
                                    _controller.circularList[index];
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
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${notification.stdName ?? ""} - ${notification.title ?? ""}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          if ((notification.fileName ?? "")
                                              .isNotEmpty)
                                            GestureDetector(
                                              onTap: () {
                                                downloadExport(
                                                  context: Get.context!,
                                                  fileUrl:
                                                      notification.fileName ??
                                                          "",
                                                  filename: "circular",
                                                );
                                              },
                                              child: Image.asset(
                                                AppImage.icnAttached,
                                                height: 16.0,
                                                width: 16.0,
                                              ),
                                            ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          notification.date ?? "",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Text(
                                        notification.message ?? "",
                                        style: const TextStyle(
                                          color: Colors.black,
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
        child: Column(
          children: [
            dropDownTextField(
              title: "Select Standard",
              list: _controller.stdName,
              onChanged: (value) {
                for (int i = 0; i < _controller.stdName.length; i++) {
                  if (_controller.standardModel!.data![i].stdName == value) {
                    _controller.stdId.value =
                        _controller.standardModel!.data![i].stdId!;
                    break;
                  }
                }
              },
            ),
            AppButton(
              text: "Search",
              onTap: _controller.stdId.value == 0
                  ? null
                  : () => _controller.callService(_controller.stdId.value),
            )
          ],
        ),
      );
}
