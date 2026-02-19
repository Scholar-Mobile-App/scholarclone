import 'package:get/get.dart';

import '../../../../model/student/photos_gallery_model.dart';

class ZoomPhotoController extends GetxController {
  List<Album> albumData = Get.arguments[0];
  int index = Get.arguments[1];

  RxInt current = 0.obs;

  @override
  void onInit() {
    current.value = index;
    super.onInit();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
