import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/teacher/gallary/photos/photo_controller.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';
import 'package:scholar_clone/routes/app_routes.dart';
import 'package:share_plus/share_plus.dart';

class PhotoScreen extends StatelessWidget {
  PhotoScreen({super.key});
  final PhotoController _controller = Get.put(PhotoController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          elevation: 0,
          backgroundColor: CU.tprimaryColor,
          title: const Text(
            "Photos",
            style: TextStyle(color: Colors.white),
          ),
          actions: _controller.isSelection.value
              ? [
                  IconButton(
                    onPressed: () async {
                      List<XFile> imagePath = [];
                      for (String url in _controller.selected) {
                        imagePath.add((XFile(
                          await downloadExport(
                            context: Get.context!,
                            fileUrl: url,
                            filename: CU.getFileNameOfURL(url),
                            open: false,
                          ),
                        )));
                      }

                      Share.shareXFiles(imagePath, text: 'Image');

                      _controller.selected.clear();
                      _controller.imageList.clear();
                      _controller.isSelection.value = false;
                    },
                    icon: const Icon(Icons.share),
                  ),
                  IconButton(
                    onPressed: () async {
                      List<XFile> imagePath = [];
                      for (String url in _controller.selected) {
                        imagePath.add((XFile(
                          await downloadExport(
                            context: Get.context!,
                            fileUrl: url,
                            filename: CU.getFileNameOfURL(url),
                          ),
                        )));
                      }
                      _controller.selected.clear();
                      _controller.imageList.clear();
                      _controller.isSelection.value = false;
                    },
                    icon: const Icon(Icons.download),
                  ),
                ]
              : null,
        ),
        body: Stack(
          children: [
            Container(
              width: Get.width,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(Get.width / 2, 30),
                  bottomRight: Radius.elliptical(Get.width / 2, 30),
                ),
              ),
            ),
            _controller.data.isEmpty
                ? CU.getNodataDesign()
                : GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: _controller.data.length,
                    itemBuilder: (context, index) {
                      var data = _controller.data[index];

                      return Obx(
                        () => GestureDetector(
                          onTap: () {
                            if (_controller.isSelection.value) {
                              if (_controller.selected
                                  .contains(data.fileName)) {
                                _controller.selected.remove(data.fileName);
                                if (_controller.selected.isEmpty) {
                                  _controller.isSelection.value =
                                      !_controller.isSelection.value;
                                }
                              } else {
                                _controller.selected.add(data.fileName);
                              }
                            } else {
                              Get.toNamed(AppRoutes.tzoomPhoto,
                                  arguments: [_controller.data, index]);
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
                            clipBehavior: Clip.none,
                            alignment: Alignment.topRight,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: Get.height,
                                width: Get.width,
                                padding: EdgeInsets.all(
                                    _controller.selected.contains(data.fileName)
                                        ? 10
                                        : 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: _controller.selected
                                          .contains(data.fileName)
                                      ? Colors.blue.withOpacity(0.3)
                                      : Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 5,
                                    )
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: data.fileName!,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) {
                                      return Image.asset(AppImage.logo);
                                    },
                                  ),
                                ),
                              ),
                              if (_controller.selected.contains(data.fileName))
                                const Positioned(
                                  top: -10,
                                  right: -10,
                                  child: CircleAvatar(
                                    radius: 15,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.blue,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
