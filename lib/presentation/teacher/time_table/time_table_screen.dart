import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import 'time_table_controller.dart';

class TeacherTimetableScreen extends StatelessWidget {
  TeacherTimetableScreen({super.key});
  final TeacherTimetableController _controller =
      Get.put(TeacherTimetableController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Time Table"),
        body: Stack(
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
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 18, top: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: _buildTableCalendar(),
                ),
                Expanded(
                  child: (_controller.selectDay.value == "Sun")
                      ? CU.getNodataDesign()
                      : _controller.tempLstData == null
                          ? CU.getCircularProgressIndicator()
                          : _controller.tempLstData.isEmpty
                              ? CU.getNodataDesign()
                              : _buildEventList(_controller.tempLstData),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildTableCalendar() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 6.0, left: 6.0),
      child: Row(
        children: [
          _dayofWeek(title: "M", main: "Mon"),
          _dayofWeek(title: "T", main: "Tue"),
          _dayofWeek(title: "W", main: "Wed"),
          _dayofWeek(title: "H", main: "H"),
          _dayofWeek(title: "F", main: "Fri"),
          _dayofWeek(title: "S", main: "Sat"),
        ],
      ),
    );
  }

  Widget _dayofWeek({required String title, required String main}) {
    //bool isShowCircle = false;
    return Expanded(
        child: GestureDetector(
      onTap: () {
        if (main == "Thu") {
          main = "H";
        }
        _controller.selectDay.value = main;

        log(main.toString());
        _controller.filterListday(_controller.lstData, main);
      },
      child: _controller.selectDay.value == main
          ? Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )
          : Container(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
    ));
  }

  _buildEventList(itemData) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView(
        children: itemData
            .map<Widget>(
              (event) => InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Color(0xFF9f9f9f)),
                                  ),
                                ),
                                child: Text(
                                  event["periodname"] ?? "",
                                  style: TextStyle(
                                    color: CU.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                CU.isEmptyOrNull(event["lectures"])
                                    ? ""
                                    : event["lectures"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
