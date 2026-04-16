import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/presentation/students/photos_gallery_view/photos_gallery_view_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';
import 'package:scholar_clone/routes/app_routes.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/utils/constant_sizebox.dart';
import '../../../core/utils/cu.dart';

class PhotoGalleryViewScreen extends StatelessWidget {
  PhotoGalleryViewScreen({super.key});

  final PhotoGalleryViewController _controller =
      Get.put(PhotoGalleryViewController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          _controller.data.first.albumTitle!,
          actions: <Widget>[
            if (_controller.isSelection.value)
              IconButton(
                onPressed: () async {
                  List<XFile> imagePath = [];
                  for (String url in _controller.selected) {
                    imagePath.add((XFile(await downloadExport(
                      context: Get.context!,
                      fileUrl: url,
                      filename: CU.getFileNameOfURL(url),
                      open: false,
                    ))));
                  }

                  Share.shareXFiles(imagePath, text: 'Image');

                  // ShareExtend.shareMultiple(
                  //   _controller.imageList,
                  //   "image",
                  //   subject: "share multi image",
                  // );

                  _controller.selected.clear();
                  _controller.imageList.clear();
                  _controller.isSelection.value = false;
                },
                icon: const Icon(Icons.share),
              ),
            if (_controller.isSelection.value)
              IconButton(
                onPressed: () async {
                  for (String url in _controller.selected) {
                    downloadExport(
                      context: Get.context!,
                      fileUrl: url,
                      filename: CU.getFileNameOfURL(url),
                    );
                  }

                  _controller.selected.clear();
                  _controller.isSelection.value = false;
                },
                icon: const Icon(Icons.download),
              ),
            if (_controller.isPhoto.value)
              IconButton(
                  icon: (_controller.isGridStagg.value
                      ? const Icon(Icons.widgets, color: Colors.grey)
                      : Icon(
                          Icons.widgets,
                          color: CU.secondaryColor,
                        )),
                  onPressed: () {
                    _controller.isGridStagg.value =
                        !_controller.isGridStagg.value;
                  })
          ],
        ),
        body: MasonryGridView.count(
          physics: const ClampingScrollPhysics(),
          crossAxisCount: 2,
          itemCount: _controller.data.length,
          padding: const EdgeInsets.all(12),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          itemBuilder: (BuildContext context, int index) {
            var data = _controller.data[index];
            return Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      if (_controller.isSelection.value) {
                        if (_controller.selected.contains(data.fileName)) {
                          _controller.selected.remove(data.fileName);
                          if (_controller.selected.isEmpty) {
                            _controller.isSelection.value =
                                !_controller.isSelection.value;
                          }
                        } else {
                          _controller.selected.add(data.fileName);
                        }
                      } else {
                        if (_controller.isPhoto.value) {
                          Get.toNamed(AppRoutes.zoomPhoto,
                              arguments: [_controller.data, index]);
                        } else {
                          _controller.openYouTubeVideo(data.fileName);
                        }
                      }
                    },
                    onLongPress: () {
                      if (_controller.selected.isEmpty) {
                        _controller.isSelection.value =
                            !_controller.isSelection.value;
                      }

                      _controller.selected.add(data.fileName);
                    },
                    child: Stack(
                      children: [
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.all(
                                _controller.selected.contains(data.fileName)
                                    ? 15
                                    : 0),
                            height: _controller.isGridStagg.value
                                ? null
                                : Get.width * 0.4,
                            width: _controller.isGridStagg.value
                                ? null
                                : Get.width,
                            decoration: BoxDecoration(
                              color:
                                  _controller.selected.contains(data.fileName)
                                      ? Colors.blue.withOpacity(0.3)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: CachedNetworkImage(
                                imageUrl: _controller.isPhoto.value == true
                                    ? data.fileName!
                                    : _controller
                                        .getUrltoPhotos(data.fileName!),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            )),
                        if (!_controller.isPhoto.value)
                          Positioned.fill(
                            child: Container(
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.play_circle_outline,
                                size: 50,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  hSizeBox10,
                  if (!_controller.isGridStagg.value)
                    Text(
                      data.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: CU.textColorDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
