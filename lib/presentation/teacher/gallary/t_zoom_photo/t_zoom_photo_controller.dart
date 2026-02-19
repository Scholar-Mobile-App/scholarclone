import 'package:get/get.dart';
import 'package:scholar_clone/model/teacher/teacher_gallery_mogel.dart';

class TeacherZoomPhotoController extends GetxController {
  List<TeacherGallery> albumData = Get.arguments[0];
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
