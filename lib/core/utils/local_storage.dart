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
  static dynamic userInfo = <dynamic>[];
  static dynamic teacherInfo = <String, dynamic>{};
  static dynamic adminInfo = <String, dynamic>{};
  static Map<String, dynamic> loginInfo = {};
  static String gcmToken = "";

  static Future<void> storeLoginInfo(json) async {
    final prefs = GetStorage();
    await prefs.write(Prefs.LOGIN_INFO, json);
    loginInfo = prefs.read(Prefs.LOGIN_INFO);
    loadLocalData();
  }

  static List<Map<String, dynamic>> studentList = [];
  static Map<String, dynamic> teacherModel = {};
  static Map<String, dynamic> adminModel = {};

  static Future<void> storeUserInfo(json) async {
    final prefs = GetStorage();
    await prefs.write(Prefs.USER_INFO, json);
    userInfo = prefs.read(Prefs.USER_INFO);
    loadLocalData();
  }

  static Future<void> storeTeacherInfo(json) async {
    final prefs = GetStorage();
    await prefs.write(Prefs.TEACHER_INFO, json);
    teacherInfo = prefs.read(Prefs.TEACHER_INFO);
    loadLocalData();
  }

  static Future<void> storeAdminInfo(json) async {
    final prefs = GetStorage();
    await prefs.write(Prefs.ADMIN_INFO, json);
    adminInfo = prefs.read(Prefs.ADMIN_INFO);
    loadLocalData();
  }

  static void loadLocalData() {
    final prefs = GetStorage();
    userInfo = prefs.read(Prefs.USER_INFO) ?? <dynamic>[];
    teacherInfo = prefs.read(Prefs.TEACHER_INFO) ?? <String, dynamic>{};
    loginInfo = prefs.read(Prefs.LOGIN_INFO) ?? {};
    adminInfo = prefs.read(Prefs.ADMIN_INFO) ?? <String, dynamic>{};

    studentList = _decodeList(userInfo);
    teacherModel = _decodeMap(teacherInfo);
    adminModel = _decodeMap(adminInfo);
  }

  static List<Map<String, dynamic>> _decodeList(dynamic value) {
    try {
      final decoded = value is String ? json.decode(value) : value;
      if (decoded is List) {
        return decoded
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      }
    } catch (_) {
      // Invalid persisted data should behave like an empty session.
    }
    return [];
  }

  static Map<String, dynamic> _decodeMap(dynamic value) {
    try {
      final decoded = value is String ? json.decode(value) : value;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    } catch (_) {
      // Invalid persisted data should behave like an empty session.
    }
    return {};
  }

  static void clearLocalData() {
    GetStorage().erase();
    loadLocalData();
  }
}
