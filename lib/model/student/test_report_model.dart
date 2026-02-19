import 'dart:convert';

TestReportModel testReportModelFromJson(String str) =>
    TestReportModel.fromJson(json.decode(str));

String testReportModelToJson(TestReportModel data) =>
    json.encode(data.toJson());

class TestReportModel {
  int? status;
  String? message;
  Data? data;

  TestReportModel({
    this.status,
    this.message,
    this.data,
  });

  factory TestReportModel.fromJson(Map<String, dynamic> json) =>
      TestReportModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<AttemptedDatum>? attemptedData;

  Data({
    this.attemptedData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attemptedData: json["attempted_data"] == null
            ? []
            : List<AttemptedDatum>.from(
                json["attempted_data"]!.map((x) => AttemptedDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attempted_data": attemptedData == null
            ? []
            : List<dynamic>.from(attemptedData!.map((x) => x.toJson())),
      };
}

class AttemptedDatum {
  int? id;
  int? studentId;
  int? questionPaperId;
  int? totalRight;
  int? totalWrong;
  int? obtainMarks;
  DateTime? startTime;
  DateTime? createdAt;
  int? onlineExamId;
  String? paperName;
  ProgressbarData? progressbarData;

  AttemptedDatum({
    this.id,
    this.studentId,
    this.questionPaperId,
    this.totalRight,
    this.totalWrong,
    this.obtainMarks,
    this.startTime,
    this.createdAt,
    this.onlineExamId,
    this.paperName,
    this.progressbarData,
  });

  factory AttemptedDatum.fromJson(Map<String, dynamic> json) => AttemptedDatum(
        id: json["id"],
        studentId: json["student_id"],
        questionPaperId: json["question_paper_id"],
        totalRight: json["total_right"],
        totalWrong: json["total_wrong"],
        obtainMarks: json["obtain_marks"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        onlineExamId: json["online_exam_id"],
        paperName: json["paper_name"],
        progressbarData: json["PROGRESSBAR_DATA"] == null
            ? null
            : ProgressbarData.fromJson(json["PROGRESSBAR_DATA"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "question_paper_id": questionPaperId,
        "total_right": totalRight,
        "total_wrong": totalWrong,
        "obtain_marks": obtainMarks,
        "start_time": startTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "online_exam_id": onlineExamId,
        "paper_name": paperName,
        "PROGRESSBAR_DATA": progressbarData?.toJson(),
      };
}

class ProgressbarData {
  List<BloomsTaxonomy>? depthOfKnowledge;
  List<BloomsTaxonomy>? bloomsTaxonomy;
  List<BloomsTaxonomy>? learningIndicatorFoodWhereDoesItComeFrom;
  List<BloomsTaxonomy>? competencySkill;

  ProgressbarData({
    this.depthOfKnowledge,
    this.bloomsTaxonomy,
    this.learningIndicatorFoodWhereDoesItComeFrom,
    this.competencySkill,
  });

  factory ProgressbarData.fromJson(Map<String, dynamic> json) =>
      ProgressbarData(
        depthOfKnowledge: json["Depth of Knowledge"] == null
            ? []
            : List<BloomsTaxonomy>.from(json["Depth of Knowledge"]!
                .map((x) => BloomsTaxonomy.fromJson(x))),
        bloomsTaxonomy: json["Blooms Taxonomy"] == null
            ? []
            : List<BloomsTaxonomy>.from(json["Blooms Taxonomy"]!
                .map((x) => BloomsTaxonomy.fromJson(x))),
        learningIndicatorFoodWhereDoesItComeFrom:
            json["Learning Indicator - Food: Where Does It Come From?"] == null
                ? []
                : List<BloomsTaxonomy>.from(
                    json["Learning Indicator - Food: Where Does It Come From?"]!
                        .map((x) => BloomsTaxonomy.fromJson(x))),
        competencySkill: json["Competency Skill"] == null
            ? []
            : List<BloomsTaxonomy>.from(json["Competency Skill"]!
                .map((x) => BloomsTaxonomy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Depth of Knowledge": depthOfKnowledge == null
            ? []
            : List<dynamic>.from(depthOfKnowledge!.map((x) => x.toJson())),
        "Blooms Taxonomy": bloomsTaxonomy == null
            ? []
            : List<dynamic>.from(bloomsTaxonomy!.map((x) => x.toJson())),
        "Learning Indicator - Food: Where Does It Come From?":
            learningIndicatorFoodWhereDoesItComeFrom == null
                ? []
                : List<dynamic>.from(learningIndicatorFoodWhereDoesItComeFrom!
                    .map((x) => x.toJson())),
        "Competency Skill": competencySkill == null
            ? []
            : List<dynamic>.from(competencySkill!.map((x) => x.toJson())),
      };
}

class BloomsTaxonomy {
  int? parentId;
  String? parentName;
  int? id;
  String? name;
  int? totalQuestion;
  String? quesList;
  int? rightAnswer;
  String? totalPercentage;
  int? obtainedPercentage;

  BloomsTaxonomy({
    this.parentId,
    this.parentName,
    this.id,
    this.name,
    this.totalQuestion,
    this.quesList,
    this.rightAnswer,
    this.totalPercentage,
    this.obtainedPercentage,
  });

  factory BloomsTaxonomy.fromJson(Map<String, dynamic> json) => BloomsTaxonomy(
        parentId: json["parent_id"],
        parentName: json["parent_name"],
        id: json["id"],
        name: json["name"],
        totalQuestion: json["total_question"],
        quesList: json["ques_list"],
        rightAnswer: json["right_answer"],
        totalPercentage: json["total_percentage"],
        obtainedPercentage: json["obtained_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "parent_id": parentId,
        "parent_name": parentName,
        "id": id,
        "name": name,
        "total_question": totalQuestion,
        "ques_list": quesList,
        "right_answer": rightAnswer,
        "total_percentage": totalPercentage,
        "obtained_percentage": obtainedPercentage,
      };
}
