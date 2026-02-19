import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/my_separator.dart';

import 'test_qna_controller.dart';

class TestQnAScreen extends StatelessWidget {
  TestQnAScreen({super.key});

  final TestQnAController _controller = Get.put(TestQnAController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: const Color(0xFFf4f5f7),
        appBar: appbar(
          "Q & A",
          rounded: false,
          actions: [
            if (_controller.resJson != null && _controller.start.value > 0)
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: [5, 3, 1, 0].contains(_controller.start.value)
                      ? Colors.red
                      : Colors.blue,
                ),
                child: Row(
                  children: [
                    Text(
                      "${Duration(seconds: _controller.start.value).inMinutes.toString().padLeft(2, '0')}:${(_controller.start.value % 60).toString().padLeft(2, "0")}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.timer,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
          ],
        ),
        body: _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.allqnaPages.isEmpty
                ? CU.getNodataDesign()
                : SizedBox(
                    height: Get.height,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            decoration: BoxDecoration(
                              color: CU.primaryColor,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(80)),
                            ),
                          ),
                        ),
                        _controller.resJson == null
                            ? Align(
                                alignment: Alignment.center,
                                child: CU.getCircularProgressIndicator(),
                              )
                            : Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(top: 12, right: 12),
                                  width: double.infinity,
                                  child: Obx(
                                    () => TabBar(
                                        isScrollable: true,
                                        controller: _controller.tabController,
                                        indicatorColor: CU.primaryColor,
                                        indicatorWeight: 1,
                                        labelPadding:
                                            const EdgeInsets.only(bottom: 8),
                                        unselectedLabelColor: CU.textColorhint,
                                        labelColor: CU.secondaryColor,
                                        labelStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                        tabs: List.generate(
                                          _controller.allqnaPages.length,
                                          (i) => Tab(
                                            child: InkWell(
                                              onTap: () {
                                                _controller
                                                    .tabController!.index = i;
                                              },
                                              child: Container(
                                                height: 45,
                                                width: 45,
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(
                                                    left: 16),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: _controller
                                                              .tabIndex.value ==
                                                          i
                                                      ? CU.secondaryColor
                                                      : null,
                                                ),
                                                child: Text(
                                                  _controller
                                                      .allqnaPages[i].text!,
                                                  style: TextStyle(
                                                    color: _controller.tabIndex
                                                                .value ==
                                                            i
                                                        ? CU.primaryColor
                                                        : CU.textColorDark,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _controller.tabController,
                            children: _controller.allqnaPages
                                .map<Widget>((Tabbar page) {
                              return quetionTab(page.data, page.ansData);
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  quetionTab(data, ansData) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 0,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      HtmlWidget(data["question_title"]),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
                        child: MySeparator(
                          color: CU.textColorlight,
                        ),
                      ),
                      if (data["Answer"] != null)
                        for (int i = 0; i < data["Answer"].length; i++)
                          InkWell(
                            onTap: () {
//
                              ansData.answerid =
                                  data["Answer"][i]["id"].toString();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: ansData.answerid ==
                                        data["Answer"][i]["id"].toString()
                                    ? CU.secondaryColor
                                    : Colors.transparent,
                                border: Border.all(
                                  color: CU.textColorlight,
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              margin: const EdgeInsets.only(top: 14),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: HtmlWidget(
                                      data["Answer"][i]["answer"],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: ansData.answerid ==
                                              data["Answer"][i]["id"].toString()
                                          ? CU.primaryColor
                                          : Colors.transparent,
                                      border: Border.all(
                                          width: 2, color: CU.textColorlight),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(40)),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      size: 20,
                                      color: ansData.answerid ==
                                              data["Answer"][i]["id"].toString()
                                          ? CU.secondaryColor
                                          : Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(right: 26, top: 20),
                    child: Image.asset(
                      AppImage.q,
                      height: 40,
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: (_controller.tabController!.index !=
                _controller.tabController!.length - 1),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () {
                  if (_controller.tabController!.index !=
                      _controller.tabController!.length - 1) {
                    _controller.tabController!.index =
                        _controller.tabController!.index + 1;
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Skip",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CU.textColorlight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: (_controller.tabController!.index !=
                            _controller.tabController!.length - 1)
                        ? 0
                        : 16,
                    bottom: 20),
                width: 200,
                child: Material(
                  color: CU.secondaryColor,
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(50),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () {
                      if (_controller.tabController!.index !=
                          _controller.tabController!.length - 1) {
                        _controller.tabController!.index =
                            _controller.tabController!.index + 1;
                      } else {
                        _controller.callSubmitService();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 28),
                      child: Text(
                        (_controller.tabController!.index !=
                                _controller.tabController!.length - 1)
                            ? 'Next'
                            : 'Submit',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
