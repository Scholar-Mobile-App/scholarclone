import 'package:get/get.dart';
import 'package:scholar_clone/model/student/photos_gallery_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/student/home_data_model.dart';

class PhotoGalleryViewController extends GetxController {
  List<Album> data = Get.arguments[0];
  Content content = Get.arguments[1];

  RxBool isPhoto = true.obs;
  RxBool isGridStagg = false.obs;
  RxBool isSelection = false.obs;

  RxList<dynamic> selected = [].obs;
  RxList<String> imageList = <String>[].obs;

  @override
  void onInit() {
    isPhoto.value = content.screenName == "photos_gallery";
    super.onInit();
  }

  getUrltoPhotos(String url) {
    return "https://i.ytimg.com/vi/${url.substring(url.lastIndexOf("v=") + 2)}/hqdefault.jpg";
  }

  openYouTubeVideo(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
