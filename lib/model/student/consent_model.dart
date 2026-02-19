// To parse this JSON data, do
//
//     final consentModel = consentModelFromJson(jsonString);

import 'dart:convert';

ConsentModel consentModelFromJson(String str) =>
    ConsentModel.fromJson(json.decode(str));

String consentModelToJson(ConsentModel data) => json.encode(data.toJson());

class ConsentModel {
  int? statusCode;
  String? message;
  List<Consent>? data;

  ConsentModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory ConsentModel.fromJson(Map<String, dynamic> json) => ConsentModel(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Consent>.from(json["data"]!.map((x) => Consent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Consent {
  int? id;
  String? title;
  String? consentDate;
  String? accountableStatus;
  dynamic consentStatus;
  dynamic amount;
  dynamic imprestHeadId;
  String? createdBy;

  Consent({
    this.id,
    this.title,
    this.consentDate,
    this.accountableStatus,
    this.consentStatus,
    this.amount,
    this.imprestHeadId,
    this.createdBy,
  });

  factory Consent.fromJson(Map<String, dynamic> json) => Consent(
        id: json["ID"],
        title: json["title"],
        consentDate: json["consent_date"],
        accountableStatus: json["accountable_status"],
        consentStatus: json["consent_status"],
        amount: json["amount"],
        imprestHeadId: json["imprest_head_id"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "title": title,
        "consent_date": consentDate,
        "accountable_status": accountableStatus,
        "consent_status": consentStatus,
        "amount": amount,
        "imprest_head_id": imprestHeadId,
        "created_by": createdBy,
      };
}
