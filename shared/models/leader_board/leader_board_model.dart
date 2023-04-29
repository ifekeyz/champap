// To parse this JSON data, do
//
//     final leaderBoardPayload = leaderBoardPayloadFromJson(jsonString);

import 'dart:convert';

LeaderBoardPayload leaderBoardPayloadFromJson(String str) =>
    LeaderBoardPayload.fromJson(json.decode(str));

String leaderBoardPayloadToJson(LeaderBoardPayload data) =>
    json.encode(data.toJson());

class LeaderBoardPayload {
  LeaderBoardPayload({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<PayloadFromLeaderboard>? data;

  factory LeaderBoardPayload.fromJson(Map<String, dynamic> json) =>
      LeaderBoardPayload(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<PayloadFromLeaderboard>.from(
                json["data"]!.map((x) => PayloadFromLeaderboard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PayloadFromLeaderboard {
  PayloadFromLeaderboard({
    this.noOfMatchWon,
    this.user,
  });

  int? noOfMatchWon;
  User? user;

  factory PayloadFromLeaderboard.fromJson(Map<String, dynamic> json) =>
      PayloadFromLeaderboard(
        noOfMatchWon: json["no_of_match_won"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "no_of_match_won": noOfMatchWon,
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.id,
    this.fullname,
    this.email,
    this.referredBy,
    this.username,
    this.avatar,
    this.phone,
    this.scoreBoardPosition,
    this.champsToken,
    this.champsCoin,
  });

  int? id;
  String? fullname;
  String? email;
  dynamic referredBy;
  dynamic username;
  String? avatar;
  String? phone;
  int? scoreBoardPosition;
  int? champsToken;
  String? champsCoin;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        referredBy: json["referred_by"],
        username: json["username"],
        avatar: json["avatar"],
        phone: json["phone"],
        scoreBoardPosition: json["score_board_position"],
        champsToken: json["champs_token"],
        champsCoin: json["champs_coin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "referred_by": referredBy,
        "username": username,
        "avatar": avatar,
        "phone": phone,
        "score_board_position": scoreBoardPosition,
        "champs_token": champsToken,
        "champs_coin": champsCoin,
      };
}
