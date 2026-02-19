import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/presentation/students/home/home_screen.dart';
import 'package:scholar_clone/presentation/students/s_drawer/s_drawer_screen.dart';
import 'package:scholar_clone/presentation/students/student_main/student_main_controller.dart';
import 'package:scholar_clone/presentation/students/student_profile/student_profile_screen.dart';

import '../../../core/packages/BottomNavigation/fancy_bottom_navigation.dart';
import '../../../core/utils/cs.dart';

class StudentMainScreen extends StatelessWidget {
  StudentMainScreen({super.key});
  final StudentMainController _controller = Get.put(StudentMainController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _controller.scaffoldKey,
        drawer: StudentDrawer(
          homeDataModel: _controller.homeData,
          userInfo: _controller.data,
        ),
        bottomNavigationBar: getBottomNavigation(),
        body: _controller.bottomCurrentPage.value == 0
            ? HomeScreen(
                homeDataModel: _controller.homeData,
                userInfo: _controller.data,
              )
            : _controller.bottomCurrentPage.value == 1
                ? StudentProfileScreen(
                    userInfo: _controller.data,
                  )
                : HomeScreen(
                    homeDataModel: _controller.homeData,
                    userInfo: _controller.data,
                  ),
      ),
    );
  }

  getBottomNavigation() {
    return Obx(
      () => FancyBottomNavigation(
        circleColor: const Color(0xFFfff1ab),
        initialSelection: _controller.bottomCurrentPage.value,
        key: _controller.bottomKey,
        tabs: [
          TabData(
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                height: 30,
                width: 30,
                child: Image.asset(
                  AppImage.home,
                ),
              ),
            ),
            sectedicon: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 30,
                width: 30,
                child: Image.asset(
                  AppImage.home,
                  color: const Color(0xFFbf9100),
                ),
              ),
            ),
          ),
          TabData(
              icon: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: SizedBox(
                  width: 35.0,
                  height: 35.0,
                  child: CachedNetworkImage(
                    imageUrl: _controller.data[CS.image_path].toString() +
                        _controller.data[CS.image].toString(),
                    errorWidget: (context, url, error) {
                      return Image.asset(AppImage.profile);
                    },
                  ),
                ),
              ),
              sectedicon: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: SizedBox(
                    width: 35.0,
                    height: 35.0,
                    child: CachedNetworkImage(
                      imageUrl: _controller.data[CS.image_path].toString() +
                          _controller.data[CS.image].toString(),
                      errorWidget: (context, url, error) {
                        return Image.asset(AppImage.profile);
                      },
                    )),
              )),
        ],
        onTabChangedListener: (position) {
          _controller.bottomCurrentPage.value = position;
          switch (position) {
            case 0:
              _controller.bottomCurrentPage.value = 0;
              break;
            case 1:
              _controller.bottomCurrentPage.value = 1;
              break;
          }
        },
      ),
    );
  }
}



// class StudentMainScreen extends StatelessWidget {
//   StudentMainScreen({super.key});
//   final StudentMainController _controller = Get.put(StudentMainController());

//   @override
//   Widget build(BuildContext context) {
//     return ZoomDrawer(
//       menuBackgroundColor: AppColor.secondaryColor,
//       controller: _controller.drawerController,
//       menuScreen: menuScreen(),
//       mainScreen: mainScreen(),
//       borderRadius: 24,
//       showShadow: false,
//       angle: 0.0,
//       openCurve: Curves.fastOutSlowIn,
//       slideWidth: MediaQuery.of(context).size.width * 0.85,
//     );
//   }

//   mainScreen() {
//     return Scaffold(
//       key: _controller.scaffoldkey,
//       body: const Column(
//         children: [],
//       ),
//     );
//   }

//   menuScreen() {
//     return Container(
//       width: Get.width,
//       color: AppColor.secondaryColor,
//       height: Get.height,
//       child: Row(
//         children: [
//           Container(
//             // width: Get.width * .77,
//             height: Get.height,
//             color: AppColor.secondaryColor,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () {
//                         _controller.drawerController.close!();
//                         _controller.selectedDrawerFragmentIndex.value = 4;
//                       },
//                       child: Container(
//                         alignment: Alignment.topLeft,
//                         padding: const EdgeInsets.fromLTRB(24, 60, 16, 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(50)),
//                               child: SizedBox(
//                                 width: 75,
//                                 height: 75,
//                                 child: CU.loadImage(
//                                     url: _controller.data[CS.image_path] +
//                                         _controller.data[CS.image],
//                                     errorIcon: "assets/images/profile.png"),
//                               ),
//                             ),
//                             hSizeBox8,
//                             Text(
//                               _controller.data[CS.first_name] +
//                                   " " +
//                                   _controller.data[CS.last_name],
//                               textAlign: TextAlign.left,
//                               style: const TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                             hSizeBox4,
//                             Text(
//                               "Division : ${_controller.data[CS.division]}",
//                               textAlign: TextAlign.left,
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.white70,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   if (_controller.drawerOptions.isEmpty)
//                     Container()
//                   else
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: _controller.drawerOptions,
//                     ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
