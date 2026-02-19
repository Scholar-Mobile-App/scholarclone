import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/timetable/timetable_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import '../../../core/utils/cs.dart';

class TimeTableScreen extends StatelessWidget {
  TimeTableScreen({super.key});
  final TimeTableController _controller = Get.put(TimeTableController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(_controller.data.subTitle!),
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFf4f5f7),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  //              color: CU.secondaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: buildTableCalendar(),
              ),
              const SizedBox(height: 2.0),
              Expanded(
                child: _controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : _controller.tempLstData.isEmpty
                        ? CU.getNodataDesign()
                        : ListView(
                            children: _controller.tempLstData.map((event) {
                              return InkWell(
                                onTap: () {
                                  // print((itemData.indexOf(event) % 4).toString());
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    color: colorsList[
                                        _controller.tempLstData.indexOf(event) %
                                            4],
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(12.0),
                                    margin: const EdgeInsets.only(left: 6),
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
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                  CU.isEmptyOrNull(
                                                          event[CS.start_time])
                                                      ? ""
                                                      : /*itemData[CS.start_time]*/ "",
                                                  style: TextStyle(
                                                      color: CU.textColorlight,
                                                      fontSize: 12)),
                                              Text("-",
                                                  style: TextStyle(
                                                      color:
                                                          CU.textColorlight)),
                                              Text(
                                                  CU.isEmptyOrNull(
                                                          event[CS.end_time])
                                                      ? ""
                                                      : /*itemData[CS.end_time]*/ "",
                                                  style: TextStyle(
                                                      color: CU.textColorlight,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: AppColor.textColorlight,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                  CU.isEmptyOrNull(
                                                          event[CS.start_time])
                                                      ? ""
                                                      : /*itemData[CS.start_time]*/ "",
                                                  style: TextStyle(
                                                      color: CU.textColorlight,
                                                      fontSize: 12)),
                                              Container(
                                                width: 1,
                                              ),
                                              Text("",
                                                  style: TextStyle(
                                                      color:
                                                          CU.textColorlight)),
                                              Text(
                                                  CU.isEmptyOrNull(
                                                          event[CS.end_time])
                                                      ? ""
                                                      : /*itemData[CS.end_time]*/ "",
                                                  style: TextStyle(
                                                      color: CU.textColorlight,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            // color: Colors.blue,
                                            margin: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                    CU.isEmptyOrNull(event[
                                                            CS.subject_name])
                                                        ? ""
                                                        : event[
                                                            CS.subject_name],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            CU.secondaryColor)),
                                                hSizeBox10,
                                                Text(
                                                    CU.isEmptyOrNull(event[
                                                            CS.teacher_name])
                                                        ? ""
                                                        : event[
                                                            CS.teacher_name],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            CU.textColorlight,
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text("Period",
                                                  style: TextStyle(
                                                      color:
                                                          CU.textColorlight)),
                                              hSizeBox10,
                                              Text(
                                                  CU.isEmptyOrNull(
                                                          event[CS.period_name])
                                                      ? (_controller.tempLstData
                                                                  .indexOf(
                                                                      event) +
                                                              1)
                                                          .toString()
                                                      : event[CS.period_name],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: CU.textColorlight,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
              )
              // Expanded(
              //   child: tempLstData == null
              //       ? CU.getCircularProgressIndicator()
              //       : tempLstData.length == 0
              //           ? CU.getNodataDesign()
              //           : _buildEventList(tempLstData),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  buildTableCalendar() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 22.0, bottom: 22.0, right: 6.0, left: 6.0),
      child: Row(
        children: [
          _dayofWeek(title: "Mon"),
          _dayofWeek(title: "Tue"),
          _dayofWeek(title: "Wed"),
          _dayofWeek(title: "Thu"),
          _dayofWeek(title: "Fri"),
          _dayofWeek(title: "Sat"),
          _dayofWeek(title: "Sun"),
        ],
      ),
    );
  }

  Widget _dayofWeek({required String title}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _controller.filterListday(_controller.lstData, title);
        },
        child: _controller.selectDay.value == title
            ? CircleAvatar(
                backgroundColor: AppColor.primaryColor,
                radius: 18.0,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              )
            : Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
