import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart' as toast;

String baseURL = "http://api.triz.com/V1Api/V1servicefile/Tkplsn/";

const String msg_DownloadStarting = "Download starting";

Future<bool> checkCameraPermission() async {
  return checkPermission(Permission.camera);
}

Future<bool> checkMediaPermission() async {
  return checkPermission(Permission.mediaLibrary);
}

checkPermission(Permission permissiontype) async {
  if (Platform.isAndroid) {
    PermissionStatus permission = await permissiontype.status;
    if (permission != PermissionStatus.granted) {
      Map<Permission, PermissionStatus> permissions = await [
        permissiontype,
      ].request();
      if (permissions[permissiontype] == PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }
  } else {
    return true;
  }
}

Future<void> startDownload(String fileUrl, String savePath) async {
  Map<String, dynamic> result = {
    'isSuccess': false,
    'filePath': null,
    'error': null,
  };

  try {
    final response = await _dio.download(fileUrl, savePath,
        onReceiveProgress: showDownloadProgress);
    result['isSuccess'] = response.statusCode == 200;
    result['filePath'] = savePath;
  } catch (ex) {
    log("'error'$ex");
    result['error'] = ex.toString();
  } finally {
    final isSuccess = result['isSuccess'];
    final filePath = result['filePath'];
    if (isSuccess) {
      // OpenFile.open(filePath);
    } else {
      //showToastMessage('There was an error while downloading the file.');
      Fluttertoast.showToast(
        msg: 'There was an error while downloading the file.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.lightGreen,
        textColor: Colors.white,
      );
    }
    //await _showNotificationDownload(result);
  }
}

final Dio _dio = Dio();

void showDownloadProgress(received, total) {
  if (total != -1) {
    print((received / total * 100).toStringAsFixed(0) + "%");
  }
}

showToast({
  BuildContext? context,
  message,
  icons = Icons.error_outline,
  color = Colors.red,
  bool isTop = true,
}) {
  toast.dismissAllToast();
  toast.showToastWidget(
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (icons != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                icons,
                color: Colors.white,
              ),
            ),
        ],
      ),
    ),
    context: context,
    position: isTop ? StyledToastPosition.top : StyledToastPosition.bottom,
    animation: isTop
        ? StyledToastAnimation.slideFromTopFade
        : StyledToastAnimation.slideFromBottomFade,
    textDirection: TextDirection.rtl,
  );
}

Widget getCircularProgressIndicator() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            backgroundColor: AppColor.secondaryColor,
          ),
        ],
      ),
    ),
  );
}
