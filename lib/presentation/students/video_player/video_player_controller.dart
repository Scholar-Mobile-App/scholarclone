import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../core/utils/cs.dart';

class VideoPlayerCon extends GetxController {
  Map<String, dynamic> data = Get.arguments;

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  Future<void>? initializeVideoPlayerFuture;

  RxBool isPlaying = false.obs;

  @override
  void onInit() async {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(data[CS.url]),
    );

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );

    videoPlayerController!.addListener(videoPlaybackListener);

    super.onInit();
  }

  void videoPlaybackListener() {
    if (videoPlayerController!.value.position >=
        videoPlayerController!.value.duration) {
      Get.back();
    }
  }

  @override
  void onClose() {
    chewieController!.videoPlayerController.dispose();
    chewieController!.dispose();
    super.onClose();
  }
}
