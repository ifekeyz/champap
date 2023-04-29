// To parse this JSON data, do
//
//     final balancePayload = balancePayloadFromJson(jsonString);

import 'dart:convert';

BalancePayload balancePayloadFromJson(String str) =>
    BalancePayload.fromJson(json.decode(str));

String balancePayloadToJson(BalancePayload data) => json.encode(data.toJson());

class BalancePayload {
  BalancePayload({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory BalancePayload.fromJson(Map<String, dynamic> json) => BalancePayload(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.token,
    this.coin,
  });

  TokenBalance? token;
  CoinBalance? coin;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token:
            json["token"] == null ? null : TokenBalance.fromJson(json["token"]),
        coin: json["coin"] == null ? null : CoinBalance.fromJson(json["coin"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token!.toJson(),
        "coin": coin == null ? null : coin!.toJson(),
      };
}

class CoinBalance {
  CoinBalance({
    this.id,
    this.userId,
    this.previousBalance,
    this.currentBalance,
  });

  int? id;
  int? userId;
  String? previousBalance;
  String? currentBalance;

  factory CoinBalance.fromJson(Map<String, dynamic> json) => CoinBalance(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        previousBalance:
            json["previous_balance"] == null ? null : json["previous_balance"],
        currentBalance:
            json["current_balance"] == null ? null : json["current_balance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "previous_balance": previousBalance == null ? null : previousBalance,
        "current_balance": currentBalance == null ? null : currentBalance,
      };
}

class TokenBalance {
  TokenBalance({
    this.id,
    this.userId,
    this.token,
  });

  int? id;
  int? userId;
  int? token;

  factory TokenBalance.fromJson(Map<String, dynamic> json) => TokenBalance(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "token": token == null ? null : token,
      };
}
