import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      LocalStorage.notificationCount.value = int.parse(contents);
      log("Local counteer");
      log(LocalStorage.notificationCount.value.toString());
      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    LocalStorage.notificationCount.value = counter;
    log("WRITE_+_+_$counter+_+_");
    return file.writeAsString('$counter');
  }
}
