import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/teacher/teach_model.dart';
import 'package:scholar_clone/presentation/teacher/t_teach/t_teach_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class TeachScreen extends StatelessWidget {
  TeachScreen({super.key});
  final TeachController _controller = Get.put(TeachController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Subject"),
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
          Obx(
            () => _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : _controller.teachList.isEmpty
                    ? CU.getNodataDesign()
                    : Container(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomScrollView(
                          shrinkWrap: true,
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: _controller.teachList.length,
                                (BuildContext context, int index) {
                                  return getAssignmentRow(
                                    _controller.teachList[index],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget getAssignmentRow(Teach teachList) {
    return GestureDetector(
      onTap: () {
        var string = _controller.userInfo[CS.standard_division];
        var ans = string.split("||");

        Get.toNamed(
          AppRoutes.teachSubject,
          arguments: [
            _controller.data,
            _controller.userInfo,
            teachList,
            ans[0].trim(),
          ],
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Stack(
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.only(left: 15, top: 20, bottom: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                teachList.subName ?? "",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  AppImage.loginvector,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
