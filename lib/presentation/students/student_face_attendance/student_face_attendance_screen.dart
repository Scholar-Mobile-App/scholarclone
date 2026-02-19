import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/utility.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';

import '../../../core/utils/cs.dart';
import 'student_face_attendance_controller.dart';

class StudentFaceAttendanceScreen extends StatelessWidget {
  StudentFaceAttendanceScreen({super.key});
  final StudentFaceAttendanceController _controller =
      Get.put(StudentFaceAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        "Student Attendance Photos",
        rounded: false,
      ),
      body: Obx(
        () => Stack(
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
                : ListView(
                    children: [
                      getProfileAppbar(),
                      hSizeBox20,
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(15),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                        ),
                        itemCount: _controller.imagePath.length + 1,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              if (_controller.isSetFromNetworkImage.value) {
                                if (await checkPermission(Permission.camera)) {
                                  XFile? picture =
                                      await ImagePicker().pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 80,
                                    maxHeight: 500,
                                    maxWidth: 500,
                                  );

                                  if (_controller.isSetFromNetworkImage.value) {
                                    _controller.imagePath.clear();
                                    _controller.isSetFromNetworkImage.value =
                                        false;
                                  }
                                  _controller.imagePath.add(picture!.path);
                                  _controller.isChange.value = true;
                                }
                              } else if (_controller.imagePath.length ==
                                  index) {
                                if (await checkPermission(Permission.camera)) {
                                  XFile? picture =
                                      await ImagePicker().pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 80,
                                    maxHeight: 500,
                                    maxWidth: 500,
                                  );
                                  if (_controller.isSetFromNetworkImage.value) {
                                    _controller.imagePath.clear();
                                    _controller.isSetFromNetworkImage.value =
                                        false;
                                  }

                                  _controller.imagePath.add(picture!.path);
                                  _controller.isChange.value = true;
                                }
                              }
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.green),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: _controller.imagePath.length == index
                                      ? const Icon(Icons.photo_camera)
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: _controller
                                                  .isSetFromNetworkImage.value
                                              ? Image.network(
                                                  _controller.imagePath[index],
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.file(
                                                  File(_controller
                                                      .imagePath[index]),
                                                  fit: BoxFit.fill,
                                                ),
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    _controller.imagePath.length == index
                                        ? Icons.close
                                        : Icons.check,
                                    color: _controller.imagePath.length == index
                                        ? Colors.transparent
                                        : Colors.green,
                                    size: 28,
                                  ),
                                ),
                                if (!_controller.isSetFromNetworkImage.value)
                                  Positioned(
                                    top: -7,
                                    right: -7,
                                    child: GestureDetector(
                                      onTap:
                                          _controller.imagePath.length == index
                                              ? null
                                              : () {
                                                  _controller.imagePath
                                                      .removeAt(index);
                                                },
                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor:
                                            _controller.imagePath.length ==
                                                    index
                                                ? Colors.transparent
                                                : Colors.red,
                                        child: Icon(
                                          _controller.imagePath.length == index
                                              ? Icons.close
                                              : Icons.close,
                                          color: _controller.imagePath.length ==
                                                  index
                                              ? Colors.transparent
                                              : Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          );
                        },
                      ),
                      (_controller.isChange.value &&
                              _controller.imagePath.isNotEmpty)
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: AppButton(
                                text: "Save",
                                onTap: () {
                                  _controller.callServiceSubmit(context);
                                },
                              ),
                            )
                          : hSizeBox10
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Widget getProfileAppbar() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        GestureDetector(
          onTap: () {
            // Get.offNamedUntil(
            //   AppRoutes.studentMain,
            //   arguments: userInfo[index],
            //   (route) => false,
            // );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(20, 55, 20, 8),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(3, 3),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            _controller.userInfo[CS.roll_no],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColor.secondaryColor,
                            ),
                          ),
                          hSizeBox4,
                          Text(
                            "Roll No",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.textColorlight,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            _controller.userInfo[CS.std_name] +
                                " - " +
                                _controller.userInfo[CS.division],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColor.greenColor,
                            ),
                          ),
                          hSizeBox4,
                          Text(
                            "STD",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.textColorlight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                hSizeBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Column(
                      children: [
                        Text(
                          "${_controller.userInfo[CS.first_name]} ${_controller.userInfo[CS.last_name]}",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColor.textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _controller.userInfo[CS.section],
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.textColorlight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      AppImage.check,
                      height: 22,
                      width: 22,
                      color: Colors.green,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 120,
          width: 120,
          child: ClipPolygon(
            sides: 5,
            borderRadius: 10.0, // Defaults to 0.0 degrees
            // Defaults to 0.0 degrees
            boxShadows: [
              PolygonBoxShadow(color: Colors.grey, elevation: 1.0),
            ],

            child: Container(
              height: 50,
              width: 50,
              color: Colors.black,
              child: _controller.userInfo[CS.image] != null ||
                      _controller.userInfo[CS.image].toString().isNotEmpty
                  ? CU.loadImage(
                      url: _controller.userInfo[CS.image_path] +
                          _controller.userInfo[CS.image],
                      height: 60.0,
                      width: 60.0,
                    )
                  : Image.asset(AppImage.admin),
            ),
          ),
        ),
      ],
    );
  }
}
