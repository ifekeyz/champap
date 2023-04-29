// To parse this JSON data, do
//
//     final homePayload = homePayloadFromJson(jsonString);

import 'dart:convert';

HomePayload homePayloadFromJson(String str) =>
    HomePayload.fromJson(json.decode(str));

String homePayloadToJson(HomePayload data) => json.encode(data.toJson());

class HomePayload {
  HomePayload({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  PayloadFromHome? data;

  factory HomePayload.fromJson(Map<String, dynamic> json) => HomePayload(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : PayloadFromHome.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class PayloadFromHome {
  PayloadFromHome({
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

  factory PayloadFromHome.fromJson(Map<String, dynamic> json) =>
      PayloadFromHome(
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
