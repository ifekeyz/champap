// To parse this JSON data, do
//
//     final withdrawResponseModel = withdrawResponseModelFromJson(jsonString);

import 'dart:convert';

WithdrawResponseModel withdrawResponseModelFromJson(String str) =>
    WithdrawResponseModel.fromJson(json.decode(str));

String withdrawResponseModelToJson(WithdrawResponseModel data) =>
    json.encode(data.toJson());

class WithdrawResponseModel {
  WithdrawResponseModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory WithdrawResponseModel.fromJson(Map<String, dynamic> json) =>
      WithdrawResponseModel(
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
    this.transactionNumber,
    this.txnRef,
    this.amount,
    this.charges,
    this.commission,
    this.type,
    this.status,
    this.service,
    this.narration,
    this.dateCreated,
    this.recipientName,
    this.recipientAccount,
    this.recipientPhone,
    this.initBalance,
    this.balance,
  });

  String? transactionNumber;
  String? txnRef;
  double? amount;
  double? charges;
  double? commission;
  String? type;
  String? status;
  String? service;
  String? narration;
  String? dateCreated;
  String? recipientName;
  String? recipientAccount;
  String? recipientPhone;
  double? initBalance;
  double? balance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionNumber: json["transactionNumber"],
        txnRef: json["txnRef"],
        amount: json["amount"],
        charges: json["charges"],
        commission: json["commission"],
        type: json["type"],
        status: json["status"],
        service: json["service"],
        narration: json["narration"],
        dateCreated: json["dateCreated"],
        recipientName: json["recipientName"],
        recipientAccount: json["recipientAccount"],
        recipientPhone: json["recipientPhone"],
        initBalance: json["initBalance"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "transactionNumber": transactionNumber,
        "txnRef": txnRef,
        "amount": amount,
        "charges": charges,
        "commission": commission,
        "type": type,
        "status": status,
        "service": service,
        "narration": narration,
        "dateCreated": dateCreated,
        "recipientName": recipientName,
        "recipientAccount": recipientAccount,
        "recipientPhone": recipientPhone,
        "initBalance": initBalance,
        "balance": balance,
      };
}
