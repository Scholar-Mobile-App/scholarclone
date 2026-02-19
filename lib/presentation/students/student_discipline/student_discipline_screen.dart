import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import 'student_discipline_controller.dart';

class StudentDisciplineScreen extends StatelessWidget {
  StudentDisciplineScreen({super.key});
  final StudentDisciplineController _controller =
      Get.put(StudentDisciplineController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          'Student Discipline',
          rounded: false,
        ),
        body: Stack(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
            _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : _controller.disciplineList.isEmpty
                    ? CU.getNodataDesign()
                    : ListView.separated(
                        padding: const EdgeInsets.all(20),
                        physics: const ClampingScrollPhysics(),
                        itemCount: _controller.disciplineList.length,
                        separatorBuilder: (context, index) => hSizeBox18,
                        itemBuilder: (context, index) {
                          var data = _controller.disciplineList[index];

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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: AssetImage(AppImage.profile),
                                ),
                                wSizeBox16,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.message!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      hSizeBox6,
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppImage.calendar,
                                            height: 12,
                                            color: AppColor.textColorlight,
                                          ),
                                          wSizeBox6,
                                          Text(
                                            DateFormat('dd MMMM yyyy')
                                                .format(data.disciplineDate!),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.textColorlight,
                                              fontSize: 12.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.green,
                                      ),
                                    ),
                                    child: Text(
                                      data.discipline ?? "",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
          ],
        ),
      ),
    );
  }
}
