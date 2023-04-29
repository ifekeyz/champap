// To parse this JSON data, do
//
//     final loginSuccessPayload = loginSuccessPayloadFromJson(jsonString);

import 'dart:convert';

LoginSuccessPayload loginSuccessPayloadFromJson(String str) =>
    LoginSuccessPayload.fromJson(json.decode(str));

String loginSuccessPayloadToJson(LoginSuccessPayload data) =>
    json.encode(data.toJson());

class LoginSuccessPayload {
  LoginSuccessPayload({
    this.success,
    this.message,
    this.token,
    this.first_time_login,
  });

  bool? success;
  String? message;
  String? token;
  bool? first_time_login;

  factory LoginSuccessPayload.fromJson(Map<String, dynamic> json) =>
      LoginSuccessPayload(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        token: json["token"] == null ? null : json["token"],
        first_time_login:
            json["first_time_login"] == null ? null : json["first_time_login"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "token": token == null ? null : token,
        "first_time_login": first_time_login == null ? null : first_time_login,
      };
}
