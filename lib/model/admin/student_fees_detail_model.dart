class StudentFeesDetailModel {
  int? status;
  String? message;
  Data? data;

  StudentFeesDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory StudentFeesDetailModel.fromJson(Map<String, dynamic> json) =>
      StudentFeesDetailModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  StuData? stuData;
  List<Pending>? pending;
  List<Paid>? paid;

  Data({
    this.stuData,
    this.pending,
    this.paid,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        stuData: json["STU_DATA"] == null
            ? null
            : StuData.fromJson(json["STU_DATA"]),
        pending: json["PENDING"] == null
            ? []
            : List<Pending>.from(
                json["PENDING"]!.map((x) => Pending.fromJson(x))),
        paid: json["PAID"] == null
            ? []
            : List<Paid>.from(json["PAID"]!.map((x) => Paid.fromJson(x))),
      );
}

class Paid {
  int? monthId;
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
  int? syear;

  Paid({
    this.monthId,
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
    this.syear,
  });

  factory Paid.fromJson(Map<String, dynamic> json) => Paid(
        monthId: json["month_id"],
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
        syear: json["syear"],
      );
}

class Pending {
  String? month;
  String? monthThis;
  int? monthId;
  int? remain;
  int? discount;
  String? payNow;

  Pending({
    this.month,
    this.monthThis,
    this.monthId,
    this.remain,
    this.discount,
    this.payNow,
  });

  factory Pending.fromJson(Map<String, dynamic> json) => Pending(
        month: json["month"],
        monthThis: json["month_this"],
        monthId: json["month_id"],
        remain: json["remain"],
        discount: json["discount"],
        payNow: json["PayNow"],
      );
}

class StuData {
  int? studentId;
  String? enrollment;
  int? rollNo;
  String? name;
  String? stddiv;
  int? admission;
  String? admissionYear;
  String? email;
  String? medium;
  dynamic fatherName;
  String? motherName;
  int? pending;
  int? previousFees;
  String? mobile;
  dynamic uniqueid;
  int? stdId;
  int? gradeId;
  int? divId;
  String? studentQuota;
  String? studentBatch;
  int? previousYearImprestBalance;
  String? token;

  StuData({
    this.studentId,
    this.enrollment,
    this.rollNo,
    this.name,
    this.stddiv,
    this.admission,
    this.admissionYear,
    this.email,
    this.medium,
    this.fatherName,
    this.motherName,
    this.pending,
    this.previousFees,
    this.mobile,
    this.uniqueid,
    this.stdId,
    this.gradeId,
    this.divId,
    this.studentQuota,
    this.studentBatch,
    this.previousYearImprestBalance,
    this.token,
  });

  factory StuData.fromJson(Map<String, dynamic> json) => StuData(
        studentId: json["student_id"],
        enrollment: json["enrollment"],
        rollNo: json["roll_no"],
        name: json["name"],
        stddiv: json["stddiv"],
        admission: json["admission"],
        admissionYear: json["admission_year"],
        email: json["email"],
        medium: json["medium"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        pending: json["pending"],
        previousFees: json["previous_fees"],
        mobile: json["mobile"],
        uniqueid: json["uniqueid"],
        stdId: json["std_id"],
        gradeId: json["grade_id"],
        divId: json["div_id"],
        studentQuota: json["student_quota"],
        studentBatch: json["student_batch"],
        previousYearImprestBalance: json["previous_year_imprest_balance"],
        token: json["token"],
      );
}
