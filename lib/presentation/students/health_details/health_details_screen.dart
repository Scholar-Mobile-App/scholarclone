import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/health_details/health_details_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

class HealthDetailsScreen extends StatelessWidget {
  HealthDetailsScreen({super.key});

  final HealthDetailsController _controller =
      Get.put(HealthDetailsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          _controller.data.subTitle ?? "",
        ),
        body: _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.healthList.isEmpty
                ? CU.getNodataDesign()
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    physics: const ClampingScrollPhysics(),
                    itemCount: _controller.healthList.length,
                    separatorBuilder: (context, index) => hSizeBox10,
                    itemBuilder: (context, index) {
                      var data = _controller.healthList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.all(16).copyWith(bottom: 6),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: CU.loadImage(
                                            url: data.file,
                                            height: 44.0,
                                            width: 44.0,
                                            isShowLoader: false,
                                          ),
                                        ),
                                      ),
                                      wSizeBox16,
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  data.doctorName!,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 1,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "Date :${data.date}",
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          hSizeBox4,
                                          Text(
                                            "Mo : ${data.doctorContact}",
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                          ),
                                          if ((data.remarks ?? "").isNotEmpty)
                                            Text(
                                              "Remarks : ${data.remarks ?? ""}",
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                            )
                                        ],
                                      )),
                                    ],
                                  ),
                                  if ((data.file ?? "").isNotEmpty)
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton.icon(
                                        onPressed: () {
                                          downloadExport(
                                            context: context,
                                            fileUrl: data.file ?? "",
                                            filename: data.file ?? "",
                                            open: true,
                                          );
                                        },
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            visualDensity: const VisualDensity(
                                                horizontal: -4, vertical: -4)),
                                        icon: Image.asset(
                                          AppImage.attached,
                                          height: 12.0,
                                          width: 12.0,
                                          color: Colors.blue,
                                        ),
                                        label: const Text(
                                          "Attachment",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Positioned.fill(
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
