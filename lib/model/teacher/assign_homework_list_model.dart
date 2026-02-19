class AssignHomeworkListModel {
  List<HomeworkList>? data;

  AssignHomeworkListModel({
    this.data,
  });

  factory AssignHomeworkListModel.fromJson(Map<String, dynamic> json) =>
      AssignHomeworkListModel(
        data: json["data"] == null
            ? []
            : List<HomeworkList>.from(
                json["data"]!.map((x) => HomeworkList.fromJson(x))),
      );
}

class HomeworkList {
  int? id;
  String? title;
  String? description;
  String? date;
  String? fileName;
  String? standardName;
  String? divisionName;
  String? subjectName;
  String? studentName;
  String? enrollmentNo;
  String? mobile;
  String? type;

  HomeworkList({
    this.id,
    this.title,
    this.description,
    this.date,
    this.fileName,
    this.standardName,
    this.divisionName,
    this.subjectName,
    this.studentName,
    this.enrollmentNo,
    this.mobile,
    this.type,
  });

  factory HomeworkList.fromJson(Map<String, dynamic> json) => HomeworkList(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        fileName: json["file_name"],
        standardName: json["standard_name"],
        divisionName: json["division_name"],
        subjectName: json["subject_name"],
        studentName: json["student_name"],
        enrollmentNo: json["enrollment_no"],
        mobile: json["mobile"],
        type: json["type"],
      );
}
