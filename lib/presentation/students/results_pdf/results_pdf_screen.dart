import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/results_pdf/results_pdf_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

class ResultsPDFScreen extends StatelessWidget {
  ResultsPDFScreen({super.key});
  final ResultsPDFController _controller = Get.put(ResultsPDFController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: appbar(
          _controller.content.subTitle.toString(),
          rounded: false,
          bottom: _controller.termData.isEmpty
              ? null
              : TabBar(
                  controller: _controller.controller,
                  isScrollable: true,
                  indicatorColor: AppColor.secondaryColor,
                  indicatorWeight: 2,
                  unselectedLabelColor: AppColor.textColor,
                  labelColor: AppColor.secondaryColor,
                  onTap: (index) {
                    _controller.resultList.clear();
                    _controller.callServiceTab(
                      _controller.userInfo["term_data"][index]["term_id"],
                    );

                    _controller.tabindex.value = index;
                  },
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                  tabs: _controller.allPages.map<Tab>((Tabs page) {
                    return Tab(text: page.text);
                  }).toList(),
                ),
        ),
        body: _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.resultList.isEmpty || _controller.termData.isEmpty
                ? CU.getNodataDesign()
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _controller.resultList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      _controller.userInfo['term_data']
                                                  [_controller.tabindex.value]
                                                  ['title']
                                              .split("-")[1] ??
                                          "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  wSizeBox10,
                                  Expanded(
                                      child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 0, top: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _controller.resultList[index].title ??
                                              "",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      alignment: Alignment.topLeft,
                                      child: Linkify(
                                        onOpen: (link) => {launchURL(link.url)},
                                        text: '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 20,
                                        style: TextStyle(
                                          color: CU.textColorlight,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (!CU.isEmptyOrNull(
                                      _controller.resultList[index].pdfLink ??
                                          ''))
                                    Transform.rotate(
                                      angle: 2.3,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.link,
                                          size: 25,
                                          color: CU.textColorlight,
                                        ),
                                        onPressed: () {
                                          downloadExport(
                                            context: Get.context!,
                                            fileUrl: _controller
                                                    .resultList[index]
                                                    .pdfLink ??
                                                "",
                                            filename: CU.getFileNameOfURL(
                                                _controller.resultList[index]
                                                        .pdfLink ??
                                                    ""),
                                            open: true,
                                          );
                                        },
                                      ),
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
