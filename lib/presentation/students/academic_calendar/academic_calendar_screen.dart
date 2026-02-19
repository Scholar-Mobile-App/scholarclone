import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/students/academic_calendar/academic_calendar_controller.dart';
import 'package:scholar_clone/presentation/students/student_attendance/student_attendance_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/utils/cs.dart';

class AcademicCalendarScreen extends StatelessWidget {
  AcademicCalendarScreen({super.key});

  final AcademicCalendarController _controller =
      Get.put(AcademicCalendarController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          _controller.data.subTitle!,
          rounded: false,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      AppImage.leftIcon,
                      height: 22,
                      color: AppColor.secondaryColor,
                    ),
                    onPressed: () {
                      _controller.selectedDay.value = DateTime(
                          _controller.selectedDay.value.year,
                          _controller.selectedDay.value.month - 1);

                      _controller.currentMonth.value = DateFormat.yMMMM()
                          .format(_controller.selectedDay.value);

                      _controller.countDays();
                    },
                  ),
                  Expanded(
                    child: Text(
                      DateFormat('MMMM yyyy')
                          .format(_controller.selectedDay.value),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      AppImage.rightIcon,
                      height: 22,
                      color: AppColor.secondaryColor,
                    ),
                    onPressed: () {
                      _controller.selectedDay.value = DateTime(
                          _controller.selectedDay.value.year,
                          _controller.selectedDay.value.month + 1);

                      _controller.currentMonth.value = DateFormat.yMMMM()
                          .format(_controller.selectedDay.value);

                      _controller.countDays();
                    },
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  top: 14.0, bottom: 14.0, left: 8, right: 8),
              child: Row(
                children: [
                  Expanded(
                    child: countContainer(
                      color: AppColor.secondaryColor,
                      countDays: _controller.holiday.value.toString(),
                      dayType: "Holiday",
                    ),
                  ),
                  Expanded(
                    child: countContainer(
                      color: AppColor.greenColor,
                      countDays: _controller.event.value.toString(),
                      dayType: "Event",
                    ),
                  ),
                  Expanded(
                    child: countContainer(
                      color: AppColor.heliotropeColor,
                      countDays: _controller.vacation.value.toString(),
                      dayType: "Vacation",
                    ),
                  ),
                  // Expanded(
                  //   child: countContainer(
                  //     color: AppColor.redColor,
                  //     countDays: _controller.notice.value.toString(),
                  //     dayType: "Notice",
                  //   ),
                  // ),
                ],
              ),
            ),
            hSizeBox20,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TableCalendar(
                onCalendarCreated: (pageController) {},
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                firstDay: DateTime.now().subtract(const Duration(days: 3600)),
                lastDay: DateTime.now().add(const Duration(days: 3600)),
                focusedDay: _controller.selectedDay.value,
                calendarFormat: CalendarFormat.month,
                daysOfWeekHeight: 50,
                daysOfWeekStyle: const DaysOfWeekStyle(),
                selectedDayPredicate: (day) {
                  return isSameDay(_controller.selectedDay.value, day);
                },
                headerVisible: false,
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                onPageChanged: (focusedDay) {
                  _controller.selectedDay.value = focusedDay;
                },
                onFormatChanged: (format) {
                  _controller.calendarFormat = format;
                },
                onDaySelected: (selectedDay, focusedDay) {
                  _controller.eventList.clear();
                  _controller.selectedDay.value = selectedDay;

                  _controller.currentMonth.value =
                      DateFormat.yMMMM().format(selectedDay);

                  String now = DateFormat("yyyy-MM-dd").format(selectedDay);
                  for (var i = 0;
                      i < (_controller.resJson[CS.data] as List).length;
                      i++) {
                    if (now ==
                        _controller.resJson[CS.data][i][CS.school_date]) {
                      _controller.eventList.add(EventData(
                          colorText: _controller.resJson[CS.data][i]
                              [CS.event_type],
                          description: _controller.resJson[CS.data][i]
                              [CS.description],
                          title: _controller.resJson[CS.data][i][CS.title]));
                      log("......${_controller.eventList.length}");
                    }
                  }
                },
                calendarBuilders: CalendarBuilders(
                  // Customize the date cell builder
                  defaultBuilder: (context, date, events) =>
                      _buildDateCell(date),
                  todayBuilder: (context, date, events) => _buildDateCell(date),
                  selectedBuilder: (context, date, events) =>
                      _buildDateCell(date),
                  dowBuilder: (context, day) {
                    return Center(
                      child: Text(
                        DateFormat.E().format(day).substring(0, 1),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: _controller.eventList.isNotEmpty,
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: const EdgeInsets.all(10),
                child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 0, right: 0),
                    child: Column(
                      children: List.generate(
                        _controller.eventList.length,
                        (index) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 0, bottom: 0, left: 16, right: 0),
                              child: Text(
                                "${_controller.eventList[index].title} : ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _controller.textColor(
                                      _controller.eventList[index].colorText),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 0, right: 16),
                                child: Text(
                                  _controller.eventList[index].description,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _controller.textColor(
                                        _controller.eventList[index].colorText),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.only(
                    //           top: 0, bottom: 0, left: 16, right: 0),
                    //       child: (_controller.isNormalDay.value)
                    //           ? const Text("")
                    //           : Text(
                    //               "${_controller.title.value} : ",
                    //               style: TextStyle(
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: _controller
                    //                     .textColor(_controller.colortext.value),
                    //               ),
                    //             ),
                    //     ),
                    //     Flexible(
                    //       child: Container(
                    //         padding: const EdgeInsets.only(
                    //             top: 0, bottom: 0, left: 0, right: 16),
                    //         child: (_controller.isNormalDay.value)
                    //             ? const Text("")
                    //             : Text(
                    //                 _controller.description.value,
                    //                 style: TextStyle(
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.bold,
                    //                   color: _controller
                    //                       .textColor(_controller.colortext.value),
                    //                 ),
                    //               ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDateCell(DateTime date) {
    final dateItem = _controller.dates.firstWhere(
      (item) => isSameDay(item.date, date),
      orElse: () => DateItem(
          date: date, type: "default"), // Use 'default' if date not found
    );

    log("----------------${dateItem.type}--------------------");

    // Customize the cell color based on the date type
    Color cellColor;
    Color textColor;
    switch (dateItem.type) {
      case 'vacation':
        cellColor = AppColor.heliotropeColor;
        textColor = Colors.white;
        break;
      case 'holiday':
        cellColor = AppColor.secondaryColor;
        textColor = Colors.white;
        break;
      case 'event':
        cellColor = AppColor.greenColor;
        textColor = Colors.white;
        break;
      case 'notice':
        cellColor = AppColor.redColor;
        textColor = Colors.white;
        break;

      default:
        cellColor = Colors.white;
        textColor = Colors.black;
    }

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: cellColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '${date.day}',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container countContainer({
    required Color color,
    required String countDays,
    required String dayType,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: countDays,
          style: const TextStyle(
              fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600),
          children: [
            TextSpan(
                text: '\n$dayType',
                style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
