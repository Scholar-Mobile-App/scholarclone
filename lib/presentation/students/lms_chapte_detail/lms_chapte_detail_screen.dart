import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/lms_chapte_detail/lms_chapte_detail_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import '../../../core/utils/cs.dart';

class LMSChapteDetailScreen extends StatelessWidget {
  LMSChapteDetailScreen({super.key});
  final LMSChapteDetailController _controller =
      Get.put(LMSChapteDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("", rounded: false),
      backgroundColor: const Color(0xFFf4f5f7),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        "Chapter "
                        " : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColor.secondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                        child: Text(
                          _controller.data.chapterName ?? "",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.textColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                hSizeBox24,
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 12, 4),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Image.asset(
                                        AppImage.learningoutcome,
                                        height: 30,
                                        width: 30,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _controller
                                                .data.topicData![index].name ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              getModuleCell(
                                  _controller
                                      .data.topicData![index].contentData,
                                  false)
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => hSizeBox10,
                    itemCount: _controller.data.topicData!.length,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  getModuleCell(data, isLast) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          for (int i = 0; i < data.length; i++)
            InkWell(
              onTap: () async {
                log(data[i]["full_path"]);
                log(data[i]["title"]);
                Map<String, dynamic> file = <String, dynamic>{
                  CS.title: data[i]["title"] ?? "",
                  CS.url: data[i]["full_path"],
                };

                if (data[i]["file_type"] == "pdf") {
                  downloadExport(
                    context: Get.context!,
                    fileUrl: data[i]["full_path"],
                    filename: CU.getFileNameOfURL(data[i]["full_path"]),
                  );
                  // MainScreenState.onSelectRedirectScreen(
                  //     context: context, screen: 7, data: file);
                } else if (data[i]["file_type"] == "jpg") {
                  downloadExport(
                    context: Get.context!,
                    fileUrl: data[i]["full_path"],
                    filename: CU.getFileNameOfURL(data[i]["full_path"]),
                  );
                } else if (data[i]["file_type"] == "link") {
                  if (data[i]["full_path"].toString().contains("youtu.be") ||
                      data[i]["full_path"]
                          .toString()
                          .contains("www.youtube.com")) {
                    launchURL(data[i]["file_type"]);

                    // Get.toNamed(
                    //   AppRoutes.youtubeVideoPlayer,
                    //   // arguments: file,
                    // );
                    //14
                  } else {
                    log(data[i]["full_path"]);

                    Get.toNamed(
                      AppRoutes.webView,
                      arguments: file,
                    );
                    //123
                  }
                } else {
                  Get.toNamed(
                    AppRoutes.videoPlayer,
                    arguments: file,
                  );
                  //8
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (data[i]["file_type"] == "pdf") ...[
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://202.47.117.131/ssalms/theme/image.php/classic/core/1633339054/f/pdf-24",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              AppImage.logo,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ] else if (data[i]["file_type"] == "jpg") ...[
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://202.47.117.131/ssalms/theme/image.php/classic/core/1633339054/f/image-24",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              AppImage.logo,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ] else if (data[i]["file_type"] == "link") ...[
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://202.47.117.131/ssalms/theme/image.php/classic/core/1633339054/f/mpeg-24",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              AppImage.logo,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ] else ...[
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://202.47.117.131/ssalms/theme/image.php/classic/core/1633339054/f/mpeg-24",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              AppImage.logo,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ],
                    wSizeBox10,
                    Flexible(
                      child: Text(
                        data[i]["title"] ?? "",
                        style: TextStyle(
                            fontSize: 13,
                            color: CU.textColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
