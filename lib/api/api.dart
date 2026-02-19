// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class ApiHandler {
//   static Future<http.Response> post(
//       {required String url, required Map<String, dynamic> body}) async {
//     log(ApiUrls.baseUrl + url);
//     http.Response response = await http.post(
//       Uri.parse(ApiUrls.baseUrl + url),
//       body: jsonEncode(body),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer ${LocalStorage.token.value}'
//       },
//     );
//     log(response.body.toString());
//     return response;
//   }

//   static Future<http.Response> put(
//       {required String url, Map<String, dynamic>? body}) async {
//     log(ApiUrls.baseUrl + url);
//     http.Response response = await http.put(
//       Uri.parse(ApiUrls.baseUrl + url),
//       body: jsonEncode(body),
//       headers: body == null
//           ? {'Authorization': 'Bearer ${LocalStorage.token.value}'}
//           : {
//               "Content-Type": "application/json",
//               'Authorization': 'Bearer ${LocalStorage.token.value}'
//             },
//     );
//     log(response.body.toString());
//     return response;
//   }

//   static Future<http.Response> get({required String url}) async {
//     log(ApiUrls.baseUrl + url);
//     http.Response response = await http.get(
//       Uri.parse(ApiUrls.baseUrl + url),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer ${LocalStorage.token.value}'
//       },
//     );
//     log(response.body.toString());
//     return response;
//   }

//   static Future<http.Response> delete({required String url}) async {
//     log(ApiUrls.baseUrl + url);
//     http.Response response = await http.delete(
//       Uri.parse(ApiUrls.baseUrl + url),
//       headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
//     );
//     return response;
//   }
// }

// void apiErrorHandler(int statusCode, decoded,
//     {bool isLogin = false, bool isRegister = true}) {
//   try {
//     if (statusCode == 400) {
//       errorToast(decoded['message']);
//       if (!isRegister) {
//         Get.offAllNamed(AppRoutes.introScreen);
//       }
//     } else if (statusCode == 401) {
//       errorToast(decoded['message']);
//       LocalStorage.clearData();
//       if (!isLogin) {
//         Future.delayed(Duration.zero, () {
//           Get.offAllNamed(AppRoutes.introScreen);
//         });
//       }
//     } else {
//       errorToast(decoded['message']);
//     }
//   } catch (e, stackTrace) {
//     printWarning(stackTrace.toString());
//   }
// }

// void errorToast(mess) {
//   toast(mess, false);
//   printWarning(mess);
// }
