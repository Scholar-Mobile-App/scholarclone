import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) =>
    HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  String? status;
  String? message;
  List<HomeData>? data;

  HomeDataModel({
    this.status,
    this.message,
    this.data,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<HomeData>.from(
                json["data"]!.map((x) => HomeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HomeData {
  String? mainTitle;
  String? menuType;
  String? mainItleColor;
  String? mainTitleBackgroundImage;
  List<Content>? contents;

  HomeData({
    this.mainTitle,
    this.menuType,
    this.mainItleColor,
    this.mainTitleBackgroundImage,
    this.contents,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        mainTitle: json["main_title"],
        menuType: json["menu_type"],
        mainItleColor: json["main_itle_color"],
        mainTitleBackgroundImage: json["main_title_background_image"],
        contents: json["contents"] == null
            ? []
            : List<Content>.from(
                json["contents"]!.map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "main_title": mainTitle,
        "menu_type": menuType,
        "main_itle_color": mainItleColor,
        "main_title_background_image": mainTitleBackgroundImage,
        "contents": contents == null
            ? []
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
      };
}

class Content {
  String? subTitle;
  String? subTitleIcon;
  String? subTitleApi;
  String? subTitleApiParam;
  String? screenName;

  Content({
    this.subTitle,
    this.subTitleIcon,
    this.subTitleApi,
    this.subTitleApiParam,
    this.screenName,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        subTitle: json["sub_title"],
        subTitleIcon: json["sub_title_icon"],
        subTitleApi: json["sub_title_api"],
        subTitleApiParam: json["sub_title_api_param"],
        screenName: json["screen_name"],
      );

  Map<String, dynamic> toJson() => {
        "sub_title": subTitle,
        "sub_title_icon": subTitleIcon,
        "sub_title_api": subTitleApi,
        "sub_title_api_param": subTitleApiParam,
        "screen_name": screenName,
      };
}
