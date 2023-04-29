// To parse this JSON data, do
//
//     final withdrawModel = withdrawModelFromJson(jsonString);

import 'dart:convert';

WithdrawModel withdrawModelFromJson(String str) =>
    WithdrawModel.fromJson(json.decode(str));

String withdrawModelToJson(WithdrawModel data) => json.encode(data.toJson());

class WithdrawModel {
  WithdrawModel({
    this.accountName,
    this.accountNumber,
    this.amount,
    this.bankName,
    this.bankCode,
    this.narration,
  });

  String? accountName;
  String? accountNumber;
  int? amount;
  String? bankName;
  String? bankCode;
  String? narration;

  factory WithdrawModel.fromJson(Map<String, dynamic> json) => WithdrawModel(
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        amount: json["amount"],
        bankName: json["bankName"],
        bankCode: json["bankCode"],
        narration: json["narration"],
      );

  Map<String, dynamic> toJson() => {
        "accountName": accountName,
        "accountNumber": accountNumber,
        "amount": amount,
        "bankName": bankName,
        "bankCode": bankCode,
        "narration": narration,
      };
}
