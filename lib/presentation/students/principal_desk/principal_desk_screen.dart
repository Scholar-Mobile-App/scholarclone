import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'principal_desk_controller.dart';

class PrincipalDeskScreen extends StatelessWidget {
  PrincipalDeskScreen({super.key});

  final PrincipalDeskController _controller =
      Get.put(PrincipalDeskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: appbar(_controller.data.subTitle!),
      body: Obx(
        () => _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.principalDeskList.isEmpty
                ? CU.getNodataDesign()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: _controller.principalDeskList.length,
                    itemBuilder: (context, index) {
                      var principalDeskdata =
                          _controller.principalDeskList[index];
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: CU.loadImage(
                                        url: "",
                                        errorIcon: AppImage.profile,
                                        height: 100.0,
                                        width: 100.0,
                                        bgcolor: Colors.transparent,
                                        isShowLoader: false,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Principal",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          maxLines: 1,
                                        ),
                                        Text(
                                          principalDeskdata.title ?? "",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: CU.secondaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  color: Colors.white,
                                  child: HtmlWidget(
                                    principalDeskdata.description ?? "",onTapUrl: (url) async {
                                    final uri = Uri.parse(url);
                                    if (!await launchUrl(uri,
                                        mode: LaunchMode.externalApplication)) {
                                      throw 'Could not launch $url';
                                    }
                                    return true;
                                  },
                                  ),
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
