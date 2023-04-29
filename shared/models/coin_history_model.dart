// To parse this JSON data, do
//
//     final coinHistoryPayload = coinHistoryPayloadFromJson(jsonString);

import 'dart:convert';

CoinHistoryPayload coinHistoryPayloadFromJson(String str) =>
    CoinHistoryPayload.fromJson(json.decode(str));

String coinHistoryPayloadToJson(CoinHistoryPayload data) =>
    json.encode(data.toJson());

class CoinHistoryPayload {
  CoinHistoryPayload({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory CoinHistoryPayload.fromJson(Map<String, dynamic> json) =>
      CoinHistoryPayload(
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
    this.coinHistories,
  });

  List<CoinHistory>? coinHistories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        coinHistories: json["coin_histories"] == null
            ? null
            : List<CoinHistory>.from(
                json["coin_histories"].map((x) => CoinHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "coin_histories": coinHistories == null
            ? null
            : List<dynamic>.from(coinHistories!.map((x) => x.toJson())),
      };
}

class CoinHistory {
  CoinHistory({
    this.id,
    this.recipientId,
    this.senderId,
    this.bankName,
    this.accountNumber,
    this.status,
    this.transactionNumber,
    this.transactionType,
    this.description,
    this.amount,
    this.transactionRef,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  dynamic? recipientId;
  int? senderId;
  String? bankName;
  String? accountNumber;
  String? status;
  String? transactionNumber;
  String? transactionType;
  String? description;
  String? amount;
  String? transactionRef;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CoinHistory.fromJson(Map<String, dynamic> json) => CoinHistory(
        id: json["id"],
        recipientId: json["recipient_id"],
        senderId: json["sender_id"],
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        status: json["status"],
        transactionNumber: json["transaction_number"],
        transactionType: json["transaction_type"],
        description: json["description"],
        amount: json["amount"],
        transactionRef: json["transaction_ref"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "recipient_id": recipientId,
        "sender_id": senderId,
        "bank_name": bankName,
        "account_number": accountNumber,
        "status": status,
        "transaction_number": transactionNumber,
        "transaction_type": transactionType,
        "description": description,
        "amount": amount,
        "transaction_ref": transactionRef,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
