import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

import 'homework_controller.dart';

class HomeworkScreen extends StatelessWidget {
  HomeworkScreen({super.key});
  final HomeworkController _controller = Get.put(HomeworkController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: appbar(_controller.data.subTitle!),
      body: Obx(
        () => _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.homeworkList.isEmpty
                ? CU.getNodataDesign()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    itemCount: _controller.homeworkList.length,
                    separatorBuilder: (context, index) => hSizeBox10,
                    itemBuilder: (context, index) {
                      var data = _controller.homeworkList[index];

                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CU.loadImage(
                                        url: data.userImage,
                                        height: 50,
                                        width: 50,
                                      ),
                                      wSizeBox8,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.title ?? "",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            hSizeBox4,
                                            Text(
                                              data.date ?? "",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: CU.textColorlight,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  hSizeBox10,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Linkify(
                                          onOpen: (link) {
                                            launchURL(link.url);
                                          },
                                          text: data.description ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 20,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: CU.textColorlight,
                                          ),
                                        ),
                                      ),
                                      if (!CU
                                          .isEmptyOrNull(data.fileName ?? ""))
                                        Transform.rotate(
                                          angle: 2.3,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.link,
                                              size: 25,
                                              color: CU.textColorlight,
                                            ),
                                            onPressed: () async {
                                              downloadExport(
                                                context: Get.context!,
                                                fileUrl: data.fileName!,
                                                filename: "homework",
                                              );
                                            },
                                          ),
                                        )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                                //                      left: 200,
                                child: Container(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                AppImage.assignmentbg,
                                width: 38,
                                height: 50,
                              ),
                            ))
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
