import 'dart:convert';

LmsSubjectTestModel lmsSubjectTestModelFromJson(String str) =>
    LmsSubjectTestModel.fromJson(json.decode(str));

String lmsSubjectTestModelToJson(LmsSubjectTestModel data) =>
    json.encode(data.toJson());

class LmsSubjectTestModel {
  int? status;
  String? message;
  List<TestData>? data;

  LmsSubjectTestModel({
    this.status,
    this.message,
    this.data,
  });

  factory LmsSubjectTestModel.fromJson(Map<String, dynamic> json) =>
      LmsSubjectTestModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TestData>.from(
                json["data"]!.map((x) => TestData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TestData {
  int? id;
  int? gradeId;
  int? standardId;
  int? subjectId;
  String? paperName;
  String? paperDesc;
  DateTime? openDate;
  DateTime? closeDate;
  int? timelimitEnable;
  int? timeAllowed;
  int? totalMarks;
  int? totalQues;
  String? questionIds;
  int? shuffleQuestion;
  int? attemptAllowed;
  int? showFeedback;
  int? showHide;
  int? resultShowAns;
  DateTime? createdOn;
  int? createdBy;
  int? subInstituteId;
  int? syear;
  String? examType;
  int? questionPaperId;

  TestData({
    this.id,
    this.gradeId,
    this.standardId,
    this.subjectId,
    this.paperName,
    this.paperDesc,
    this.openDate,
    this.closeDate,
    this.timelimitEnable,
    this.timeAllowed,
    this.totalMarks,
    this.totalQues,
    this.questionIds,
    this.shuffleQuestion,
    this.attemptAllowed,
    this.showFeedback,
    this.showHide,
    this.resultShowAns,
    this.createdOn,
    this.createdBy,
    this.subInstituteId,
    this.syear,
    this.examType,
    this.questionPaperId,
  });

  factory TestData.fromJson(Map<String, dynamic> json) => TestData(
        id: json["id"],
        gradeId: json["grade_id"],
        standardId: json["standard_id"],
        subjectId: json["subject_id"],
        paperName: json["paper_name"],
        paperDesc: json["paper_desc"],
        openDate: json["open_date"] == null
            ? null
            : DateTime.parse(json["open_date"]),
        closeDate: json["close_date"] == null
            ? null
            : DateTime.parse(json["close_date"]),
        timelimitEnable: json["timelimit_enable"],
        timeAllowed: json["time_allowed"],
        totalMarks: json["total_marks"],
        totalQues: json["total_ques"],
        questionIds: json["question_ids"],
        shuffleQuestion: json["shuffle_question"],
        attemptAllowed: json["attempt_allowed"],
        showFeedback: json["show_feedback"],
        showHide: json["show_hide"],
        resultShowAns: json["result_show_ans"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdBy: json["created_by"],
        subInstituteId: json["sub_institute_id"],
        syear: json["syear"],
        examType: json["exam_type"],
        questionPaperId: json["question_paper_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade_id": gradeId,
        "standard_id": standardId,
        "subject_id": subjectId,
        "paper_name": paperName,
        "paper_desc": paperDesc,
        "open_date": openDate?.toIso8601String(),
        "close_date": closeDate?.toIso8601String(),
        "timelimit_enable": timelimitEnable,
        "time_allowed": timeAllowed,
        "total_marks": totalMarks,
        "total_ques": totalQues,
        "question_ids": questionIds,
        "shuffle_question": shuffleQuestion,
        "attempt_allowed": attemptAllowed,
        "show_feedback": showFeedback,
        "show_hide": showHide,
        "result_show_ans": resultShowAns,
        "created_on": createdOn?.toIso8601String(),
        "created_by": createdBy,
        "sub_institute_id": subInstituteId,
        "syear": syear,
        "exam_type": examType,
        "question_paper_id": questionPaperId,
      };
}
