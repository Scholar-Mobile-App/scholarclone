// To parse this JSON data, do
//
//     final feesStatusModel = feesStatusModelFromJson(jsonString);

import 'dart:convert';

FeesStatusModel feesStatusModelFromJson(String str) =>
    FeesStatusModel.fromJson(json.decode(str));

String feesStatusModelToJson(FeesStatusModel data) =>
    json.encode(data.toJson());

class FeesStatusModel {
  int? status;
  String? message;
  Status? data;

  FeesStatusModel({
    this.status,
    this.message,
    this.data,
  });

  factory FeesStatusModel.fromJson(Map<String, dynamic> json) =>
      FeesStatusModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Status.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Status {
  List<UnPaid>? pending;
  List<Paid>? paid;

  Status({
    this.pending,
    this.paid,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        pending: json["PENDING"] == null
            ? []
            : List<UnPaid>.from(
                json["PENDING"]!.map((x) => UnPaid.fromJson(x))),
        paid: json["PAID"] == null
            ? []
            : List<Paid>.from(json["PAID"]!.map((x) => Paid.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "PENDING": pending == null
            ? []
            : List<dynamic>.from(pending!.map((x) => x.toJson())),
        "PAID": paid == null
            ? []
            : List<dynamic>.from(paid!.map((x) => x.toJson())),
      };
}

class UnPaid {
  String? month;
  String? monthId;
  String? paynow;
  int? remain;

  UnPaid({
    this.month,
    this.monthId,
    this.remain,
    this.paynow,
  });

  factory UnPaid.fromJson(Map<String, dynamic> json) => UnPaid(
        month: json["month"],
        monthId: json["month_id"].toString(),
        remain: json["remain"],
        paynow: json["PayNow"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "month_id": monthId,
        "remain": remain,
        "PayNow": paynow,
      };
}

class Paid {
  String? receiptNo;
  DateTime? receiptdate;
  String? paymentMode;
  String? bankBranch;
  dynamic bankName;
  String? feesHtml;
  DateTime? chequeDate;
  String? chequeNo;
  String? chequeBankName;
  String? paidAmount;

  Paid({
    this.receiptNo,
    this.receiptdate,
    this.paymentMode,
    this.bankBranch,
    this.bankName,
    this.feesHtml,
    this.chequeDate,
    this.chequeNo,
    this.chequeBankName,
    this.paidAmount,
  });

  factory Paid.fromJson(Map<String, dynamic> json) => Paid(
        receiptNo: json["receipt_no"],
        receiptdate: json["receiptdate"] == null
            ? null
            : DateTime.parse(json["receiptdate"]),
        paymentMode: json["payment_mode"],
        bankBranch: json["bank_branch"],
        bankName: json["bank_name"],
        feesHtml: json["fees_html"],
        chequeDate: json["cheque_date"] == null
            ? null
            : DateTime.parse(json["cheque_date"]),
        chequeNo: json["cheque_no"],
        chequeBankName: json["cheque_bank_name"],
        paidAmount: json["paid_amount"],
      );

  Map<String, dynamic> toJson() => {
        "receipt_no": receiptNo,
        "receiptdate":
            "${receiptdate!.year.toString().padLeft(4, '0')}-${receiptdate!.month.toString().padLeft(2, '0')}-${receiptdate!.day.toString().padLeft(2, '0')}",
        "payment_mode": paymentMode,
        "bank_branch": bankBranch,
        "bank_name": bankName,
        "fees_html": feesHtml,
        "cheque_date":
            "${chequeDate!.year.toString().padLeft(4, '0')}-${chequeDate!.month.toString().padLeft(2, '0')}-${chequeDate!.day.toString().padLeft(2, '0')}",
        "cheque_no": chequeNo,
        "cheque_bank_name": chequeBankName,
        "paid_amount": paidAmount,
      };
}
