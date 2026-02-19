import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/reach_us/reach_us_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ReachUsScreen extends StatelessWidget {
  ReachUsScreen({super.key});

  final ReachUsController _controller = Get.put(ReachUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: appbar(_controller.data.subTitle ?? ""),
      body: Obx(
        () => _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.schoolInformationList.isEmpty
                ? CU.getNodataDesign()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: _controller.schoolInformationList.length,
                    itemBuilder: (context, index) {
                      var aboutUs = _controller.schoolInformationList[index];

                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  aboutUs.title!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: CU.secondaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                HtmlWidget(
                                  aboutUs.description!,
                                  onTapUrl: (url) async {
                                    log("url $url");
                                    final uri = Uri.parse(url);
                                    if (!await launchUrl(uri,
                                        mode: LaunchMode.externalApplication)) {
                                      throw 'Could not launch $url';
                                    }
                                    return true;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
