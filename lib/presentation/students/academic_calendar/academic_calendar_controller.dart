import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/presentation/students/student_attendance/student_attendance_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/utils/cs.dart';
import '../../../core/utils/cu.dart';

class AcademicCalendarController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = {};

  RxString currentMonth = DateFormat.yMMMM().format(DateTime.now()).obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  RxList<DateItem> dates = <DateItem>[].obs;

  RxInt holiday = 0.obs;
  RxInt event = 0.obs;
  RxInt vacation = 0.obs;
  RxInt notice = 0.obs;

  // RxString title = "".obs;
  // RxString description = "".obs;
  // RxBool isNormalDay = true.obs;
  // RxString colortext = "".obs;

  RxList<EventData> eventList = <EventData>[].obs;

  RxList<dynamic> selectedDates = [].obs;

  CalendarFormat calendarFormat = CalendarFormat.month;

  @override
  void onInit() {
    callServicestudentCalender();
    super.onInit();
  }

  Future<void> callServicestudentCalender() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.student_id: userInfo[CS.student_id],
      CS.mobile_no: userInfo[CS.mobile],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/studentCalenderAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(
        Get.context!,
        callServicestudentCalender,
      );
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success.toString()) {
      countDays();
      selectedDates.value = [];
      resJson[CS.data].forEach((element) {
        selectedDates.add({
          "day": element[CS.school_date],
          "status": "1",
          "eventtype": element[CS.event_type],
          "color": getColorCode(element),
        });

        dates.add(
          DateItem(
            date: DateTime.parse(element[CS.school_date]),
            type: element[CS.event_type],
          ),
        );
      });
    } else if (resJson[CS.status].toString() == StatusCode.Error) {}
  }

  getColorCode(element) {
    if (element[CS.event_type].toString().toUpperCase() == "VACATION") {
      return CU.heliotropeColor;
    } else if (element[CS.event_type].toString().toUpperCase() == "HOLIDAY") {
      return CU.secondaryColor;
    } else if (element[CS.event_type].toString().toUpperCase() == "EVENT") {
      return CU.primaryColor;
    } else if (element[CS.event_type].toString().toUpperCase() == "HOLIDAY") {
      return CU.redColor;
    }
  }

  textColor(String type) {
    log(type);
    switch (type) {
      case 'vacation':
        return AppColor.heliotropeColor;

      case 'holiday':
        return AppColor.secondaryColor;

      case 'event':
        return AppColor.greenColor;

      case 'notice':
        return AppColor.redColor;

      default:
        Colors.black;
    }
  }

  countDays() {
    try {
      holiday.value = 0;
      vacation.value = 0;
      event.value = 0;
      notice.value = 0;

      resJson[CS.data].forEach((element) {
        if (currentMonth.value ==
                DateFormat.yMMMM().format(
                    DateFormat("yyyy-MM-dd").parse(element[CS.school_date])) &&
            element[CS.event_type].toString().toUpperCase() == "HOLIDAY") {
          holiday.value++;
        }
      });

      resJson[CS.data].forEach((element) {
        if (currentMonth.value ==
                DateFormat.yMMMM().format(
                    DateFormat("yyyy-MM-dd").parse(element[CS.school_date])) &&
            element[CS.event_type].toString().toUpperCase() == "EVENT") {
          event.value++;
        }
      });

      resJson[CS.data].forEach((element) {
        if (currentMonth.value ==
                DateFormat.yMMMM().format(
                    DateFormat("yyyy-MM-dd").parse(element[CS.school_date])) &&
            element[CS.event_type].toString().toUpperCase() == "VACATION") {
          vacation.value++;
        }
      });

      resJson[CS.data].forEach((element) {
        if (currentMonth.value ==
                DateFormat.yMMMM().format(
                    DateFormat("yyyy-MM-dd").parse(element[CS.school_date])) &&
            element[CS.event_type].toString().toUpperCase() == "NOTICE") {
          notice.value++;
        }
      });

      update();
    } catch (e) {
      log("ERROR $e");
    }
  }

  getAgo(strDate) {
    try {
      Duration diff = DateTime.now()
          .difference(DateFormat("yyyy-MM-dd hh:mm:ss").parse(strDate));
      if (diff.inMinutes == 0) {
        return "Just Now";
      } else if (diff.inMinutes < 60) {
        return "${diff.inMinutes} Min ago";
      } else if (diff.inHours < 24) {
        return "${diff.inHours} Hours ago";
      } else if (diff.inDays < 2) {
        return "${diff.inDays} Day ago";
      } else {
        return DateFormat('dd MMM yy hh:mm a')
            .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(strDate));
      }
    } catch (e) {
      return strDate;
    }
  }
}

class AcadaminCalendar {
  final DateTime date;
  final String type;
  final String title;
  final String description;

  AcadaminCalendar({
    required this.date,
    required this.type,
    required this.title,
    required this.description,
  });
}

class EventData {
  String title;
  String description;
  String colorText;

  EventData(
      {required this.colorText,
      required this.description,
      required this.title});
}
