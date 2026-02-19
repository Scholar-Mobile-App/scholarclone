import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/social_collabrative/social_collabrative_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

class SocialCollabrativeScreen extends StatelessWidget {
  SocialCollabrativeScreen({super.key});
  final SocialCollabrativeController _controller =
      Get.put(SocialCollabrativeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        "Social Collaborative",
        rounded: false,
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.socialCollabrativeList.isEmpty
                ? CU.getNodataDesign()
                : Stack(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: CU.primaryColor,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                      ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _controller.socialCollabrativeList.length,
                        separatorBuilder: (context, index) => hSizeBox10,
                        itemBuilder: (context, index) {
                          var socialCollabrative =
                              _controller.socialCollabrativeList[index];

                          return Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.grey.shade100,
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: CU.pink,
                                      radius: 5,
                                    ),
                                    wSizeBox6,
                                    Text(
                                      socialCollabrative.createdAt.toString(),
                                      style: const TextStyle(
                                          fontSize: 8,
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    if (socialCollabrative.fileName!.isNotEmpty)
                                      GestureDetector(
                                        onTap: () {
                                          downloadExport(
                                            context: context,
                                            fileUrl:
                                                socialCollabrative.fileName!,
                                            filename:
                                                socialCollabrative.fileName!,
                                            open: true,
                                          );
                                        },
                                        child: Image.asset(
                                          AppImage.icnAttached,
                                          height: 16,
                                          width: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                  ],
                                ),
                                hSizeBox6,
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    socialCollabrative.title ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12),
                                  ),
                                ),
                                hSizeBox6,
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    socialCollabrative.description ?? "",
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                                Column(
                                  children: [
                                    for (int i = 0;
                                        i <
                                            socialCollabrative
                                                .conversationData!.length;
                                        i++)
                                      textContainer(
                                        title: socialCollabrative
                                                .conversationData![i].message ??
                                            "",
                                        date: socialCollabrative
                                            .conversationData![i].createdAt
                                            .toString(),
                                        name: socialCollabrative
                                                .conversationData![i]
                                                .studentName ??
                                            "",
                                      )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
      ),
    );
  }

  textContainer({
    String? title,
    bool divider = true,
    String? date,
    String? name,
  }) =>
      Column(
        children: [
          hSizeBox12,
          if (divider)
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: Get.width,
              height: 0.3,
              color: Colors.grey,
            ),
          hSizeBox6,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: Get.width * 1,
                child: Text(
                  title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              hSizeBox6,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 7,
                    width: 7,
                    child: CircleAvatar(
                      backgroundColor: CU.pink,
                      radius: 5,
                    ),
                  ),
                  wSizeBox6,
                  Text(
                    date!,
                    style: const TextStyle(
                      fontSize: 8,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 7,
                    width: 7,
                    child: CircleAvatar(
                      backgroundColor: CU.blue,
                      radius: 5,
                    ),
                  ),
                  wSizeBox6,
                  Text(
                    "By $name",
                    style: const TextStyle(
                      fontSize: 8,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
