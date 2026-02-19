import 'dart:convert';
import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

class TeacherMainController extends GetxController {
  @override
  void onInit() async {
    userInfo = LocalStorage.teacherModel;
    loadMenu();
    await callService();
    super.onInit();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, dynamic>? userInfo;
  Map<String, dynamic>? resJson;
  HomeDataModel? homeData;

  RxList<Widget> drawerOptions = <Widget>[].obs;

  RxBool isLoading = false.obs;

  RxInt typeIndex = 0.obs;
  RxInt screenIndex = 0.obs;
  RxInt selectedDrawerFragmentIndex = 1.obs;

  Future<void> loadMenu() async {
    // MainScreen.userInfo = await CU.getUserInfo();
    log("====================================2=========");
    log(userInfo.toString());
    log("====================================2=========");
    List<dynamic> menuList =
        jsonDecode(await rootBundle.loadString(AppImage.menuJson));
    selectedDrawerFragmentIndex.value = 1;
    drawerOptions.value = getMenuItems(menuList);
  }

  getMenuItems(menuList) {
    if (menuList == null) return [];
    List<dynamic> menu = menuList;
    List<Widget> drawerOptions = [];
    for (int i = 0; i < menu.length; i++) {
      drawerOptions.add(getMenuItem(menu[i], i));
    }
    return drawerOptions;
  }

  getMenuItem(menuItem, i) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Column(
          children: <Widget>[
            (menuItem[CS.subMenuList] == null ||
                    menuItem[CS.subMenuList].length == 0)
                ? Container(
                    padding: const EdgeInsets.fromLTRB(24, 16, 16, 12),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            menuItem[CS.menuName],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.fromLTRB(4, 4, 16, 0),
                    child: ExpandablePanel(
                      header: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              menuItem[CS.menuName],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      expanded: Column(
                        children: getMenuItems(menuItem[CS.subMenuList]),
                      ),
                      theme: const ExpandableThemeData(
                        tapHeaderToExpand: true,
                        hasIcon: true,
                        iconColor: Colors.white,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      ),
                      collapsed: const SizedBox(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      "user_profile_name": userInfo!["user_profile_name"].toString(),
      "user_profile_id": userInfo!["user_profile_id"].toString(),
      "sub_institute_id": userInfo!["sub_institute_id"].toString(),
      "token": userInfo!["token"].toString()
    };
    isLoading.value = true;
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: CS.teacherhomeScreen,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson![CS.status].toString() == StatusCode.Success) {
      HomeDataModel homeDataModel = HomeDataModel.fromJson(resJson!);
      homeData = homeDataModel;
      isLoading.value = false;
      // callGcmInsertService();
    } else if (resJson![CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson![CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isLoading.value = false;
    }
  }
}
