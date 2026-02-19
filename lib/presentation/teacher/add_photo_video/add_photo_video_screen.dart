import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

import 'add_photo_video_controller.dart';

class AddPhotoVideoScreen extends StatelessWidget {
  AddPhotoVideoScreen({super.key});
  final AddPhotoVideoController _controller =
      Get.put(AddPhotoVideoController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(
          text: _controller.tabIndex.value == 0 ? "Add Photos" : "Add Videos",
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
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        hSizeBox10,
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                text: "Photos",
                                onTap: () {
                                  _controller.tabIndex.value = 0;
                                },
                                textColor: _controller.tabIndex.value == 0
                                    ? null
                                    : Colors.black,
                                color: _controller.tabIndex.value == 0
                                    ? AppColor.tprimaryColor
                                    : Colors.white,
                              ),
                            ),
                            wSizeBox20,
                            Expanded(
                              child: AppButton(
                                text: "Videos",
                                textColor: _controller.tabIndex.value == 1
                                    ? null
                                    : Colors.black,
                                color: _controller.tabIndex.value == 1
                                    ? AppColor.tprimaryColor
                                    : Colors.white,
                                onTap: () {
                                  _controller.tabIndex.value = 1;
                                },
                              ),
                            )
                          ],
                        ),
                        hSizeBox20,
                        Container(
                          height: 1,
                          margin: const EdgeInsets.only(bottom: 10),
                          color: Colors.black,
                        ),
                        dropDownTextField(
                          title: "Select Standard",
                          list: _controller.stdName,
                          onChanged: (value) {
                            for (int i = 0;
                                i < _controller.stdName.length;
                                i++) {
                              if (_controller.standardModel!.data![i].stdName ==
                                  value) {
                                _controller.stdId.value =
                                    _controller.standardModel!.data![i].stdId!;
                                _controller.divName.value = [];
                                _controller.subjectName.value = [];
                                _controller.callServiceDivision();

                                break;
                              }
                            }
                          },
                        ),
                        dropDownTextField(
                          title: "Select Division",
                          list: _controller.divName,
                          onChanged: (value) {
                            for (int i = 0;
                                i < _controller.divisionModel!.data!.length;
                                i++) {
                              if (_controller.divisionModel!.data![i].divName ==
                                  value) {
                                _controller.divId.value =
                                    _controller.divisionModel!.data![i].divId!;
                                break;
                              }
                            }
                          },
                        ),
                        textField(
                          title: "Album Title",
                          hintText: "Type Here",
                          onChanged: (value) {
                            _controller.albumtitle.value = value;
                          },
                        ),
                        textField(
                          title: "Photo Title",
                          hintText: "Type Here",
                          onChanged: (value) {
                            _controller.phototitle.value = value;
                          },
                        ),
                        if (_controller.tabIndex.value == 1)
                          textField(
                            title: "youtube link",
                            hintText: "Type Here",
                            onChanged: (value) {
                              _controller.youTubeLink.value = value;
                            },
                          ),
                        if (_controller.tabIndex.value == 0)
                          Column(
                            children: [
                              title("Selected"),
                              const Divider(color: Colors.black),
                              // _controller.tabIndex.value == 0
                              //     ?
                              _controller.images.isEmpty
                                  ? ElevatedButton(
                                      onPressed: () {
                                        _controller.pickPhotos();
                                      },
                                      child: const Text("Select Photos"),
                                    )
                                  : Container(),
                              // : _controller.videosThumbnais.isEmpty
                              //     ? ElevatedButton(
                              //         onPressed: () {
                              //           _controller.pickVideo();
                              //         },
                              //         child: const Text("Select Video"),
                              //       )
                              //     : Container(),
                              hSizeBox10,
                              Wrap(
                                children: List.generate(
                                  _controller.tabIndex.value == 0
                                      ? _controller.images.length
                                      : _controller.videosThumbnais.length,
                                  (index) => imageContainer(index),
                                ),
                              ),
                            ],
                          ),
                        hSizeBox10,
                      ],
                    ),
                  ),
                  hSizeBox20,
                  AppButton(
                    text: "Submit",
                    loader: _controller.isLoading.value,
                    onTap: _controller.isLoading.value
                        ? null
                        : () {
                            _controller.callServiceSubmit();
                          },
                  ),
                  hSizeBox30,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  title(String text) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  imageContainer(int i) => Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: (Get.width / 4) - 30,
            width: (Get.width / 4) - 30,
            margin: const EdgeInsets.only(top: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 2,
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
              child: Image.file(
                File(
                  _controller.tabIndex.value == 0
                      ? _controller.images[i]
                      : _controller.videosThumbnais[i],
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _controller.tabIndex.value == 0
                  ? _controller.images.removeAt(i)
                  : _controller.videosThumbnais.removeAt(i);
            },
            child: const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 12,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      );
}
