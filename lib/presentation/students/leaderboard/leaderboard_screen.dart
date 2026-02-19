import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/leaderboard/leaderboard_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});
  final LeaderboardController _controller = Get.put(LeaderboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        "LMS LeaderBoard",
        rounded: false,
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? const CircularProgressIndicator.adaptive()
            : _controller.leaderboardList.isEmpty
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
                        itemCount: _controller.leaderboardList.length,
                        separatorBuilder: (context, index) => hSizeBox10,
                        itemBuilder: (context, index) {
                          var leaderboard = _controller.leaderboardList[index];
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
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        index + 1 == 1
                                            ? leaderboard.totalPoints.toString()
                                            : index + 1 == 2
                                                ? leaderboard.studentRank
                                                    .toString()
                                                : leaderboard.myTier.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25,
                                        ),
                                      ),
                                      hSizeBox20,
                                      Text(
                                        leaderboard.type.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: CU.textColorlight,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: AssetImage(AppImage.profile),
                                ),
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
}
