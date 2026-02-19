import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import 'chapter_controller.dart';

class ChapterScreen extends StatelessWidget {
  ChapterScreen({super.key});
  final ChapterController _controller = Get.put(ChapterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(
          "${_controller.data.displayName}- ${_controller.userInfo["std_name"]}",
          rounded: false,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius:
                      const BorderRadius.only(bottomRight: Radius.circular(80)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 5,
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () => _controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : _controller.lmsSubjectLearnModel == null ||
                          _controller.lmsSubjectLearnModel!.data!.isEmpty
                      ? Align(
                          alignment: Alignment.center,
                          child: CU.getNodataDesign(),
                        )
                      : Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount:
                                _controller.lmsSubjectLearnModel!.data!.length,
                            separatorBuilder: (context, index) =>
                                Divider(color: AppColor.textColorlight),
                            itemBuilder: (context, index) {
                              var data = _controller
                                  .lmsSubjectLearnModel!.data!.entries
                                  .elementAt(index)
                                  .value;
                              return InkWell(
                                onTap: () {
                                  if (data.topicData != null &&
                                      data.topicData!.isNotEmpty) {
                                    Get.toNamed(
                                      AppRoutes.lmsChapteDetail,
                                      arguments: data,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "No data Found.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                  child: Text(
                                    data.chapterName!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ));
  }
}
