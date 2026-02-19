import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';
import 'package:scholar_clone/presentation/students/students_notification_hub/students_notification_hub_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

class StudentNotificationHubScreen extends StatelessWidget {
  StudentNotificationHubScreen({super.key});

  final StudentNotificationHubController _controller =
      Get.put(StudentNotificationHubController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: appbar(
        _controller.data.subTitle!,
        titleWidget: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 12),
              child: Text(
                "Notification",
                style: TextStyle(color: AppColor.textColorDark),
              ),
            ),
            // if (unReadCount != null && unReadCount != 0)
            if (LocalStorage.notificationCount.value != 0)
              Container(
                alignment: Alignment.center,
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColor.redColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  LocalStorage.notificationCount.value.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        actions: [Container(width: 30)],
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.notificationList.isEmpty
                ? CU.getNodataDesign()
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _controller.notificationList.length,
                    separatorBuilder: (context, index) => hSizeBox10,
                    itemBuilder: (context, index) {
                      var data = _controller.notificationList[index];

                      return Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 12, right: 12, bottom: 12),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CU.loadImage(
                                        url: data.image,
                                        height: 50,
                                        width: 50,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4),
                                                child: Text(
                                                  data.notificationType ?? "",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: Linkify(
                                                    onOpen: (link) {
                                                      launchURL(link.url);
                                                    },
                                                    text:
                                                        data.notificationDescription ??
                                                            "",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            CU.textColorDark)),
                                              ),
                                              Container(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.access_time,
                                                      color: CU.textColorlight,
                                                      size: 16,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          _controller.getAgo(
                                                            data.notificationDate ??
                                                                "",
                                                          ),
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: CU
                                                                .textColorlight,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                alignment: Alignment.topRight,
                                child: CU.loadImage(
                                  height: 55,
                                  width: 55,
                                  url: data.sideImage,
                                  bgcolor: Colors.transparent,
                                  errorIcon: AppImage.assignmentbg,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
