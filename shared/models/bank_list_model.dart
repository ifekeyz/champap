// To parse this JSON data, do
//
//     final bankListPayload = bankListPayloadFromJson(jsonString);

import 'dart:convert';

BankListPayload bankListPayloadFromJson(String str) =>
    BankListPayload.fromJson(json.decode(str));

String bankListPayloadToJson(BankListPayload data) =>
    json.encode(data.toJson());

class BankListPayload {
  BankListPayload({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<BankData>? data;

  factory BankListPayload.fromJson(Map<String, dynamic> json) =>
      BankListPayload(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<BankData>.from(
                json["data"].map((x) => BankData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BankData {
  BankData({
    this.accountNo,
    this.bvn,
    this.accountName,
    this.bankName,
    this.bankCode,
  });

  dynamic accountNo;
  dynamic bvn;
  dynamic accountName;
  String? bankName;
  String? bankCode;

  factory BankData.fromJson(Map<String, dynamic> json) => BankData(
        accountNo: json["accountNo"],
        bvn: json["bvn"],
        accountName: json["accountName"],
        bankName: json["bankName"],
        bankCode: json["bankCode"],
      );

  Map<String, dynamic> toJson() => {
        "accountNo": accountNo,
        "bvn": bvn,
        "accountName": accountName,
        "bankName": bankName,
        "bankCode": bankCode,
      };
}
