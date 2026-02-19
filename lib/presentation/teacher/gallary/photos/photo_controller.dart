import 'package:get/get.dart';
import 'package:scholar_clone/model/teacher/teacher_gallery_mogel.dart';

class PhotoController extends GetxController {
  List<TeacherGallery> data = Get.arguments;

  RxBool isSelection = false.obs;

  RxList<dynamic> selected = [].obs;
  RxList<String> imageList = <String>[].obs;
}
