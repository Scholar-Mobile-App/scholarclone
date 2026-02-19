import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/student/portfolio_model.dart';
import 'package:scholar_clone/presentation/students/test_qna/test_qna_controller.dart';

import '../../../core/utils/cs.dart';

class PortfolioController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxList<Portfolio> portfolioList = <Portfolio>[].obs;

  TabController? tabController;
  RxList<Tabbar> tabPages = <Tabbar>[].obs;

  Map<String, dynamic> resJson = {};

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    callServiceCircular();
    super.onInit();
  }

  Future<void> callServiceCircular() async {
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      CS.student_id: userInfo[CS.student_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.token: userInfo[CS.token],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: data.subTitleApi,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceCircular);
      return;
    }
    log("==============>resJson<====================");
    log("status====>${resJson[CS.status]}");
    log("resJson_data====>${resJson[CS.data]}");

    if (resJson[CS.status].toString() == StatusCode.Success) {
      PortfolioModel model = PortfolioModel.fromJson(resJson);

      portfolioList.value += model.data!;

      for (var e in model.data!) {
        tabPages.add(Tabbar(text: e.title));
      }

      tabController = TabController(vsync: this, length: tabPages.length);
    } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
        resJson[CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }

    isLoading.value = false;
  }
}


// import 'dart:developer';

// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
// import 'package:get/get.dart';
// import 'package:scholar_clone/core/utils/app_color.dart';
// import 'package:scholar_clone/core/utils/app_image.dart';
// import 'package:scholar_clone/core/utils/constant_sizebox.dart';
// import 'package:scholar_clone/core/utils/cu.dart';
// import 'package:scholar_clone/presentation/students/portfolio/portfolio_controller.dart';
// import 'package:scholar_clone/presentation/students/test_qna/test_qna_controller.dart';
// import 'package:scholar_clone/presentation/widgets/download_manager.dart';

