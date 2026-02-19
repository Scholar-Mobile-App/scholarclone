import 'dart:io';

import 'package:path_provider/path_provider.dart';

class NavigatorStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/navigator.txt');
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return "";
    }
  }

  Future<File> writeData(String data) async {
    final file = await _localFile;
    return file.writeAsString(data);
  }
}
