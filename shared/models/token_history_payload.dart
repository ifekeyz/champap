// To parse this JSON data, do
//
//     final tokenHistoryPayload = tokenHistoryPayloadFromJson(jsonString);

import 'dart:convert';

TokenHistoryPayload tokenHistoryPayloadFromJson(String str) =>
    TokenHistoryPayload.fromJson(json.decode(str));

String tokenHistoryPayloadToJson(TokenHistoryPayload data) =>
    json.encode(data.toJson());

class TokenHistoryPayload {
  TokenHistoryPayload({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<PayloadFromTokenHistory>? data;

  factory TokenHistoryPayload.fromJson(Map<String, dynamic> json) =>
      TokenHistoryPayload(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<PayloadFromTokenHistory>.from(
                json["data"].map((x) => PayloadFromTokenHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PayloadFromTokenHistory {
  PayloadFromTokenHistory({
    this.id,
    this.userId,
    this.token,
    this.name,
    this.description,
  });

  int? id;
  int? userId;
  int? token;
  String? name;
  String? description;

  factory PayloadFromTokenHistory.fromJson(Map<String, dynamic> json) =>
      PayloadFromTokenHistory(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        token: json["token"] == null ? null : json["token"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "token": token == null ? null : token,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
      };
}
