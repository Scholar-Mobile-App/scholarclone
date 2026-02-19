import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import 'lms_subject_controller.dart';

class LMSSubjectScreen extends StatelessWidget {
  LMSSubjectScreen({super.key});
  final LMSSubjectController _controller = Get.put(LMSSubjectController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(
          "${_controller.data.displayName}- ${_controller.userInfo["std_name"]}",
          bottom: TabBar(
            controller: _controller.tabController,
            isScrollable: true,
            indicatorColor: AppColor.secondaryColor,
            indicatorWeight: 2,
            unselectedLabelColor: AppColor.textColor,
            labelColor: AppColor.secondaryColor,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            tabs: List.generate(_controller.allPages.length, (index) {
              return Tab(
                text: _controller.allPages[index].toString(),
              );
            }),
          ),
          rounded: false,
        ),
        body: Stack(
          fit: StackFit.expand,
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
              () => TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller.tabController,
                children: [
                  _controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: _controller
                                    .lmsSubjectLearnModel!.data!.length,
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
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 8, 16, 8),
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
                  _controller.isTestLoading.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : _controller.lmsSubjectTestModel == null ||
                              _controller.lmsSubjectTestModel!.data!.isEmpty
                          ? Align(
                              alignment: Alignment.center,
                              child: CU.getNodataDesign(),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 20),
                              itemCount:
                                  _controller.lmsSubjectTestModel!.data!.length,
                              separatorBuilder: (context, index) => hSizeBox16,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    _controller.selectIndex.value = index;

                                    Get.toNamed(
                                      AppRoutes.testQnA,
                                      arguments: [
                                        _controller.lmsSubjectTestModel!.data![
                                            _controller.selectIndex.value],
                                        _controller.userInfo,
                                      ],
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    padding: const EdgeInsets.all(16),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 5,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _controller.lmsSubjectTestModel!
                                                .data![index].paperName!,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: AppColor.textColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 42,
                                          width: 42,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColor.secondaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(40)),
                                          ),
                                          child: Text(
                                            _controller.lmsSubjectTestModel!
                                                .data![index].totalQues
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                  _controller.isTestLoading.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : _controller.lmsSubjectTestModel == null ||
                              _controller.lmsSubjectTestModel!.data!.isEmpty
                          ? Align(
                              alignment: Alignment.center,
                              child: CU.getNodataDesign(),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 20),
                              itemCount:
                                  _controller.lmsSubjectTestModel!.data!.length,
                              separatorBuilder: (context, index) => hSizeBox16,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    _controller.selectIndex.value = index;

                                    Get.toNamed(
                                      AppRoutes.testReportList,
                                      arguments: [
                                        _controller.lmsSubjectTestModel!.data![
                                            _controller.selectIndex.value],
                                        _controller.userInfo,
                                      ],
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    padding: const EdgeInsets.all(16),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 5,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _controller.lmsSubjectTestModel!
                                                .data![index].paperName!,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: AppColor.textColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 42,
                                          width: 42,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColor.secondaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(40)),
                                          ),
                                          child: Text(
                                            _controller.lmsSubjectTestModel!
                                                .data![index].totalQues
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ],
              ),
            ),
          ],
        ));
  }

  ListView testReport({
    required String navigation,
    dynamic arguments,
  }) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20),
      itemCount: _controller.lmsSubjectTestModel!.data!.length,
      separatorBuilder: (context, index) => hSizeBox16,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            _controller.selectIndex.value = index;

            Get.toNamed(navigation, arguments: arguments);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 5,
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _controller.lmsSubjectTestModel!.data![index].paperName!,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColor.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 42,
                  width: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Text(
                    _controller.lmsSubjectTestModel!.data![index].totalQues
                        .toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
