// To parse this JSON data, do
//
//     final matchPayload = matchPayloadFromJson(jsonString);

import 'dart:convert';

MatchPayload matchPayloadFromJson(String str) =>
    MatchPayload.fromJson(json.decode(str));

String matchPayloadToJson(MatchPayload data) => json.encode(data.toJson());

class MatchPayload {
  MatchPayload({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<DataFromMatch>? data;

  factory MatchPayload.fromJson(Map<String, dynamic> json) => MatchPayload(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataFromMatch>.from(
                json["data"].map((x) => DataFromMatch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataFromMatch {
  DataFromMatch({
    this.id,
    this.users,
    this.game,
  });

  int? id;
  Users? users;
  Game? game;

  factory DataFromMatch.fromJson(Map<String, dynamic> json) => DataFromMatch(
        id: json["id"] == null ? null : json["id"],
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
        game: json["game"] == null ? null : Game.fromJson(json["game"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "users": users == null ? null : users!.toJson(),
        "game": game == null ? null : game!.toJson(),
      };
}

class Game {
  Game({
    this.id,
    this.roomId,
    this.draw,
    this.isActive,
    this.winnerId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? roomId;
  bool? draw;
  bool? isActive;
  dynamic? winnerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"] == null ? null : json["id"],
        roomId: json["room_id"] == null ? null : json["room_id"],
        draw: json["draw"] == null ? null : json["draw"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        winnerId: json["winner_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "room_id": roomId == null ? null : roomId,
        "draw": draw == null ? null : draw,
        "is_active": isActive == null ? null : isActive,
        "winner_id": winnerId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class Users {
  Users({
    this.id,
    this.fullname,
    this.email,
    this.username,
    this.avatar,
    this.phone,
  });

  int? id;
  String? fullname;
  String? email;
  String? username;
  String? avatar;
  String? phone;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"] == null ? null : json["id"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        email: json["email"] == null ? null : json["email"],
        username: json["username"] == null ? null : json["username"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        phone: json["phone"] == null ? null : json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "fullname": fullname == null ? null : fullname,
        "email": email == null ? null : email,
        "username": username == null ? null : username,
        "avatar": avatar == null ? null : avatar,
        "phone": phone == null ? null : phone,
      };
}
