import 'dart:developer';

// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/circular_events/circular_events_controller.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

class CircularEventsScreen extends StatelessWidget {
  CircularEventsScreen({super.key});
  final CircularEventsController _controller =
      Get.put(CircularEventsController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.secondaryColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: const Text(
            "Circular & Event",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(color: AppColor.secondaryColor),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
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
                  labelColor: AppColor.primaryColor,
                  tabs: List.generate(_controller.tabPages.length, (index) {
                    return Tab(
                      text: _controller.tabPages[index].toString(),
                    );
                  }),
                ),
              ),
              Expanded(
                child: Obx(
                  () => TabBarView(
                    controller: _controller.tabController,
                    children: [
                      _controller.isCircularLoading.value
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : _controller.clist.isEmpty
                              ? CU.getNodataDesign()
                              : circularAndEvents(_controller.clist),
                      _controller.isEventLoading.value
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : _controller.elist.isEmpty
                              ? CU.getNodataDesign()
                              : circularAndEvents(_controller.elist),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ListView circularAndEvents(List model) {
    return ListView.separated(
      itemCount: model.length,
      separatorBuilder: (context, index) => hSizeBox10,
      itemBuilder: (context, index) {
        var data = model[index];

        return Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            top: 12.0,
          ),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 4,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Container(
                  child: ExpandablePanel(
                    header: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: AppColor.secondaryColor,
                                size: 18,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text("Date : ${data.date}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppColor.secondaryColor)),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(),
                          ),

                          if (data.fileName != null)
                            GestureDetector(
                              onTap: () {
                                log(data.fileName.toString());

                                downloadExport(
                                  context: Get.context!,
                                  fileUrl: data.fileName.toString(),
                                  filename: "circular",
                                );
                              },
                              child: Image.asset(
                                AppImage.icnAttached,
                                height: 16.0,
                                width: 16.0,
                              ),
                            ),

                          //Icon(Icons.attachment,color: CU.secondaryColor,size: 18,),
                        ],
                      ),
                    ),
                    collapsed: Column(
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
                                 onOpen: (link) {
                                   CU.launchURL(link.url);
                                 },
                                 text: data.message ?? "",
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
                                 onOpen: (link) {
                                   CU.launchURL(link.url);
                                 },
                                 text: data.message ?? "",
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
                              Icons.keyboard_arrow_up,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    theme: const ExpandableThemeData(hasIcon: false),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
