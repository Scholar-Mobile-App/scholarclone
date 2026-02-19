import 'package:get/get.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

class OwnProfileController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];
}
