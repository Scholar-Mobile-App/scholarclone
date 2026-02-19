import 'dart:convert';

List<AchievementCertificateModel> achievementCertificateModelFromJson(
        String str) =>
    List<AchievementCertificateModel>.from(
        json.decode(str).map((x) => AchievementCertificateModel.fromJson(x)));

String achievementCertificateModelToJson(
        List<AchievementCertificateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AchievementCertificateModel {
  String? studentName;
  String? grNo;
  String? documentTitle;
  String? fileName;

  AchievementCertificateModel({
    this.studentName,
    this.grNo,
    this.documentTitle,
    this.fileName,
  });

  factory AchievementCertificateModel.fromJson(Map<String, dynamic> json) =>
      AchievementCertificateModel(
        studentName: json["student_name"],
        grNo: json["gr_no"],
        documentTitle: json["document_title"],
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "student_name": studentName,
        "gr_no": grNo,
        "document_title": documentTitle,
        "file_name": fileName,
      };
}
