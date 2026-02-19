import 'dart:convert';

AdminItemListModel adminItemListModelFromJson(String str) =>
    AdminItemListModel.fromJson(json.decode(str));

String adminItemListModelToJson(AdminItemListModel data) =>
    json.encode(data.toJson());

class AdminItemListModel {
  int? status;
  String? message;
  List<AdminItem>? data;

  AdminItemListModel({
    this.status,
    this.message,
    this.data,
  });

  factory AdminItemListModel.fromJson(Map<String, dynamic> json) =>
      AdminItemListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<AdminItem>.from(
                json["data"]!.map((x) => AdminItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AdminItem {
  int? id;
  int? syear;
  int? subInstituteId;
  int? categoryId;
  int? subCategoryId;
  int? itemTypeId;
  String? title;
  String? description;
  int? openingStock;
  int? minimumStock;
  int? directPurchaseStock;
  String? itemAttachment;
  String? itemStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  AdminItem({
    this.id,
    this.syear,
    this.subInstituteId,
    this.categoryId,
    this.subCategoryId,
    this.itemTypeId,
    this.title,
    this.description,
    this.openingStock,
    this.minimumStock,
    this.directPurchaseStock,
    this.itemAttachment,
    this.itemStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminItem.fromJson(Map<String, dynamic> json) => AdminItem(
        id: json["id"],
        syear: json["syear"],
        subInstituteId: json["sub_institute_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        itemTypeId: json["item_type_id"],
        title: json["title"],
        description: json["description"],
        openingStock: json["opening_stock"],
        minimumStock: json["minimum_stock"],
        directPurchaseStock: json["direct_purchase_stock"],
        itemAttachment: json["item_attachment"],
        itemStatus: json["item_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "syear": syear,
        "sub_institute_id": subInstituteId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "item_type_id": itemTypeId,
        "title": title,
        "description": description,
        "opening_stock": openingStock,
        "minimum_stock": minimumStock,
        "direct_purchase_stock": directPurchaseStock,
        "item_attachment": itemAttachment,
        "item_status": itemStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
