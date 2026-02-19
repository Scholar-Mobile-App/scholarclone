import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app_prefs.dart';

class LocalStorage {
  static String userId = "";
  static String deviceIP = "";
  static String token = "";
  static String userEmail = "";
  static String userName = "";
  static String? userProfile = "";
  static String deviceId = "";
  static String deviceFCMToken = "";
  static String deviceType = "";
  static bool isAdmin = false;
  static bool isLogin = false;
  static RxInt notificationCount = 0.obs;
  static dynamic userInfo;
  static dynamic teacherInfo;
  static dynamic adminInfo;
  static Map<String, dynamic> loginInfo = {};
  static String gcmToken = "";

  static String jsonData = LocalStorage.userInfo;
  static String jsonTeacherData = LocalStorage.teacherInfo;
  static String jsonAdminData = LocalStorage.adminInfo;

  static storeLoginInfo(json) async {
    final prefs = GetStorage();
    prefs.write(Prefs.LOGIN_INFO, json);
    loginInfo = prefs.read(Prefs.LOGIN_INFO);
    loadLocalData();
  }

  static List<Map<String, dynamic>> studentList =
      json.decode(jsonData).cast<Map<String, dynamic>>();
  static Map<String, dynamic> teacherModel = json.decode(jsonTeacherData);
  static Map<String, dynamic> adminModel = json.decode(jsonAdminData);

  static storeUserInfo(json) async {
    final prefs = GetStorage();
    prefs.write(Prefs.USER_INFO, json);
    userInfo = prefs.read(Prefs.USER_INFO);
    loadLocalData();
  }

  static storeTeacherInfo(json) async {
    final prefs = GetStorage();
    prefs.write(Prefs.TEACHER_INFO, json);
    teacherInfo = prefs.read(Prefs.TEACHER_INFO);
    loadLocalData();
  }

  static storeAdminInfo(json) async {
    final prefs = GetStorage();
    prefs.write(Prefs.ADMIN_INFO, json);
    adminInfo = prefs.read(Prefs.ADMIN_INFO);
    loadLocalData();
  }

  static void loadLocalData() async {
    final prefs = GetStorage();
    userInfo = prefs.read(Prefs.USER_INFO) ?? {};
    teacherInfo = prefs.read(Prefs.TEACHER_INFO) ?? {};
    loginInfo = prefs.read(Prefs.LOGIN_INFO) ?? {};
    adminInfo = prefs.read(Prefs.ADMIN_INFO) ?? {};
  }

  static void clearLocalData() {
    GetStorage().erase();
    loadLocalData();
  }
}
