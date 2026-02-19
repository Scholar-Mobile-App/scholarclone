// import 'dart:developer';
// import 'dart:io';
// import 'dart:isolate';
// import 'dart:ui';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:scholar_clone/core/utils/cu.dart';
// import 'package:scholar_clone/core/utils/utility.dart';

// class FileDownloader {
//   String? localPath;
//   final ReceivePort _port = ReceivePort();
//   var httpClient = HttpClient();

//   Future<String> start(context, String url, bool showProgress,
//       {bool open = true}) async {
//     log("++++++++++++++++++++++++++++++++++++++++++++++++++441");
//     log(url);

//     if (CU.getFileExtensionOfURL(url) == "zip") {
//       startNotificationDownloader(context, url);
//       return '';
//     } else {
//       if (await checkPermission(Permission.storage)) {
//         String dir = (await getApplicationDocumentsDirectory()).path;
//         File file = File('$dir/${CU.getFileNameOfURL(url)}');
//         if (!await file.exists()) {
//           // if (showProgress) CU.showProgressDialog(context);
//           var request = await httpClient.getUrl(Uri.parse(url));
//           var response = await request.close();
//           var bytes = await consolidateHttpClientResponseBytes(response);
//           await file.writeAsBytes(bytes);
//           // if (showProgress) CU.hideProgressDialog(context);
//           // if (open) OpenFile.open(file.path);

//           return file.path;
//         } else {
//           log("++++++++++++++++++++++++++++++++++++++++++++++++++444");
//           log(file.path);
//           // if (open) OpenFile.open(file.path);
//           return file.path;
//         }
//       } else {
//         start(context, url, showProgress, open: true);
//         return '';
//       }
//     }
//   }

//   /* Future<bool> _checkPermission() async {
//     if (Platform.isAndroid) {
//       PermissionStatus permission = await PermissionHandler()
//           .checkPermissionStatus(PermissionGroup.storage);
//       if (permission != PermissionStatus.granted) {
//         Map<PermissionGroup, PermissionStatus> permissions =
//             await PermissionHandler()
//                 .requestPermissions([PermissionGroup.storage]);
//         if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
//           return true;
//         }
//       } else {
//         return true;
//       }
//     } else {
//       return true;
//     }
//     return false;
//   }*/

//   startNotificationDownloader(context, String url) async {
//     if (await checkPermission(Permission.storage)) {
//       await _prepare();

//       Fluttertoast.showToast(
//           msg: "Start Download ${CU.getFileNameOfURL(url)}",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: CU.primaryColor,
//           textColor: Colors.white,
//           fontSize: 12.0);
//       _requestDownload(url);
//     } else {
//       startNotificationDownloader(context, url);
//     }
//   }

//   static Future<void> downloadCallback(
//       String id, DownloadTaskStatus status, int progress) async {
//     log("------------------------------------------------------1");
//     log('Background Isolate Callback: task ($id)');
//     log('Process ($progress)');
//     log("------------------------------------------------------2.1");
//     if (progress.toString() == '100') {
//       log('***********************************');
//       await FlutterDownloader.initialize();
//       bool openDownloaded = await FlutterDownloader.open(taskId: id);
//       log('openDownloaded => $openDownloaded');
//     }
//     log('is in status ($status)');
//     log("------------------------------------------------------2");
//     final SendPort? send =
//         IsolateNameServer.lookupPortByName('downloader_send_port');
//     log("------------------------------------------------------3");

//     send!.send([id, status, progress]);
//   }

//   void _bindBackgroundIsolate() {
//     bool isSuccess = IsolateNameServer.registerPortWithName(
//         _port.sendPort, 'downloader_send_port');

//     if (!isSuccess) {
//       _unbindBackgroundIsolate();
//       _bindBackgroundIsolate();
//       return;
//     }

//     _port.listen((dynamic data) {
//       print('UI Isolate Callback: $data' ' 1 ' + data[2]);
//       log("+++++++++++++++++++++++++++++++++++++++++++++++++");
//     });
//   }

//   void _unbindBackgroundIsolate() {
//     IsolateNameServer.removePortNameMapping('downloader_send_port');
//   }

//   void _requestDownload(url) async {
//     var taskId = await FlutterDownloader.enqueue(
//         url: url,
//         headers: {"auth": "test_for_sql_encoding"},
//         savedDir: localPath!,
//         showNotification: true,
//         openFileFromNotification: true);
//     log(taskId!);
//   }

//   Future<void> _prepare() async {
//     _bindBackgroundIsolate();
//     FlutterDownloader.registerCallback(downloadCallback as DownloadCallback);

//     localPath = '${await _findLocalPath()}${Platform.pathSeparator}Download';

//     final savedDir = Directory(localPath!);
//     bool hasExisted = await savedDir.exists();
//     if (!hasExisted) {
//       savedDir.create();
//     }
//   }

//   Future<String> _findLocalPath() async {
//     final directory = Platform.isAndroid
//         ? await getExternalStorageDirectory()
//         : await getApplicationDocumentsDirectory();
//     return directory!.path;
//   }
// }
