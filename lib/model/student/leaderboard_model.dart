import 'dart:convert';

LeaderboardModel leaderboardModelFromJson(String str) =>
    LeaderboardModel.fromJson(json.decode(str));

String leaderboardModelToJson(LeaderboardModel data) =>
    json.encode(data.toJson());

class LeaderboardModel {
  int? status;
  String? message;
  Map<String, Leaderboard>? data;

  LeaderboardModel({
    this.status,
    this.message,
    this.data,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) =>
      LeaderboardModel(
        status: json["status"],
        message: json["message"],
        data: Map.from(json["data"]!).map((k, v) =>
            MapEntry<String, Leaderboard>(k, Leaderboard.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": Map.from(data!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Leaderboard {
  String? type;
  int? totalPoints;
  String? icon;
  String? studentRank;
  String? myTier;

  Leaderboard({
    this.type,
    this.totalPoints,
    this.icon,
    this.studentRank,
    this.myTier,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
        type: json["type"],
        totalPoints: json["total_points"],
        icon: json["icon"],
        studentRank: json["student_rank"],
        myTier: json["my_tier"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "total_points": totalPoints,
        "icon": icon,
        "student_rank": studentRank,
        "my_tier": myTier,
      };
}
