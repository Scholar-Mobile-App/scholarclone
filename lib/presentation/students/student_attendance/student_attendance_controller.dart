import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:scholar_clone/core/packages/CustomCalendar/custom_calendar.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/utils/api_client.dart';
import '../../../core/utils/cu.dart';
import '../../../core/utils/enum.dart';

class StudentAttendanceController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic>? resJson;

  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  RxString currentMonth = DateFormat.yMMMM().format(DateTime.now()).obs;

  RxInt holiday = 0.obs;
  // RxInt event = 0.obs;
  //RxInt vacation = 0.obs;
  RxInt present = 0.obs;
  RxInt absent = 0.obs;

  RxInt allpresent = 0.obs;
  RxInt intallabsent = 0.obs;
  RxInt allabsent = 0.obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  CalendarFormat calendarFormat = CalendarFormat.month;

  List<dynamic>? selectedDates;

  RxList<DateItem> dates = <DateItem>[].obs;

  List<dynamic> get attendanceData {
    final responseData = resJson?[CS.data];
    if (responseData is Map && responseData[CS.attendance_data] is List) {
      return responseData[CS.attendance_data] as List<dynamic>;
    }
    return <dynamic>[];
  }

  List<dynamic> get holidayData {
    final responseData = resJson?[CS.data];
    if (responseData is Map &&
        responseData[CS.calendar_data] is Map &&
        responseData[CS.calendar_data][CS.holiday] is List) {
      return responseData[CS.calendar_data][CS.holiday] as List<dynamic>;
    }
    return <dynamic>[];
  }

  countDays() {
    try {
      holiday.value = 0;
      absent.value = 0;
      present.value = 0;
      //vacation.value = 0;
      //event.value = 0;

      for (final element in attendanceData) {
        log("currentMonth => $currentMonth");
        // log("attendance_date => " + DateFormat.yMMMM().format(DateFormat.yMMMM().parse(element[CS.attendance_date])));
        final attendanceDate = parseDate(element[CS.attendance_date]);
        if (attendanceDate != null &&
            currentMonth.value ==
                DateFormat.yMMMM().format(attendanceDate)) {
          element[CS.attendance_code] == "P" ? present.value++ : absent.value++;
        }
      }
      for (final element in holidayData) {
        final schoolDate = parseDate(element[CS.school_date]);
        if (schoolDate != null &&
            currentMonth.value == DateFormat.yMMMM().format(schoolDate)) {
          holiday.value++;
        }
      }
      // resJson![CS.data][CS.calendar_data][CS.event].forEach((element) {
      //   if (currentMonth.value ==
      //       DateFormat.yMMMM().format(
      //           DateFormat("yyyy-MM-dd").parse(element[CS.school_date]))) {
      //     event.value++;
      //   }
      // });
      // resJson![CS.data][CS.calendar_data][CS.vacation].forEach((element) {
      //   if (currentMonth.value ==
      //       DateFormat.yMMMM().format(
      //           DateFormat("yyyy-MM-dd").parse(element[CS.school_date]))) {
      //     vacation.value++;
      //   }
      // });

      update();
    } catch (e) {
      log("ERROR $e");
    }
  }

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Future<void> callService() async {
    isLoading.value = true;
    errorMessage.value = "";

    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.student_id: userInfo[CS.student_id],
      CS.mobile_no: userInfo[CS.mobile],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: data.subTitleApi,
        isShowProgressDialog: false,
      );
    } else {
      isLoading.value = false;
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson?[CS.status].toString() == StatusCode.Success.toString()) {
      countDays();
      selectedDates = [];
      dates.clear();
      allpresent.value = 0;
      allabsent.value = 0;
      for (final element in attendanceData) {
        element[CS.attendance_code] == "P"
            ? allpresent.value++
            : allabsent.value++;
        selectedDates!.add({
          "day": element[CS.attendance_date],
          "status": "1",
          "color":
              element[CS.attendance_code] == "P" ? CU.greenColor : CU.redColor,
        });

        if (element[CS.attendance_code] != null) {
          final attendanceDate = parseDate(element[CS.attendance_date]);
          if (attendanceDate == null) continue;

          dates.add(
            DateItem(
              date: attendanceDate,
              type: element[CS.attendance_code],
            ),
          );
        }
      }

      for (final element in holidayData) {
        final schoolDate = parseDate(element[CS.school_date]);
        if (schoolDate == null) continue;

        selectedDates!.add({
          "day": element[CS.school_date],
          "status": "1",
          "color": CU.secondaryColor,
        });

        dates.add(
          DateItem(
            date: schoolDate,
            type: "Holiday",
          ),
        );
      }
        // resJson![CS.data][CS.calendar_data][CS.event].forEach((element) {
        //   selectedDates!.add({
        //     "day": element[CS.school_date],
        //     "status": "1",
        //     "color": CU.primaryColor,
        //   });

        //   dates.add(
        //     DateItem(
        //       date: DateTime.parse(element[CS.school_date]),
        //       type: "Event",
        //     ),
        //   );
        // });
        // resJson![CS.data][CS.calendar_data][CS.vacation].forEach((element) {
        //   selectedDates!.add({
        //     "day": element[CS.school_date],
        //     "status": "1",
        //     "color": CU.heliotropeColor,
        //   });

        //   dates.add(
        //     DateItem(
        //       date: DateTime.parse(element[CS.school_date]),
        //       type: "Vacation",
        //     ),
        //   );
        // });
    } else if (resJson?[CS.status].toString() == StatusCode.Error) {
      errorMessage.value = resJson?[CS.message]?.toString() ??
          "Attendance data is not available right now.";
      // showDialog(barrierDismissible: false, context: context, child: CU.showDiloag(context, resJson[CS.message]));
    } else {
      errorMessage.value = "Attendance data is not available right now.";
    }

    isLoading.value = false;
  }

  DateTime? parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }
}

class DateItem {
  final DateTime date;
  final String type;

  DateItem({
    required this.date,
    required this.type,
  });
}
