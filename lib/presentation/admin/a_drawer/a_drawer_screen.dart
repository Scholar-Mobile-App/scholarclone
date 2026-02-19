import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';
import 'package:scholar_clone/presentation/admin/admin_main/admin_main_controller.dart';
import 'package:scholar_clone/routes/app_routes.dart';
import 'package:share_plus/share_plus.dart';

class AdminDrawer extends StatelessWidget {
  AdminDrawer({
    super.key,
  });

  final AdminMainController _controller = Get.put(AdminMainController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CU.secondaryColor,
      child: Column(
        children: [
          hBox(100),
          GestureDetector(
            onTap: () {
              // Get.toNamed(
              //   AppRoutes.ownProfile,
              //   arguments: [
              //     _controller.homeData!.data![_controller.typeIndex.value]
              //         .contents![_controller.screenIndex.value],
              //     _controller.userInfo,
              //   ],
              // );
            },
            child: Container(
              width: 70.0,
              height: 70.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: _controller.userInfo![CS.image],
                  placeholder: (context, url) {
                    return Image.asset(AppImage.profile);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppImage.profile);
                  },
                ),
              ),
            ),
          ),
          hSizeBox10,
          Text(
            "${_controller.userInfo!["first_name"]} ${_controller.userInfo!["last_name"]}",
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: Colors.white,
            ),
          ),
          drawerMenu(
            onTap: () {
              Get.back();
              // _controller.bottomCurrentPage.value = 0;
            },
            title: "Home",
          ),
          drawerMenu(
            onTap: () {
              Get.back();
              // _controller.bottomCurrentPage.value = 1;
            },
            title: "My Profile",
          ),
          // drawerMenu(
          //   onTap: () {
          //     Get.back();
          //     LaunchReview.launch(
          //       androidAppId: packageName,
          //       iOSAppId: buildNumber,
          //     );
          //   },
          //   title: "Rate",
          // ),
          drawerMenu(
            onTap: () {
              Get.back();
              // ShareExtend.share('$shareMessage\n\n$shareAppUrl', 'text');
              Share.share(
                '$shareMessage\n\n$shareAppUrl',
                subject: 'text',
              );
            },
            title: "Share",
          ),
          drawerMenu(
            onTap: () {
              LocalStorage.clearLocalData();
              Get.offNamedUntil(AppRoutes.splash, (route) => false);
            },
            title: "Logout",
          ),
          // (_controller.drawerOptions.isEmpty)
          //     ? Container()
          //     : Column(
          //         children: _controller.drawerOptions,
          //       ),
        ],
      ),
    );
  }

  ListTile drawerMenu({
    required Function() onTap,
    required String title,
  }) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
