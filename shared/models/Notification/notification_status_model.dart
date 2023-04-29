// To parse this JSON data, do
//
//     final notificationStatusPayload = notificationStatusPayloadFromJson(jsonString);

import 'dart:convert';

NotificationStatusPayload notificationStatusPayloadFromJson(String str) =>
    NotificationStatusPayload.fromJson(json.decode(str));

String notificationStatusPayloadToJson(NotificationStatusPayload data) =>
    json.encode(data.toJson());

class NotificationStatusPayload {
  NotificationStatusPayload({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory NotificationStatusPayload.fromJson(Map<String, dynamic> json) =>
      NotificationStatusPayload(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.fullname,
    this.email,
    this.emailVerifiedAt,
    this.username,
    this.isActive,
    this.deviceToken,
    this.deviceTokenStatus,
    this.role,
    this.pin,
    this.isWaitlist,
    this.phone,
    this.meta,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? fullname;
  String? email;
  dynamic emailVerifiedAt;
  String? username;
  bool? isActive;
  dynamic deviceToken;
  bool? deviceTokenStatus;
  String? role;
  String? pin;
  bool? isWaitlist;
  String? phone;
  Meta? meta;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        username: json["username"],
        isActive: json["is_active"],
        deviceToken: json["device_token"],
        deviceTokenStatus: json["device_token_status"],
        role: json["role"],
        pin: json["pin"],
        isWaitlist: json["is_waitlist"],
        phone: json["phone"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "username": username,
        "is_active": isActive,
        "device_token": deviceToken,
        "device_token_status": deviceTokenStatus,
        "role": role,
        "pin": pin,
        "is_waitlist": isWaitlist,
        "phone": phone,
        "meta": meta?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Meta {
  Meta({
    this.filename,
    this.avatarUrl,
    this.firstLogin,
  });

  String? filename;
  String? avatarUrl;
  bool? firstLogin;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        filename: json["filename"],
        avatarUrl: json["avatar_url"],
        firstLogin: json["first_login"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "avatar_url": avatarUrl,
        "first_login": firstLogin,
      };
}
