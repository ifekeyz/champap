// To parse this JSON data, do
//
//     final resolveBankPayload = resolveBankPayloadFromJson(jsonString);

import 'dart:convert';

ResolveBankPayload resolveBankPayloadFromJson(String str) =>
    ResolveBankPayload.fromJson(json.decode(str));

String resolveBankPayloadToJson(ResolveBankPayload data) =>
    json.encode(data.toJson());

class ResolveBankPayload {
  ResolveBankPayload({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory ResolveBankPayload.fromJson(Map<String, dynamic> json) =>
      ResolveBankPayload(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.accountNumber,
    this.accountName,
  });

  String? accountNumber;
  String? accountName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "accountName": accountName,
      };
}
