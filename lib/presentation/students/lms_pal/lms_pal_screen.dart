import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import '../../../core/utils/cu.dart';
import '../../widgets/app_bar.dart';

import 'package:path/path.dart' as p;

import 'lms_pal_controller.dart';

class PalScreen extends StatelessWidget {
  PalScreen({super.key});
  final PalController _controller = Get.put(PalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        _controller.data.subTitle ?? "",
      ),
      body: Obx(
        () => _controller.isLoading.value == true
            ? const Center(child: CircularProgressIndicator.adaptive())
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Subject",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                      hSizeBox20,
                      GridView.count(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: .9,
                        children: List.generate(
                            _controller.lmsSubjectModel!.data!.length, (index) {
                          var data = _controller.lmsSubjectModel!.data![index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.chapter,
                                arguments: [
                                  data,
                                  _controller.userInfo,
                                ],
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(1),
                              // color: Colors.amber,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: Stack(
                                        children: [
                                          if (p.extension(data.displayImage!) ==
                                              ".svg")
                                            SvgPicture.network(
                                              data.displayImage!,
                                              height: 45.0,
                                              width: 45.0,
                                            )
                                          else
                                            CU.loadImage(
                                              url: data.displayImage!,
                                              height: 45.0,
                                              width: 45.0,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      data.displayName!,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: CU.textColorDark,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
