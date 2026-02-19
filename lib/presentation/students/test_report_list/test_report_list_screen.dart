import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/test_report_list/test_report_list_controlller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class TestReportListScreen extends StatelessWidget {
  TestReportListScreen({super.key});

  final TestReportListController _controller =
      Get.put(TestReportListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          "Report",
          rounded: false,
        ),
        backgroundColor: const Color(0xFFf4f5f7),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: Get.height * 0.10,
                decoration: BoxDecoration(
                  color: CU.primaryColor,
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
            _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : _controller.reportList.isEmpty
                    ? CU.getNodataDesign()
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        physics: const ClampingScrollPhysics(),
                        itemCount: _controller.reportList.length,
                        separatorBuilder: (context, index) => hSizeBox20,
                        itemBuilder: (context, index) {
                          var data = _controller.reportList[index];
                          return InkWell(
                            onTap: () async {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ReportResultScreen(
                              //       assetsmentModel: list[i],
                              //     ),
                              //   ),
                              // );

                              Get.toNamed(
                                AppRoutes.testReport,
                                arguments: [
                                  data,
                                  _controller.userInfo,
                                ],
                              );
                            },
                            child: Container(
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
                              child: IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 16, 2, 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.paperName!,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: CU.secondaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            hSizeBox10,
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.access_time,
                                                  color: CU.textColorlight,
                                                  size: 22,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Text(
                                                    "At ${data.createdAt}",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: CU.textColorlight,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.access_time,
                                                  color: CU.textColorlight,
                                                  size: 22,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Text(
                                                    "Time  ${data.startTime}",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                            CU.textColorlight,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 110,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Color(0x188eba49),
                                        borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(20),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "${data.obtainMarks}/${data.totalWrong! + data.totalRight!}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: CU.greenColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          hSizeBox4,
                                          Text(
                                            "Total Mark",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: CU.textColorlight,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
          ],
        ),
      ),
    );
  }
}
