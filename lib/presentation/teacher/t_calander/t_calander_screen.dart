import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

import '../../widgets/app_button.dart';
import 't_calander_controller.dart';

class TeacherCalanderScreen extends StatelessWidget {
  TeacherCalanderScreen({super.key});
  final TeacherCalanderController _controller =
      Get.put(TeacherCalanderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: 'Calendar'),
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
            Column(
              children: [
                searchAndFilterBox(),
                Expanded(
                  child: _controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : _controller.filterteacherList.isEmpty
                          ? CU.getNodataDesign()
                          : ListView.separated(
                              padding: const EdgeInsets.all(20),
                              itemCount: _controller.filterteacherList.length,
                              separatorBuilder: (context, index) => hSizeBox10,
                              itemBuilder: (context, index) {
                                var filterteacherList =
                                    _controller.filterteacherList[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "|",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: "Event" ==
                                                      (allWordsCapitilize(
                                                          filterteacherList
                                                              .eventType!))
                                                  ? Colors.green
                                                  : "Holiday" ==
                                                          (allWordsCapitilize(
                                                              filterteacherList
                                                                      .eventType ??
                                                                  ""))
                                                      ? CU.textSubjectName
                                                      : CU.secondaryColor,
                                            ),
                                          ),
                                          wSizeBox2,
                                          Text(
                                            allWordsCapitilize(
                                                filterteacherList.eventType ??
                                                    ""),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: "Event" ==
                                                      (allWordsCapitilize(
                                                          filterteacherList
                                                                  .eventType ??
                                                              ""))
                                                  ? Colors.green
                                                  : "Holiday" ==
                                                          (allWordsCapitilize(
                                                              filterteacherList
                                                                      .eventType ??
                                                                  ""))
                                                      ? CU.textSubjectName
                                                      : CU.secondaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      hSizeBox6,
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(filterteacherList.title ?? "",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            DateFormat('dd MMMM yyyy').format(
                                                filterteacherList.schoolDate!),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      hSizeBox6,
                                      Text(
                                        filterteacherList.description ?? "",
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  searchAndFilterBox() => Container(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.grey.shade100,
                spreadRadius: 1,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: dropDownTextField(
                title: "Select Section",
                list: _controller.stdName,
                key: _controller.sectionKey,
                onChanged: (value) {
                  for (int i = 0; i < _controller.stdList.length; i++) {
                    if (_controller.stdList[i].stdName == value) {
                      _controller.stdId.value = _controller.stdList[i].stdId!;
                      _controller.callServiceFetchData();
                      break;
                    }
                  }
                },
              ),
            ),
            wSizeBox14,
            Expanded(
              child: textField(
                title: "Select by Keyword",
                hintText: "Search",
                onChanged: (value) {
                  _controller.searchSubject.value = value;

                  if (_controller.searchSubject.value != "All") {
                    _controller.filterteacherList.value =
                        _controller.teacherFetchDataList
                            .where(
                              (element) => element.title!
                                  .toLowerCase()
                                  .contains(
                                      _controller.searchSubject.toLowerCase()),
                            )
                            .toList();
                  } else {
                    _controller.filterteacherList.value =
                        _controller.teacherFetchDataList;
                  }
                },
              ),
            )
          ],
        ),
      );

  String allWordsCapitilize(String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }
}
