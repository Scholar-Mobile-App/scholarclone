import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'achievement_controller.dart';

class AchievementScreen extends StatelessWidget {
  AchievementScreen({super.key});

  final AchievementController _controller = Get.put(AchievementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(_controller.data.subTitle ?? ""),
      body: Obx(
        () => _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.achievementList.isEmpty
                ? CU.getNodataDesign()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: _controller.achievementList.length,
                    itemBuilder: (context, index) {
                      var aboutUs = _controller.achievementList[index];

                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
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
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  color: Colors.white,
                                  child: HtmlWidget(
                                    aboutUs.description!,
                                    onTapUrl: (url) async {
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
