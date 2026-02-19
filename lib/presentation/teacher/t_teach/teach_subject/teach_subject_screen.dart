import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/teacher/t_teach/teach_subject/teach_subject_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class TeachSubjectScreen extends StatelessWidget {
  TeachSubjectScreen({super.key});
  final TeachSubjectController _controller = Get.put(TeachSubjectController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: _controller.teachData.subName!),
        body: Stack(
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
            _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : _controller.teachSubjectModel == null
                    ? CU.getNodataDesign()
                    : Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount:
                                  _controller.teachSubjectModel!.data!.length,
                              separatorBuilder: (context, index) =>
                                  Divider(color: AppColor.textColorlight),
                              itemBuilder: (context, index) {
                                var data = _controller
                                    .teachSubjectModel!.data!.entries
                                    .elementAt(index)
                                    .value;
                                return InkWell(
                                  onTap: () {
                                    if (data.topicData != null &&
                                        data.topicData!.isNotEmpty) {
                                      Get.toNamed(
                                        AppRoutes.tLMSChapteDetail,
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
                        ],
                      )
          ],
        ),
      ),
    );
  }
}
