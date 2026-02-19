import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YoutubeVideoPlayer extends StatelessWidget {
  YoutubeVideoPlayer({super.key});
  final YoutubeVideoPlayerController _controller =
      Get.put(YoutubeVideoPlayerController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class YoutubeVideoPlayerController extends GetxController {}
