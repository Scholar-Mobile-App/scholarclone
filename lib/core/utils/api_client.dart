import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';

enum CallMethod { get, post, put, delete }

class ApiClient {
  static Future<Map<String, dynamic>> call(
    context, {
    @required apiUrl,
    body,
    bool isBack = false,
    bool? isShowProgressDialog,
    CallMethod callMethod = CallMethod.post,
    bool isFormData = true,
  }) async {
    isShowProgressDialog ??= true;

    if (isShowProgressDialog) CU.showProgressDialog(context);

    Dio dio = Dio();

    // Add Authorization header if token is available
    String? token = _getToken();
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    log("+++++++++++++++++++++ API Request +++++++++++++++++++++");
    log("URL: $apiUrl");
    log("Body: ${body.toString()}");
    log("Headers: ${dio.options.headers}");
    log("+++++++++++++++++++++ API Request +++++++++++++++++++++");

    try {
      Response response;

      switch (callMethod) {
        case CallMethod.post:
          response = await dio.post(
            apiUrl,
            data: isFormData ? FormData.fromMap(body ?? {}) : body,
          );
          break;
        case CallMethod.get:
          response = await dio.get(apiUrl, queryParameters: body);
          break;
        case CallMethod.delete:
          response = await dio.delete(apiUrl);
          break;
        case CallMethod.put:
          response = await dio.put(apiUrl, data: body);
          break;
      }

      if (isShowProgressDialog) CU.hideProgressDialog(context);

      log("+++++++++++++++++++++ API Response +++++++++++++++++++++");
      log("Status Code: ${response.statusCode}");
      log("Data: ${response.data}");
      log("+++++++++++++++++++++ API Response +++++++++++++++++++++");

      if (response.statusCode == 200) {
        dynamic rawData = response.data;

        // Decode if it's a string
        if (rawData is String) {
          rawData = jsonDecode(rawData);
        }

        // Wrap non-map responses
        Map<String, dynamic> resjson =
            rawData is Map<String, dynamic> ? rawData : {'data': rawData};

        // Handle status 2 (custom auth fail)
        if (resjson[CS.status]?.toString() == "2") {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => CU.showAuthenticationFail(
              context,
              CU.isEmptyOrNull(resjson[CS.message])
                  ? "Authentication Fail"
                  : resjson[CS.message],
            ),
          );
        }

        return resjson;
      } else {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => CU.showDiloag(context, CS.InternalServerError),
        );
        return <String, dynamic>{};
      }
    } catch (e, stack) {
      if (isShowProgressDialog) CU.hideProgressDialog(context);
      log("❌ API call failed: $e");
      log("❌ Stack trace: $stack");

      return <String, dynamic>{};
    }
  }

  static String? _getToken() {
    try {
      String userProfile = LocalStorage.loginInfo["user_profile_name"] ?? "";
      switch (userProfile) {
        case "Student":
          if (LocalStorage.studentList.isNotEmpty) {
            return LocalStorage.studentList[0]["token"];
          }
          break;
        case "Teacher":
          return LocalStorage.teacherModel["token"];
        case "Admin":
          return LocalStorage.adminModel["token"];
      }
    } catch (e) {
      log("Error getting token: $e");
    }
    return null;
  }
}
