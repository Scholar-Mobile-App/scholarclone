import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/students/student_attendance/student_attendance_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class StudentAttendanceScreen extends StatelessWidget {
  StudentAttendanceScreen({super.key});
  final StudentAttendanceController _controller =
      Get.put(StudentAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(_controller.data.subTitle!),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              // ClipRRect(
              //   borderRadius: const BorderRadius.vertical(
              //     bottom: Radius.circular(24),
              //   ),
              //   child: Container(
              //     height: 85,
              //     width: double.infinity,
              //     color: AppColor.secondaryColor,
              //     child: Stack(
              //       children: [
              //         Container(
              //           alignment: Alignment.bottomLeft,
              //           padding: const EdgeInsets.only(left: 20),
              //           child: Image.asset(
              //             AppImage.halfwatch,
              //             height: 70,
              //           ),
              //         ),
              //         Container(
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 child: Container(),
              //               ),
              //               const Text(
              //                 "Present\nDays",
              //                 textAlign: TextAlign.right,
              //                 style: TextStyle(
              //                     height: .9,
              //                     color: Colors.white,
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w500),
              //               ),
              //               wSizeBox8,
              //               Text(
              //                 _controller.allpresent.value.toString(),
              //                 textAlign: TextAlign.right,
              //                 style: TextStyle(
              //                   color: AppColor.primaryColor,
              //                   fontSize: 40,
              //                   fontWeight: FontWeight.w600,
              //                 ),
              //               ),
              //               Text(
              //                 "/${(_controller.allpresent.value + _controller.allabsent.value).toString()}",
              //                 textAlign: TextAlign.right,
              //                 style: const TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 40,
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ),
              //               wSizeBox8,
              //               const Text(
              //                 "Total\nDays",
              //                 textAlign: TextAlign.right,
              //                 style: TextStyle(
              //                     height: .9,
              //                     color: Colors.white,
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w500),
              //               ),
              //               wSizeBox20,
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                child: Container(
                  color: AppColor.bgColor,
                  child: SingleChildScrollView(
                    child: Column(
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
                                  // _controller.selectedDate = DateTime(
                                  //     _controller.selectedDate.year,
                                  //     _controller.selectedDate.month - 1);
                                  // _controller.currentMonth = DateFormat.yMMMM()
                                  //     .format(_controller.selectedDate);
                                  // // _controller.state
                                  // //     .setCurrentDate(_controller.selectedDate);
                                  // _controller.countDays();

                                  _controller.focusedDay.value = DateTime(
                                      _controller.focusedDay.value.year,
                                      _controller.focusedDay.value.month - 1);

                                  _controller.currentMonth.value =
                                      DateFormat.yMMMM()
                                          .format(_controller.focusedDay.value);

                                  _controller.countDays();
                                },
                              ),
                              Expanded(
                                child: Text(
                                  DateFormat('MMMM yyyy')
                                      .format(_controller.focusedDay.value),
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
                                  // _controller.selectedDate = DateTime(
                                  //     _controller.selectedDate.year,
                                  //     _controller.selectedDate.month + 1);
                                  // _controller.currentMonth = DateFormat.yMMMM()
                                  //     .format(_controller.selectedDate);
                                  // // _controller.state
                                  // //     .setCurrentDate(_controller.selectedDate);
                                  // _controller.countDays();

                                  _controller.focusedDay.value = DateTime(
                                      _controller.focusedDay.value.year,
                                      _controller.focusedDay.value.month + 1);

                                  _controller.currentMonth.value =
                                      DateFormat.yMMMM()
                                          .format(_controller.focusedDay.value);

                                  _controller.countDays();
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          margin: const EdgeInsets.only(
                            top: 2.0,
                          ),
                          padding: const EdgeInsets.only(
                              top: 14.0, bottom: 14.0, left: 8, right: 8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.greenColor,
                                  ),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text:
                                          _controller.present.value.toString(),
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                      children: const <TextSpan>[
                                        TextSpan(
                                            text: '\nPresent',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.redColor,
                                  ),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: _controller.absent.value.toString(),
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                      children: const <TextSpan>[
                                        TextSpan(
                                            text: '\nAbsent',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.secondaryColor,
                                  ),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: _controller.holiday.toString(),
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                      children: const <TextSpan>[
                                        TextSpan(
                                            text: '\nHoliday',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: Container(
                              //     margin:
                              //         const EdgeInsets.symmetric(horizontal: 4),
                              //     padding:
                              //         const EdgeInsets.symmetric(vertical: 12),
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(20),
                              //       color: AppColor.primaryColor,
                              //     ),
                              //     child: RichText(
                              //       textAlign: TextAlign.center,
                              //       text: TextSpan(
                              //         text: _controller.event.toString(),
                              //         style: const TextStyle(
                              //             fontSize: 16.0,
                              //             color: Colors.white,
                              //             fontWeight: FontWeight.w600),
                              //         children: const <TextSpan>[
                              //           TextSpan(
                              //               text: '\nEvents',
                              //               style: TextStyle(
                              //                   fontSize: 14.0,
                              //                   color: Colors.white,
                              //                   fontWeight: FontWeight.w400)),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Expanded(
                              //   child: Container(
                              //     margin:
                              //         const EdgeInsets.symmetric(horizontal: 4),
                              //     padding:
                              //         const EdgeInsets.symmetric(vertical: 12),
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(20),
                              //       color: AppColor.heliotropeColor,
                              //     ),
                              //     child: RichText(
                              //       textAlign: TextAlign.center,
                              //       text: TextSpan(
                              //         text: _controller.vacation.toString(),
                              //         style: const TextStyle(
                              //             fontSize: 16.0,
                              //             color: Colors.white,
                              //             fontWeight: FontWeight.w600),
                              //         children: const <TextSpan>[
                              //           TextSpan(
                              //               text: '\nVacation',
                              //               style: TextStyle(
                              //                   fontSize: 14.0,
                              //                   color: Colors.white,
                              //                   fontWeight: FontWeight.w400)),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        //                       Container(
                        //                         padding: const EdgeInsets.only(
                        //                             top: 12, bottom: 12, left: 12, right: 12),
                        //                         child: ClipRRect(
                        //                           borderRadius: BorderRadius.circular(20),
                        //                           child: Material(
                        //                             elevation: 2,
                        //                             child: Calendarro(
                        //                               // selectedDates: Cell[CS.data] != null ? Cell[CS.data] : List(),
                        //                               selectedDates: _controller.selectedDates ??
                        //                                   [
                        //                                     {
                        //                                       "day": DateFormat("yyyy-MM-dd")
                        //                                           .format(DateTime.now()),
                        //                                       "status": "1",
                        //                                       "color": Colors.transparent,
                        //                                     },
                        //                                   ],
                        //                               displayMode: DisplayMode.MONTHS,
                        //                               selectionMode: SelectionMode.MULTI,
                        //                               selectedDate: _controller.selectedDate,
                        //                               state: _controller.state,
                        //                               startDate: DateTime.now()
                        //                                   .subtract(const Duration(days: 3600)),
                        //                               endDate: DateTime.now()
                        //                                   .add(const Duration(days: 3600)),
                        //                               onPageSelected: (DateTime pageStartDate,
                        //                                   DateTime pageEndDate) {
                        //                                 _controller.currentMonth =
                        //                                     DateFormat.yMMMM().format(pageStartDate);
                        //                                 _controller.countDays();
                        //                               },
                        //                               onTap: (datetime) {},
                        // //                startDate: DateUtils.getFirstDayOfCurrentMonth(),
                        // //                endDate: DateUtils.getLastDayOfCurrentMonth()),
                        //                             ),
                        //                           ),
                        //                         ),
                        //                       ),
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
                            firstDay: DateTime.now()
                                .subtract(const Duration(days: 3600)),
                            lastDay:
                                DateTime.now().add(const Duration(days: 3600)),
                            focusedDay: _controller.focusedDay.value,
                            calendarFormat: CalendarFormat.month,
                            daysOfWeekHeight: 50,
                            daysOfWeekStyle: const DaysOfWeekStyle(),
                            selectedDayPredicate: (day) {
                              // Return true if the day is selected
                              return isSameDay(
                                  _controller.selectedDay.value, day);
                            },
                            headerVisible: false,
                            calendarStyle: const CalendarStyle(
                              outsideDaysVisible: false,
                            ),
                            onPageChanged: (focusedDay) {
                              _controller.focusedDay.value = focusedDay;
                            },
                            onFormatChanged: (format) {
                              _controller.calendarFormat = format;
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              _controller.selectedDay.value = selectedDay;
                              _controller.focusedDay.value = focusedDay;

                              _controller.currentMonth.value =
                                  DateFormat.yMMMM().format(selectedDay);
                            },
                            calendarBuilders: CalendarBuilders(
                              // Customize the date cell builder
                              defaultBuilder: (context, date, events) =>
                                  _buildDateCell(date),
                              todayBuilder: (context, date, events) =>
                                  _buildDateCell(date),
                              selectedBuilder: (context, date, events) =>
                                  _buildDateCell(date),
                              // dowBuilder: (context, day) {
                              //   return Center(
                              //     child: Text(
                              //       DateFormat.E().format(day).substring(0, 1),
                              //       style: const TextStyle(
                              //         color: Colors.grey,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   );
                              // },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateCell(DateTime date) {
    final dateItem = _controller.dates.firstWhere(
      (item) => isSameDay(item.date, date),
      orElse: () => DateItem(
          date: date, type: 'default'), // Use 'default' if date not found
    );

    log("----------------${dateItem.type}--------------------");

    // Customize the cell color based on the date type
    Color cellColor;
    Color textColor;
    switch (dateItem.type) {
      case 'Holiday':
        cellColor = AppColor.secondaryColor;
        textColor = Colors.white;
        break;
      // // case 'Event':
      // //   cellColor = AppColor.primaryColor;
      // //   textColor = Colors.white;
      // //   break;
      // // case 'Vacation':
      // //   cellColor = AppColor.heliotropeColor;
      // //   textColor = Colors.white;
      //   break;
      case 'P':
        cellColor = AppColor.greenColor;
        textColor = Colors.white;
        break;
      case 'A':
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
}