// class PortfolioScreen extends StatelessWidget {
//   PortfolioScreen({super.key});
//   final PortfolioController _controller = Get.put(PortfolioController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             backgroundColor: AppColor.primaryColor,
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.vertical(
//                 bottom: Radius.circular(20),
//               ),
//             ),
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back, color: AppColor.secondaryColor),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             title: const Text(
//               "Portfolio",
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//           backgroundColor: _controller.isLoading.value
//               ? Colors.white
//               : AppColor.secondaryColor,
//           body: _controller.isLoading.value
//               ? const Center(child: CircularProgressIndicator.adaptive())
//               : Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: AppColor.secondaryColor,
//                           borderRadius: const BorderRadius.only(
//                               bottomRight: Radius.circular(20),
//                               bottomLeft: Radius.circular(20)),
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.black12,
//                               offset: Offset(0.0, 0.0),
//                               blurRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
//                         child: TabBar(
//                           controller: _controller.tabController,
//                           indicatorColor: AppColor.primaryColor,
//                           unselectedLabelColor: Colors.white,
//                           isScrollable: true,
//                           labelColor: AppColor.primaryColor,
//                           tabs: _controller.tabPages.map<Tab>((Tabbar page) {
//                             return Tab(
//                               child: SizedBox(
//                                 width: Get.width * 0.22,
//                                 child: Text(
//                                   page.text ?? "",
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       Expanded(
//                           child: TabBarView(
//                         controller: _controller.tabController,
//                         children:
//                             List.generate(_controller.tabPages.length, (index) {
//                           if (_controller.portfolioList
//                               .where((e) =>
//                                   e.title == _controller.tabPages[index].text)
//                               .toList()
//                               .isNotEmpty) {
//                             return ListView.separated(
//                               itemCount: _controller.portfolioList.length,
//                               separatorBuilder: (context, index) => hSizeBox10,
//                               itemBuilder: (context, index) {
//                                 var data = _controller.portfolioList[index];
//                                 return Card(
//                                   elevation: 4,
//                                   shape: const RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(10.0),
//                                     ),
//                                   ),
//                                   child: ExpandablePanel(
//                                     header: Padding(
//                                       padding: const EdgeInsets.all(12.0),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.access_time,
//                                                 color: AppColor.secondaryColor,
//                                                 size: 18,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 4.0),
//                                                 child: Text(
//                                                     "Date : ${data.createdAt}",
//                                                     maxLines: 1,
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: TextStyle(
//                                                         color:
//                                                             CU.secondaryColor)),
//                                               ),
//                                             ],
//                                           ),
//                                           Expanded(
//                                             child: Container(),
//                                           ),
//                                           if (!CU.isEmptyOrNull(data.fileName!))
//                                             GestureDetector(
//                                               onTap: () async {
//                                                 if (CU
//                                                     .isImage(data.fileName!)) {
//                                                   // Navigator.push(
//                                                   //     context,
//                                                   //     MaterialPageRoute(
//                                                   //       fullscreenDialog: true,
//                                                   //       builder: (context) =>
//                                                   //           FullScreenImage(
//                                                   //         arrItem: data,
//                                                   //         imagePath:
//                                                   //             data.fileName,
//                                                   //       ),
//                                                   //     ));

//                                                   log("heloo");
//                                                 } else {
//                                                   var documentPath =
//                                                       data.fileName;
//                                                   if (!CU.isEmptyOrNull(
//                                                       data.fileName!)) {
//                                                     downloadExport(
//                                                         context: context,
//                                                         fileUrl: documentPath!,
//                                                         filename: documentPath
//                                                             .split("/")
//                                                             .last);
//                                                   }
//                                                 }
//                                               },
//                                               child: Image.asset(
//                                                 AppImage.icnAttached,
//                                                 height: 16.0,
//                                                 width: 16.0,
//                                               ),
//                                             ),
//                                         ],
//                                       ),
//                                     ),
//                                     collapsed: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Divider(
//                                           height: 1,
//                                           color: Colors.grey,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(12.0),
//                                           child: Align(
//                                             alignment: Alignment.topLeft,
//                                             child: Text(
//                                               data.title ?? "",
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                   color: CU.secondaryColor),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 6.0,
//                                               left: 12,
//                                               right: 12,
//                                               bottom: 12),
//                                           child: Align(
//                                             alignment: Alignment.topLeft,
//                                             child: Linkify(
//                                                 onOpen: (link) =>
//                                                     {launchURL(link.url)},
//                                                 text: data.description ?? "",
//                                                 maxLines: 3,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: const TextStyle(
//                                                     fontSize: 12)),
//                                           ),
//                                         ),
//                                         ExpandableButton(
//                                           child: Container(
//                                             decoration: const BoxDecoration(
//                                               color: Colors.black12,
//                                               borderRadius: BorderRadius.only(
//                                                 bottomRight:
//                                                     Radius.circular(10.0),
//                                                 bottomLeft:
//                                                     Radius.circular(10.0),
//                                               ),
//                                             ),
//                                             alignment: Alignment.center,
//                                             child: const Icon(
//                                               Icons.keyboard_arrow_down,
//                                               size: 20,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     expanded: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         const Divider(
//                                           height: 1,
//                                           color: Colors.grey,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(12.0),
//                                           child: Align(
//                                             alignment: Alignment.topLeft,
//                                             child: Text(data.title ?? "",
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: TextStyle(
//                                                     color: CU.secondaryColor)),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 6.0,
//                                               left: 12,
//                                               right: 12,
//                                               bottom: 12),
//                                           child: Align(
//                                             alignment: Alignment.topLeft,
//                                             child: Linkify(
//                                               onOpen: (link) =>
//                                                   {launchURL(link.url)},
//                                               text: data.description ?? "",
//                                               style:
//                                                   const TextStyle(fontSize: 12),
//                                             ),
//                                           ),
//                                         ),
//                                         ExpandableButton(
//                                           child: Container(
//                                             decoration: const BoxDecoration(
//                                               color: Colors.black12,
//                                               borderRadius: BorderRadius.only(
//                                                 bottomRight:
//                                                     Radius.circular(10.0),
//                                                 bottomLeft:
//                                                     Radius.circular(10.0),
//                                               ),
//                                             ),
//                                             alignment: Alignment.center,
//                                             child: const Icon(
//                                               Icons.keyboard_arrow_up,
//                                               size: 20,
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     theme: const ExpandableThemeData(
//                                         hasIcon: false),
//                                   ),
//                                 );
//                               },
//                             );
//                           } else {
//                             return CU.getNodataDesign();
//                           }
//                         }),
//                       ))
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
