import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';

import 't_mark_entry_controller.dart';

class MarksEntryResultScreen extends StatelessWidget {
  MarksEntryResultScreen({super.key});

  final MarksEntryResultController _controller =
      Get.put(MarksEntryResultController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(
        text: "Marks Entry",
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
            ListView(
              children: [
                examDetails(),
                studentsDetails(),
                hSizeBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppButton(
                    text: "Save",
                    onTap: () {
                      _controller.callServiceSubmit(context);
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

  Widget examDetails() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(
            title: "Term",
            value: _controller.tarmID.toString(),
          ),
          hSizeBox10,
          text(
            title: "Standard",
            value: _controller.standardName,
          ),
          hSizeBox10,
          text(
            title: "Division",
            value: _controller.divisionName,
          ),
          hSizeBox10,
          text(
            title: "Subject",
            value: _controller.subjectName,
          ),
          hSizeBox10,
          text(
            title: "Exam",
            value: _controller.examName,
          ),
        ],
      ),
    );
  }

  studentsDetails() => Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
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
            _controller.studentList.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      "No Data Found",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _controller.studentList.length,
                    itemBuilder: (context, index) {
                      var student = _controller.studentList[index];
                      return SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  student.studentName ?? "",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(left: 5),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        color: Colors.black, width: 1),
                                    right: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                ),
                                child: Text(
                                  student.rollNo.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    student.points = double.parse(value);
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    // isCollapsed: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
          ],
        ),
      );

  text({
    required String title,
    required String value,
  }) =>
      Text(
        "$title : $value",
        style: const TextStyle(
          fontSize: 16,
        ),
      );
}
