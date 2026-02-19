import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/teacher/t_social_collobrative/t_social_collobrative_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

class TeacherSocialCollobrativeScreen extends StatelessWidget {
  TeacherSocialCollobrativeScreen({super.key});
  final TeacherSocialCollobrativeController _controller =
      Get.put(TeacherSocialCollobrativeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Social Collaborative"),
      body: Obx(
        () => _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.socialCollobrativeModel!.data!.isEmpty
                ? CU.getNodataDesign()
                : Stack(
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
                      ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        itemCount:
                            _controller.socialCollobrativeModel!.data!.length,
                        separatorBuilder: (context, index) => hSizeBox10,
                        itemBuilder: (context, index) {
                          var socialCollabrative = _controller
                              .socialCollobrativeModel!.data!.entries
                              .elementAt(index)
                              .value;

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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: Get.width * 0.18,
                                      width: Get.width * 0.18,
                                      margin: const EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            socialCollabrative.image!,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  socialCollabrative
                                                          .studentName ??
                                                      "",
                                                  style: TextStyle(
                                                    color: CU.tprimaryColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "   Question",
                                                style: TextStyle(
                                                  color: CU.redColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          hSizeBox6,
                                          Text(
                                            "Father ${socialCollabrative.studentName}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                          hSizeBox6,
                                          Text(
                                            "Date: ${DateFormat('MMM dd, yyyy hh:mm').format(socialCollabrative.createdAt!)}",
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     CircleAvatar(
                                //       backgroundColor: CU.pink,
                                //       radius: 5,
                                //     ),
                                //     wSizeBox6,
                                //     Text(
                                //       socialCollabrative.createdAt.toString(),
                                //       style: const TextStyle(
                                //           fontSize: 8,
                                //           color: Colors.grey,
                                //           fontStyle: FontStyle.italic),
                                //     ),
                                //     Expanded(
                                //       child: Container(),
                                //     ),
                                //     if (socialCollabrative.fileName!.isNotEmpty)
                                //       GestureDetector(
                                //         onTap: () {
                                //           downloadExport(
                                //             context: context,
                                //             fileUrl:
                                //                 socialCollabrative.fileName!,
                                //             filename:
                                //                 socialCollabrative.fileName!,
                                //             open: true,
                                //           );
                                //         },
                                //         child: Image.asset(
                                //           AppImage.icnAttached,
                                //           height: 16,
                                //           width: 16,
                                //           color: Colors.grey,
                                //         ),
                                //       ),
                                //   ],
                                // ),
                                // hSizeBox6,
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 10),
                                //   child: Text(
                                //     socialCollabrative.title ?? "",
                                //     style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         color: Colors.black,
                                //         fontSize: 12),
                                //   ),
                                // ),
                                hSizeBox10,
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    socialCollabrative.description ?? "",
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                                hSizeBox10,
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: socialCollabrative
                                      .conversationData!.length,
                                  separatorBuilder: (context, index) =>
                                      hSizeBox4,
                                  itemBuilder: (context, index) {
                                    var conversationData = socialCollabrative
                                        .conversationData![index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      conversationData.image!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            wSizeBox6,
                                            Expanded(
                                              child: Text(
                                                "  ${conversationData.studentName}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              "    Replayed",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Date: ${conversationData.commentDate}",
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                                // Column(
                                //   children: [
                                //     for (int i = 0;
                                //         i <
                                //             socialCollabrative
                                //                 .conversationData!.length;
                                //         i++)
                                //       textContainer(
                                //         title: socialCollabrative
                                //                 .conversationData![i].message ??
                                //             "",
                                //         date: socialCollabrative
                                //             .conversationData![i].createdAt
                                //             .toString(),
                                //         name: socialCollabrative
                                //                 .conversationData![i]
                                //                 .studentName ??
                                //             "",
                                //       )
                                //   ],
                                // )
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
