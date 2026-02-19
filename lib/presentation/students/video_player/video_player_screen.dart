import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/presentation/students/video_player/video_player_controller.dart';

import '../../../core/utils/cs.dart';

class VideoPlayerScreen extends StatelessWidget {
  VideoPlayerScreen({super.key});
  final VideoPlayerCon _controller = Get.put(VideoPlayerCon());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        elevation: 1,
        centerTitle: true,
        title: Text(
          _controller.data[CS.title],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(
            controller: _controller.chewieController!,
          ),
        ),
      ),
    );
  }
}
