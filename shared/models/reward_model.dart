// To parse this JSON data, do
//
//     final rewardPayload = rewardPayloadFromJson(jsonString);

import 'dart:convert';

RewardPayload rewardPayloadFromJson(String str) => RewardPayload.fromJson(json.decode(str));

String rewardPayloadToJson(RewardPayload data) => json.encode(data.toJson());

class RewardPayload {
  RewardPayload({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String ?message;
  PayloadFromReward ?data;

  factory RewardPayload.fromJson(Map<String, dynamic> json) => RewardPayload(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : PayloadFromReward.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class PayloadFromReward {
  PayloadFromReward({
    this.id,
    this.userId,
    this.token,
    this.createdAt,
    this.updatedAt,
  });

  int ?id;
  int ?userId;
  int ?token;
  DateTime? createdAt;
  DateTime ?updatedAt;

  factory PayloadFromReward.fromJson(Map<String, dynamic> json) => PayloadFromReward(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    token: json["token"] == null ? null : json["token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "token": token == null ? null : token,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
