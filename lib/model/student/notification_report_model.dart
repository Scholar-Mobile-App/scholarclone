class TeacherNotificationReportModel {
  String? message;
  List<NotificationReport>? data;
  String? mobileNo;
  DateTime? fromDate;
  DateTime? toDate;
  String? status;

  TeacherNotificationReportModel({
    this.message,
    this.data,
    this.mobileNo,
    this.fromDate,
    this.toDate,
    this.status,
  });

  factory TeacherNotificationReportModel.fromJson(Map<String, dynamic> json) =>
      TeacherNotificationReportModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<NotificationReport>.from(
                json["data"]!.map((x) => NotificationReport.fromJson(x))),
        mobileNo: json["mobile_no"],
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        status: json["status"],
      );
}

class NotificationReport {
  int? studentId;
  String? stuName;
  String? stdName;
  String? divName;
  String? acaSec;
  String? imeiNo;
  String? currVersion;
  String? newVersion;
  String? mobileNo;
  String? createdOn;
  String? enrollmentNo;
  String? notificationType;
  String? notificationDate;
  String? notificationDescription;
  String? notificationStatus;

  NotificationReport({
    this.studentId,
    this.stuName,
    this.stdName,
    this.divName,
    this.acaSec,
    this.imeiNo,
    this.currVersion,
    this.newVersion,
    this.mobileNo,
    this.createdOn,
    this.enrollmentNo,
    this.notificationType,
    this.notificationDate,
    this.notificationDescription,
    this.notificationStatus,
  });

  factory NotificationReport.fromJson(Map<String, dynamic> json) =>
      NotificationReport(
        studentId: json["student_id"],
        stuName: json["stu_name"],
        stdName: json["std_name"],
        divName: json["div_name"],
        acaSec: json["aca_sec"],
        imeiNo: json["imei_no"],
        currVersion: json["curr_version"],
        newVersion: json["new_version"],
        mobileNo: json["mobile_no"],
        createdOn: json["CREATED_ON"],
        enrollmentNo: json["enrollment_no"],
        notificationType: json["NOTIFICATION_TYPE"],
        notificationDate: json["NOTOFICATION_DATE"],
        notificationDescription: json["NOTIFICATION_DESCRIPTION"],
        notificationStatus: json["NOTIFICATION_STATUS"],
      );
}
