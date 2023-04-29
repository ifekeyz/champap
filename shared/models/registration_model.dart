// To parse this JSON data, do
//
//     final registrationPayload = registrationPayloadFromJson(jsonString);

import 'dart:convert';

RegistrationPayload registrationPayloadFromJson(String str) =>
    RegistrationPayload.fromJson(json.decode(str));

String registrationPayloadToJson(RegistrationPayload data) =>
    json.encode(data.toJson());

class RegistrationPayload {
  RegistrationPayload({
    this.fullname,
    this.email,
    this.username,
    this.avatar,
    this.phone,
    this.id,
  });

  String? fullname;
  String? email;
  String? username;
  String? avatar;
  String? phone;
  int? id;

  factory RegistrationPayload.fromJson(Map<String, dynamic> json) =>
      RegistrationPayload(
        fullname: json["fullname"] == null ? null : json["fullname"],
        email: json["email"] == null ? null : json["email"],
        username: json["username"] == null ? null : json["username"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        phone: json["phone"] == null ? null : json["phone"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname == null ? null : fullname,
        "email": email == null ? null : email,
        "username": username == null ? null : username,
        "avatar": avatar == null ? null : avatar,
        "phone": phone == null ? null : phone,
        "id": id == null ? null : id,
      };
}

class RegModel {
  String? fullname;
  String? email;
  String? username;
  String? password;
  String? password_confirmation;
  String? avatar;
  String? referrer_username;


  RegModel({
    this.fullname,
    this.email,
    this.username,
    this.password,
    this.avatar,
    this.password_confirmation,
    this.referrer_username,
  });
}
