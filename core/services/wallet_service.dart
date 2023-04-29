import 'dart:async';

import 'package:champ_app/core/service_injector/service_injector.dart';
import 'package:champ_app/core/services/storage_service.dart';
import 'package:champ_app/core/services/store_service.dart';
import 'package:champ_app/shared/models/api_model.dart';
import 'package:champ_app/shared/models/balance_model.dart';
import 'package:champ_app/shared/models/resolve_bank_model.dart';
import 'package:champ_app/shared/utils/config.dart';
import 'package:flutter/material.dart';

import '../../shared/models/bank_list_model.dart';
import '../../shared/models/coin_history_model.dart';
import '../../shared/models/confirm_pin_model.dart';
import '../../shared/models/reward_model.dart';
import '../../shared/models/token_history_payload.dart';
import '../../shared/models/withdraw_model.dart';
import '../../shared/models/withdraw_response_model.dart';

class WalletService {
  WalletService({
    required this.storageService,
    required this.storeService,
  });

  StorageService storageService;
  StoreService storeService;

  Future<ApiResponse<BalancePayload>> getWalletBalance() async {
    return si.apiService!.getApi<BalancePayload>(
      'users/balance',
      transform: (dynamic res) {
        debugPrint("wallet balance $res");
        return BalancePayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<TokenHistoryPayload>> getTokenHistory() async {
    return si.apiService!.getApi<TokenHistoryPayload>(
      'users/token/history',
      transform: (dynamic res) {
        debugPrint("auth ress2 $res");
        return TokenHistoryPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<CoinHistoryPayload>> getCoinHistory() async {
    return si.apiService!.getApi<CoinHistoryPayload>(
      'users/coin/histories',
      transform: (dynamic res) {
        debugPrint("auth ress2 $res");
        return CoinHistoryPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<BankListPayload>> getBankList() async {
    debugPrint("=========ehe1");
    return si.apiService!.getApiThree<BankListPayload>(
      'https://tmoni-staging-server.herokuapp.com/api/bank-list',
      transform: (dynamic res) {
        debugPrint("auth ress2 $res");
        return BankListPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<ResolveBankPayload>> resolveBankName(
      accNo, bankCode) async {
    final Map<String, String> body = <String, String>{
      "accountnumber": accNo,
      "bankcode": bankCode
    };

    return si.apiService!.postApiThree<ResolveBankPayload>(
      'https://tmoni-staging-server.herokuapp.com/api/resolve-account-name',
      body,
      transform: (dynamic res) {
        debugPrint("auth ress2 $res");
        return ResolveBankPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<RewardPayload>> addToken() {
    final Map<String?, dynamic?> body = <String?, dynamic?>{
      "video_id": 1,
    };

    print(body.toString());

    AppConfig.profilePictureTimestamp = DateTime.now().millisecondsSinceEpoch;
    return si.apiService!.postApi<RewardPayload>(
      'users/token/video',
      body,
      transform: (dynamic res) {
        debugPrint("auth ress $res");
        return RewardPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<WithdrawResponseModel>> withdrawCoin(
      WithdrawModel withdrawModel) {
    final Map<String?, dynamic> body = <String?, dynamic>{
      "accountName": withdrawModel.accountName,
      "accountNumber": withdrawModel.accountNumber,
      "amount": withdrawModel.amount,
      "bankName": withdrawModel.bankName,
      "bankCode": withdrawModel.bankCode,
      "narration": "Some payment"
    };

    debugPrint(body.toString());

    AppConfig.profilePictureTimestamp = DateTime.now().millisecondsSinceEpoch;
    return si.apiService!.postApi<WithdrawResponseModel>(
      'users/coin/withdraw',
      body,
      transform: (dynamic res) {
        debugPrint("auth ress $res");
        return WithdrawResponseModel.fromJson(res);
      },
    );
  }

  Future<ApiResponse<ConfirmPinModel>> confirmPin(String pin) {
    final Map<String, String> body = <String, String>{
      "pin": pin,
    };
    print("body" + body.toString());
    return si.apiService!.postApi<ConfirmPinModel>(
      'users/confirm-pin',
      body,
      transform: (dynamic res) {
        return ConfirmPinModel.fromJson(res);
      },
    );
  }
}
