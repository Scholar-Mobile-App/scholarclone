import 'dart:convert';

TeacherRequisitionModel teacherRequisitionModelFromJson(String str) =>
    TeacherRequisitionModel.fromJson(json.decode(str));

String teacherRequisitionModelToJson(TeacherRequisitionModel data) =>
    json.encode(data.toJson());

class TeacherRequisitionModel {
  int? status;
  String? message;
  List<TeacherRequisition>? data;

  TeacherRequisitionModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherRequisitionModel.fromJson(Map<String, dynamic> json) =>
      TeacherRequisitionModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TeacherRequisition>.from(
                json["data"]!.map((x) => TeacherRequisition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TeacherRequisition {
  int? id;
  String? requisitionBy;
  String? requisitionNo;
  DateTime? requisitionDate;
  String? itemName;
  int? itemQty;
  String? itemUnit;
  DateTime? expectedDeliveryTime;
  String? remarks;
  String? requisitionStatus;
  String? requisitionApprovedBy;
  dynamic approvedQty;
  dynamic requisitionApprovedRemarks;
  dynamic requisitionApprovedDate;

  TeacherRequisition({
    this.id,
    this.requisitionBy,
    this.requisitionNo,
    this.requisitionDate,
    this.itemName,
    this.itemQty,
    this.itemUnit,
    this.expectedDeliveryTime,
    this.remarks,
    this.requisitionStatus,
    this.requisitionApprovedBy,
    this.approvedQty,
    this.requisitionApprovedRemarks,
    this.requisitionApprovedDate,
  });

  factory TeacherRequisition.fromJson(Map<String, dynamic> json) =>
      TeacherRequisition(
        id: json["id"],
        requisitionBy: json["requisition_by"],
        requisitionNo: json["requisition_no"],
        requisitionDate: json["requisition_date"] == null
            ? null
            : DateTime.parse(json["requisition_date"]),
        itemName: json["item_name"],
        itemQty: json["item_qty"],
        itemUnit: json["item_unit"],
        expectedDeliveryTime: json["expected_delivery_time"] == null
            ? null
            : DateTime.parse(json["expected_delivery_time"]),
        remarks: json["remarks"],
        requisitionStatus: json["requisition_status"],
        requisitionApprovedBy: json["requisition_approved_by"],
        approvedQty: json["approved_qty"],
        requisitionApprovedRemarks: json["requisition_approved_remarks"],
        requisitionApprovedDate: json["requisition_approved_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "requisition_by": requisitionBy,
        "requisition_no": requisitionNo,
        "requisition_date": requisitionDate?.toIso8601String(),
        "item_name": itemName,
        "item_qty": itemQty,
        "item_unit": itemUnit,
        "expected_delivery_time": expectedDeliveryTime?.toIso8601String(),
        "remarks": remarks,
        "requisition_status": requisitionStatus,
        "requisition_approved_by": requisitionApprovedBy,
        "approved_qty": approvedQty,
        "requisition_approved_remarks": requisitionApprovedRemarks,
        "requisition_approved_date": requisitionApprovedDate,
      };
}
