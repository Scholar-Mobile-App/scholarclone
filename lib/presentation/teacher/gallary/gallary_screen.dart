import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/teacher/gallary/gallary_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class GallaryScreen extends StatelessWidget {
  GallaryScreen({super.key});
  final GallaryController _controller = Get.put(GallaryController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Gallery", actions: [
          TextButton(
              onPressed: () {
                Get.toNamed(
                  _controller.isAdmin
                      ? AppRoutes.adminAddPhotos
                      : AppRoutes.addPhotoVideo,
                  arguments: [
                    _controller.data,
                    _controller.userInfo,
                  ],
                )!
                    .then((value) {
                  _controller.callServiceAPI();
                });
              },
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.black),
              ))
        ]),
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
            _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        _controller.teacherGalleryModel == null
                            ? CU.getNodataDesign()
                            : GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(15),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                ),
                                itemCount: _controller
                                    .teacherGalleryModel!.data!.length,
                                itemBuilder: (context, index) {
                                  var data = _controller
                                      .teacherGalleryModel!.data!.entries
                                      .elementAt(index)
                                      .value;

                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.tPhotos,
                                        arguments: data,
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: Get.height,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                                blurRadius: 5,
                                              )
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: CachedNetworkImage(
                                                imageUrl: _controller
                                                            .tabIndex.value ==
                                                        0
                                                    ? data[0].fileName!
                                                    : _controller
                                                        .getYoutubeThumbnail(
                                                            data[0].fileName!)
                                                        .toString(),
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) {
                                                  return Image.asset(
                                                      AppImage.logo);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          data.first.albumTitle!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                        hSizeBox20,
                        AppButton(
                          text: _controller.tabIndex.value == 0
                              ? "Add Photos"
                              : "Add Videos",
                          onTap: () {
                            Get.toNamed(
                              _controller.isAdmin
                                  ? AppRoutes.adminAddPhotos
                                  : AppRoutes.addPhotoVideo,
                              arguments: [
                                _controller.data,
                                _controller.userInfo,
                              ],
                            )!
                                .then((value) {
                              _controller.callServiceAPI();
                            });
                          },
                        ),
                        hSizeBox20,
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
