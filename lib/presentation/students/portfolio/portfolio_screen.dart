import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/student/portfolio_model.dart';
import 'package:scholar_clone/presentation/students/portfolio/portfolio_controller.dart';
import 'package:scholar_clone/presentation/students/test_qna/test_qna_controller.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

class PortfolioScreen extends StatelessWidget {
  PortfolioScreen({super.key});
  final PortfolioController _controller = Get.put(PortfolioController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColor.primaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColor.secondaryColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              "Portfolio",
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: _controller.isLoading.value
              ? Colors.white
              : AppColor.secondaryColor,
          body: _controller.isLoading.value
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.secondaryColor,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: TabBar(
                          controller: _controller.tabController,
                          indicatorColor: AppColor.primaryColor,
                          unselectedLabelColor: Colors.white,
                          isScrollable: true,
                          labelColor: AppColor.primaryColor,
                          tabs: _controller.tabPages.map<Tab>((Tabbar page) {
                            return Tab(
                              child: SizedBox(
                                width: Get.width * 0.22,
                                child: Text(
                                  page.text ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                        controller: _controller.tabController,
                        children:
                            List.generate(_controller.tabPages.length, (index) {
                          if (_controller.portfolioList
                              .where((e) =>
                                  e.title == _controller.tabPages[index].text)
                              .toList()
                              .isNotEmpty) {
                            return rowCirculardemi(
                                _controller.tabPages[index].text ?? "");
                          } else {
                            return CU.getNodataDesign();
                          }
                        }),
                      ))
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget rowCirculardemi(String title) {
    return _controller.portfolioList.isEmpty
        ? CU.getCircularProgressIndicator()
        : _controller.portfolioList
                .where((element) => element.title == title)
                .toList()
                .isNotEmpty
            ? fillData(_controller.portfolioList
                .where((element) => element.title == title)
                .toList())
            : CU.getNodataDesign();
  }

  Widget fillData(List<Portfolio> title) {
    log(title.length.toString());
    return ListView.separated(
      itemCount: title.length,
      separatorBuilder: (context, index) => hSizeBox10,
      itemBuilder: (context, index) {
        var data = title[index];
        return Card(
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: AppColor.secondaryColor,
                        size: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text("Date : ${data.createdAt}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: CU.secondaryColor)),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  if (!CU.isEmptyOrNull(data.fileName!))
                    GestureDetector(
                      onTap: () async {
                        if (CU.isImage(data.fileName!)) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       fullscreenDialog: true,
                          //       builder: (context) =>
                          //           FullScreenImage(
                          //         arrItem: data,
                          //         imagePath:
                          //             data.fileName,
                          //       ),
                          //     ));

                          log("heloo");
                        } else {
                          var documentPath = data.fileName;
                          if (!CU.isEmptyOrNull(data.fileName!)) {
                            downloadExport(
                                context: context,
                                fileUrl: documentPath!,
                                filename: documentPath.split("/").last);
                          }
                        }
                      },
                      child: Image.asset(
                        AppImage.icnAttached,
                        height: 16.0,
                        width: 16.0,
                      ),
                    ),
                ],
              ),
            ),
            collapsed: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      data.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: CU.secondaryColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 6.0, left: 12, right: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Linkify(
                        onOpen: (link) => {launchURL(link.url)},
                        text: data.description ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12)),
                  ),
                ),
                ExpandableButton(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            expanded: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(data.title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: CU.secondaryColor)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 6.0, left: 12, right: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Linkify(
                      onOpen: (link) => {launchURL(link.url)},
                      text: data.description ?? "",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                ExpandableButton(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.keyboard_arrow_up,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
            theme: const ExpandableThemeData(hasIcon: false),
          ),
        );
      },
    );
  }
}
