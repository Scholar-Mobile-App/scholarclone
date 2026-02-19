import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';

import 'package:scholar_clone/presentation/students/test_report/test_report_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

class TestReportScreen extends StatelessWidget {
  TestReportScreen({super.key});

  final TestReportController _controller = Get.put(TestReportController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          "Result Of Practice",
          rounded: false,
        ),
        body: _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.practiceList.isEmpty
                ? CU.getNodataDesign()
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          decoration: BoxDecoration(
                            color: CU.primaryColor,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(80)),
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
                      SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                marks(
                                  color: AppColor.greenColor,
                                  title: "TOTAL",
                                  data:
                                      "${_controller.data.totalRight! + _controller.data.totalWrong!}",
                                ),
                                marks(
                                  color: AppColor.secondaryColor,
                                  title: "RIGHT",
                                  data: _controller.data.totalRight.toString(),
                                ),
                                marks(
                                  color: AppColor.redColor,
                                  title: "WRONG",
                                  data: _controller.data.totalWrong.toString(),
                                ),
                              ],
                            ),
                            hSizeBox20,
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _controller.practiceList.length,
                              separatorBuilder: (context, index) => hSizeBox20,
                              itemBuilder: (context, i) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 26,
                                            width: 26,
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.only(
                                              right: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: CU.textColorlight,
                                                width: 2,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text(
                                              (i + 1).toString(),
                                              style: TextStyle(
                                                color: CU.secondaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: HtmlWidget(
                                              _controller
                                                      .practiceList[i].entries
                                                      .toList()[0]
                                                      .value["QUESTION_TEXT"] ??
                                                  "",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: Get.width,
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 6, 12, 6),
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 0),
                                        decoration: BoxDecoration(
                                          color: const Color(0x123f98d3),
                                          border: Border.all(
                                              color: CU.secondaryColor,
                                              width: 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                        child: HtmlWidget(
                                          _controller.practiceList[i].entries
                                                  .toList()[0]
                                                  .value["ACTUAL_ANSWER"] ??
                                              "",
                                        ),
                                      ),
                                      CU.isEmptyOrNull(
                                        _controller.practiceList[i].entries
                                                .toList()[0]
                                                .value["GIVEN_ANSWER"] ??
                                            "",
                                      )
                                          ? Container()
                                          : Container(
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      12, 6, 12, 6),
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 12, 0, 0),
                                              decoration: BoxDecoration(
                                                color: _controller
                                                            .practiceList[i]
                                                            .entries
                                                            .toList()[0]
                                                            .value[
                                                                "GIVEN_ANSWER"]
                                                            .toString() ==
                                                        _controller
                                                            .practiceList[i]
                                                            .entries
                                                            .toList()[0]
                                                            .value[
                                                                "ACTUAL_ANSWER"]
                                                            .toString()
                                                    ? const Color(0x128eba49)
                                                    : const Color(0x12e52726),
                                                border: Border.all(
                                                  color: _controller
                                                              .practiceList[i]
                                                              .entries
                                                              .toList()[0]
                                                              .value[
                                                                  "GIVEN_ANSWER"]
                                                              .toString() ==
                                                          _controller
                                                              .practiceList[i]
                                                              .entries
                                                              .toList()[0]
                                                              .value[
                                                                  "ACTUAL_ANSWER"]
                                                              .toString()
                                                      ? CU.greenColor
                                                      : CU.redColor,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                              ),
                                              child: HtmlWidget(
                                                _controller.practiceList[i]
                                                            .entries
                                                            .toList()[0]
                                                            .value[
                                                        "GIVEN_ANSWER"] ??
                                                    "",
                                              ),
                                            ),
                                      CU.isEmptyOrNull(
                                        _controller.practiceList[i].entries
                                                .toList()[0]
                                                .value["GIVEN_ANSWER"] ??
                                            "",
                                      )
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 12, 0, 0),
                                              child: Text(
                                                "You did not answer this question.",
                                                style: TextStyle(
                                                    color: CU.primaryColor,
                                                    fontSize: 12),
                                              ),
                                            )
                                          : Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 20, 8, 8),
                                                  child: Image.asset(
                                                    _controller.practiceList[i]
                                                                .entries
                                                                .toList()[0]
                                                                .value[
                                                                    "GIVEN_ANSWER"]
                                                                .toString() ==
                                                            _controller
                                                                .practiceList[i]
                                                                .entries
                                                                .toList()[0]
                                                                .value[
                                                                    "ACTUAL_ANSWER"]
                                                                .toString()
                                                        ? AppImage.right
                                                        : AppImage.worng,
                                                    height: 24,
                                                    width: 24,
                                                    color: _controller
                                                                .practiceList[i]
                                                                .entries
                                                                .toList()[0]
                                                                .value[
                                                                    "GIVEN_ANSWER"]
                                                                .toString() ==
                                                            _controller
                                                                .practiceList[i]
                                                                .entries
                                                                .toList()[0]
                                                                .value[
                                                                    "ACTUAL_ANSWER"]
                                                                .toString()
                                                        ? CU.greenColor
                                                        : CU.redColor,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 12, 0, 0),
                                                    child: Text(
                                                      _controller
                                                                  .practiceList[
                                                                      i]
                                                                  .entries
                                                                  .toList()[0]
                                                                  .value[
                                                                      "GIVEN_ANSWER"]
                                                                  .toString() ==
                                                              _controller
                                                                  .practiceList[
                                                                      i]
                                                                  .entries
                                                                  .toList()[0]
                                                                  .value[
                                                                      "ACTUAL_ANSWER"]
                                                                  .toString()
                                                          ? "Chosen as Right Answer"
                                                          : "Chosen as Wrong Answer",
                                                      style: TextStyle(
                                                        color: _controller
                                                                    .practiceList[
                                                                        i]
                                                                    .entries
                                                                    .toList()[0]
                                                                    .value[
                                                                        "GIVEN_ANSWER"]
                                                                    .toString() ==
                                                                _controller
                                                                    .practiceList[
                                                                        i]
                                                                    .entries
                                                                    .toList()[0]
                                                                    .value[
                                                                        "ACTUAL_ANSWER"]
                                                                    .toString()
                                                            ? CU.greenColor
                                                            : CU.redColor,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
      ),
    );
  }

  Column marks({
    required Color color,
    required String title,
    required String data,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 4),
                  shape: BoxShape.circle,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Text(
                    data,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        hSizeBox6,
        Text(
          "MARKS",
          style: TextStyle(
              fontSize: 12,
              color: CU.textColorDark,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
