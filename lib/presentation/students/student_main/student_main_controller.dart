import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentMainController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // ZoomDrawerController drawerController = ZoomDrawerController();
  // GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> bottomKey = GlobalKey();

  RxInt bottomCurrentPage = 0.obs;

  RxList<Widget> drawerOptions = <Widget>[].obs;

  dynamic data = Get.arguments[0] ?? 0;
  dynamic homeData = Get.arguments[1];
}
