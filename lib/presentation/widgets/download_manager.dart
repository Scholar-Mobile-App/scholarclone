import 'dart:io';
import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/cu.dart';

Future<void> launchURL(String url) async {
  await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
}

Future<String> downloadExport({
  required BuildContext context,
  required String fileUrl,
  required String filename,
  bool open = true,
}) async {
  bool isStoragePermission = true;

  if (Platform.isAndroid) {
    if ((await DeviceInfoPlugin().androidInfo).version.sdkInt >= 33) {
      // For Android 13+, use media library permission for general file downloads
      await Permission.mediaLibrary.request();
      isStoragePermission = await Permission.mediaLibrary.status.isGranted;
    } else {
      await Permission.storage.request();
      isStoragePermission = await Permission.storage.status.isGranted;
    }
  } else {
    await Permission.storage.request();
    isStoragePermission = await Permission.storage.status.isGranted;
  }

  if (isStoragePermission) {
    String extension = fileUrl.split(".").last.toLowerCase();
    if (extension == "pdf") {
      await launchURL(fileUrl);
      return "";
    } else if ([
      'jpeg',
      'jpg',
      'png',
      'xlsx',
      "xml",
      "xls",
      "xlt",
      "xltm",
      "xltx",
      "xlsb",
      "xlsm",
      "docx"

    ].contains(extension)) {
      Directory? dir;
      String savePath = "";
      String savename = CU.getFileNameOfURL(fileUrl);
      showProgressDialog(context);
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      } else {
        dir = Directory('/storage/emulated/0/Download');
        if (!await dir.exists()) dir = await getExternalStorageDirectory();
      }

      if (dir != null) {
        savePath = "${dir.path}/$savename";
        try {
          await Dio().download(fileUrl, savePath);

          Future.delayed(const Duration(milliseconds: 500), () async {
            if (!open) {
              Get.snackbar(
                "Download",
                "download successfully",
                backgroundColor: Colors.green,
                colorText: Colors.white,
                icon: const Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              );
            }

            if (open) {
              final file = File(savePath);
              if (file.existsSync()) {
                log("File  ${file.path} + $savePath");
                final result = await OpenFilex.open(savePath);

                log(result.message);
                log(result.type.name);
                log(result.toString());
              } else {
                log('File not found: $savePath');
              }
            }
          });
        } on DioException catch (e) {
          log(e.message.toString());
        }
      }
      hideProgressDialog();
      return savePath;
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.snackbar(
          "alert",
          "No valid file formate",
          backgroundColor: Colors.amber,
        );
        // snackbar(title: "alert".tr, messege: "file_formate_validation".tr);
      });
      return "";
    }
  } else {
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.snackbar(
        "alert",
        "Permission not allow",
        backgroundColor: Colors.yellow,
      );
    });
    return "";
  }
}

showProgressDialog(BuildContext context) {
  CU.progressDialog = ProgressDialog(context: context);

  CU.progressDialog!.show(
    msg: "download file",
  );
}

hideProgressDialog() async {
  log("hideProgressDialog()");
  if (CU.progressDialog != null) {
    CU.progressDialog = null;
    Get.back();
    log("hideProgressDialog() =>");
  }
}
