import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/photos_gallery/photos_gallery_controler.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class PhotoGalleryScreen extends StatelessWidget {
  PhotoGalleryScreen({super.key});
  final PhotoGalleryController _controller = Get.put(PhotoGalleryController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(_controller.data.subTitle!, actions: null),
        body: _controller.isLoading.value == true
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.photosGalleryModel == null
                ? CU.getNodataDesign()
                : MasonryGridView.count(
                    crossAxisCount: 2,
                    itemCount: _controller.photosGalleryModel!.data!.length,
                    padding: const EdgeInsets.all(12),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    itemBuilder: (BuildContext context, int index) {
                      var data = _controller.photosGalleryModel!.data!.entries
                          .elementAt(index)
                          .value;
                      return InkWell(
                        onTap: () async {
                          Get.toNamed(AppRoutes.photoGalleryView, arguments: [
                            data,
                            _controller.data,
                          ]);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                "https://cdn-icons-png.flaticon.com/128/716/716869.png",
                                height: 40,
                              ),
                              hSizeBox10,
                              Text(
                                data.first.albumTitle!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: CU.textColorDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
