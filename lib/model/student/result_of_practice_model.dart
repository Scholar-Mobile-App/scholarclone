import 'dart:convert';

ResultOfPractice resultOfPracticeFromJson(String str) =>
    ResultOfPractice.fromJson(json.decode(str));

String resultOfPracticeToJson(ResultOfPractice data) =>
    json.encode(data.toJson());

class ResultOfPractice {
  int? status;
  String? message;
  Data? data;

  ResultOfPractice({
    this.status,
    this.message,
    this.data,
  });

  factory ResultOfPractice.fromJson(Map<String, dynamic> json) =>
      ResultOfPractice(
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
  List<PracticeData>? attemptedData;
  List<Map<String, OnlineAnswerDatum>>? onlineAnswerData;

  Data({
    this.attemptedData,
    this.onlineAnswerData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attemptedData: json["attempted_data"] == null
            ? []
            : List<PracticeData>.from(
                json["attempted_data"]!.map((x) => PracticeData.fromJson(x))),
        onlineAnswerData: json["online_answer_data"] == null
            ? []
            : List<Map<String, OnlineAnswerDatum>>.from(
                json["online_answer_data"]!.map((x) => Map.from(x).map((k, v) =>
                    MapEntry<String, OnlineAnswerDatum>(
                        k, OnlineAnswerDatum.fromJson(v))))),
      );

  Map<String, dynamic> toJson() => {
        "attempted_data": attemptedData == null
            ? []
            : List<dynamic>.from(attemptedData!.map((x) => x.toJson())),
        "online_answer_data": onlineAnswerData == null
            ? []
            : List<dynamic>.from(onlineAnswerData!.map((x) => Map.from(x)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
      };
}

class PracticeData {
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

  PracticeData({
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
  });

  factory PracticeData.fromJson(Map<String, dynamic> json) => PracticeData(
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
      };
}

class OnlineAnswerDatum {
  String? questionText;
  String? rightWrong;
  String? actualAnswer;
  String? givenAnswer;

  OnlineAnswerDatum({
    this.questionText,
    this.rightWrong,
    this.actualAnswer,
    this.givenAnswer,
  });

  factory OnlineAnswerDatum.fromJson(Map<String, dynamic> json) =>
      OnlineAnswerDatum(
        questionText: json["QUESTION_TEXT"],
        rightWrong: json["RIGHT_WRONG"],
        actualAnswer: json["ACTUAL_ANSWER"],
        givenAnswer: json["GIVEN_ANSWER"],
      );

  Map<String, dynamic> toJson() => {
        "QUESTION_TEXT": questionText,
        "RIGHT_WRONG": rightWrong,
        "ACTUAL_ANSWER": actualAnswer,
        "GIVEN_ANSWER": givenAnswer,
      };
}
