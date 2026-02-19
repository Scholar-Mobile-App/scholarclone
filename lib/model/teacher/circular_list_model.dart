class CircularListModel {
  List<CircularList>? data;

  CircularListModel({
    this.data,
  });

  factory CircularListModel.fromJson(Map<String, dynamic> json) =>
      CircularListModel(
        data: json["data"] == null
            ? []
            : List<CircularList>.from(
                json["data"]!.map((x) => CircularList.fromJson(x))),
      );
}

class CircularList {
  int? id;
  String? syear;
  String? standardId;
  String? divisionId;
  String? title;
  String? message;
  String? fileName;
  String? date;
  int? subInstituteId;
  int? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? gradeId;
  String? name;
  String? shortName;
  int? sortOrder;
  String? medium;
  String? courseDuration;
  int? nextGradeId;
  int? nextStandardId;
  String? schoolStream;
  int? markingPeriodId;
  String? stdName;

  CircularList({
    this.id,
    this.syear,
    this.standardId,
    this.divisionId,
    this.title,
    this.message,
    this.fileName,
    this.date,
    this.subInstituteId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.gradeId,
    this.name,
    this.shortName,
    this.sortOrder,
    this.medium,
    this.courseDuration,
    this.nextGradeId,
    this.nextStandardId,
    this.schoolStream,
    this.markingPeriodId,
    this.stdName,
  });

  factory CircularList.fromJson(Map<String, dynamic> json) => CircularList(
        id: json["id"],
        syear: json["syear"],
        standardId: json["standard_id"],
        divisionId: json["division_id"],
        title: json["title"],
        message: json["message"],
        fileName: json["file_name"],
        date: json["date_"],
        subInstituteId: json["sub_institute_id"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        gradeId: json["grade_id"],
        name: json["name"],
        shortName: json["short_name"],
        sortOrder: json["sort_order"],
        medium: json["medium"],
        courseDuration: json["course_duration"],
        nextGradeId: json["next_grade_id"],
        nextStandardId: json["next_standard_id"],
        schoolStream: json["school_stream"],
        markingPeriodId: json["data"] == null ? 0 : json["marking_period_id"],
        stdName: json["std_name"],
      );
}
