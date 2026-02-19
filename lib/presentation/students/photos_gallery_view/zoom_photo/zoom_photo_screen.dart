import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/photos_gallery_view/zoom_photo/zoom_photo_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../../widgets/download_manager.dart';

class ZoomPhotoScreen extends StatelessWidget {
  final ZoomPhotoController _controller = Get.put(ZoomPhotoController());

  ZoomPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            "",
            style: TextStyle(color: CU.textColorDark),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                String path = await downloadExport(
                  context: Get.context!,
                  fileUrl: _controller
                      .albumData[_controller.current.value].fileName!,
                  filename: CU.getFileNameOfURL(_controller
                      .albumData[_controller.current.value].fileName!),
                  open: false,
                );

                Share.shareXFiles([XFile(path)], text: 'Image');
              },
              icon: const Icon(Icons.share, color: Colors.white),
            ),
            IconButton(
              onPressed: () async {
                await downloadExport(
                  context: Get.context!,
                  fileUrl: _controller
                      .albumData[_controller.current.value].fileName!,
                  filename: CU.getFileNameOfURL(_controller
                      .albumData[_controller.current.value].fileName!),
                  open: true,
                );
              },
              icon: const Icon(Icons.download, color: Colors.white),
            ),
          ],
          systemOverlayStyle: SystemUiOverlayStyle.dark),
      backgroundColor: Colors.black12,
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            initialPage: _controller.current.value,
            height: MediaQuery.of(context).size.height,
            autoPlay: false,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            // pauseAutoPlayOnTouch: Duration(seconds: 10),
            onPageChanged: (index, d) {
              _controller.current.value = index;
            },
          ),
          items: _controller.map<Widget>(
            _controller.albumData,
            (index, i) {
              return Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: PhotoView(
                    heroAttributes: PhotoViewHeroAttributes(
                      tag: "img$index",
                    ),
                    imageProvider: NetworkImage(
                      _controller.albumData[index].fileName!,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
