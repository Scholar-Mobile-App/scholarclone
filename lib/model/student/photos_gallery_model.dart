// import 'dart:convert';

// PhotosGalleryModel photosGalleryModelFromJson(String str) =>
//     PhotosGalleryModel.fromJson(json.decode(str));

// String photosGalleryModelToJson(PhotosGalleryModel data) =>
//     json.encode(data.toJson());

// class PhotosGalleryModel {
//   int? status;
//   String? message;
//   List<PhotosGallery>? data;

//   PhotosGalleryModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   factory PhotosGalleryModel.fromJson(Map<String, dynamic> json) =>
//       PhotosGalleryModel(
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<PhotosGallery>.from(
//                 json["data"]!.map((x) => PhotosGallery.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class PhotosGallery {
//   String? albumTitle;
//   List<Album>? album;

//   PhotosGallery({
//     this.albumTitle,
//     this.album,
//   });

//   factory PhotosGallery.fromJson(Map<String, dynamic> json) => PhotosGallery(
//         albumTitle: json["album_title"],
//         album: json["album"] == null
//             ? []
//             : List<Album>.from(json["album"]!.map((x) => Album.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "album_title": albumTitle,
//         "album": album == null
//             ? []
//             : List<dynamic>.from(album!.map((x) => x.toJson())),
//       };
// }

// class Album {
//   String? albumTitle;
//   String? title;
//   String? fileName;
//   DateTime? date;
//   String? ai;
//   String? type;

//   Album({
//     this.albumTitle,
//     this.title,
//     this.fileName,
//     this.date,
//     this.ai,
//     this.type,
//   });

//   factory Album.fromJson(Map<String, dynamic> json) => Album(
//         albumTitle: json["album_title"],
//         title: json["title"],
//         fileName: json["file_name"],
//         date: json["date_"] == null ? null : DateTime.parse(json["date_"]),
//         ai: json["ai"],
//         type: json["type"],
//       );

//   Map<String, dynamic> toJson() => {
//         "album_title": albumTitle,
//         "title": title,
//         "file_name": fileName,
//         "date_": date!.toIso8601String(),
//         "ai": ai,
//         "type": type,
//       };
// }

// To parse this JSON data, do
//
//     final photosGalleryModel = photosGalleryModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final photosGalleryModel = photosGalleryModelFromJson(jsonString);

import 'dart:convert';

PhotosGalleryModel photosGalleryModelFromJson(String str) =>
    PhotosGalleryModel.fromJson(json.decode(str));

String photosGalleryModelToJson(PhotosGalleryModel data) =>
    json.encode(data.toJson());

class PhotosGalleryModel {
  int? status;
  String? message;
  Map<String, List<Album>>? data;

  PhotosGalleryModel({
    this.status,
    this.message,
    this.data,
  });

  factory PhotosGalleryModel.fromJson(Map<String, dynamic> json) =>
      PhotosGalleryModel(
        status: json["status"],
        message: json["message"],
        data: Map.from(json["data"]!).map((k, v) =>
            MapEntry<String, List<Album>>(
                k, List<Album>.from(v.map((x) => Album.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(
            k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class Album {
  String? albumTitle;
  String? title;
  String? fileName;
  DateTime? date;
  String? ai;
  String? type;

  Album({
    this.albumTitle,
    this.title,
    this.fileName,
    this.date,
    this.ai,
    this.type,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        albumTitle: json["album_title"],
        title: json["title"],
        fileName: json["file_name"],
        date: json["date_"] == null ? null : DateTime.parse(json["date_"]),
        ai: json["ai"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "album_title": albumTitle,
        "title": title,
        "file_name": fileName,
        "date_":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "ai": ai,
        "type": type,
      };
}
