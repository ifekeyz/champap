import 'dart:async';

import 'package:champ_app/shared/models/coin_history_model.dart';
import 'package:champ_app/shared/models/withdraw_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/service_injector/service_injector.dart';
import '../../../core/services/wallet_service.dart';
import '../../../core/view_model/base_vm.dart';
import '../../../shared/models/api_model.dart';
import '../../../shared/models/balance_model.dart';
import '../../../shared/models/bank_list_model.dart';
import '../../../shared/models/confirm_pin_model.dart';
import '../../../shared/models/resolve_bank_model.dart';
import '../../../shared/models/withdraw_response_model.dart';
import '../widgets/withdrawal_successful.dart';

class CoinViewModel extends BaseViewModel {
  final WalletService? walletService;
  final BuildContext? context;

  CoinViewModel({this.walletService, this.context});

  List<BankData> bankList = [];
  List<String> bankNameList = ["Select a bank"];
  String selectedBank = "Select a bank";
  String selectedBankCode = "";
  String accName = "";
  List<CoinHistory> coinHistoryContent = [];
  int totalToken = 0;

  String totalCoin = "0";

  @override
  FutureOr<void> init() {
    // TODO: implement init
    getCoinHistory();
    getBankList();
    getWalletBalance();
  }

  String? message;

  // Future<bool?> getCoinHistory() async {
  //   changeStatus();
  //   // changeStatus();
  //   context.loaderOverlay.show();
  //   final ApiResponse<TokenHistoryPayload> res =
  //       await si.walletService!.getTokenHistory();
  //   // debugPrint("res first ${res.message}");
  //
  //   debugPrint("yess----: " + res.data.toString());
  //   debugPrint("yess----1: " + res.message.toString());
  //   debugPrint("yess----2: " + res.success.toString());
  //
  //   if (res.success == false) {
  //     context.loaderOverlay.hide();
  //     isLoading = res.success;
  //     message = res.message ?? "Error occurred";
  //     // debugPrint("res err mess ${res.message}");
  //     showTopSnackBar(
  //         context,
  //         CustomSnackBar.error(
  //           message: message!,
  //         ));
  //     changeStatus();
  //     changeStatus();
  //     return res.success;
  //   } else {
  //     context.loaderOverlay.hide();
  //     message = "Success!";
  //
  //     showTopSnackBar(
  //         context,
  //         CustomSnackBar.success(
  //           message: message!,
  //         ));
  //     isLoading = false;
  //     debugPrint("heyyy" + res.data!.data!.toString());
  //     tokenHistoryContent = res.data!.data!;
  //
  //     tokenHistoryContent.forEach((PayloadFromTokenHistory item) {
  //       //getting the key directly from the name of the key
  //       totalToken += item.token!;
  //     });
  //
  //     // Navigator.push(
  //     //   context,
  //     //   MainRouter.generateRoute(
  //     //     const RouteSettings(name: RoutePaths.login),
  //     //   ),
  //     // );
  //     notifyListeners();
  //     changeStatus();
  //     changeStatus();
  //     return res.success;
  //   }
  // }

  onSelectedBank(value) {
    debugPrint("=================2222 $value");
    debugPrint("=================2222 $bankList");
    bankList.forEach((BankData item) {
      //getting the key directly from the name of the key
      if (item.bankName == value) {
        selectedBankCode = item.bankCode!;
        selectedBank = value;
      }
    });
    debugPrint("==1111===$selectedBankCode=====");
    notifyListeners();
  }

  Future<bool?> getBankList() async {
    // debugPrint("res firs=================");
    // changeStatus();
    // changeStatus();
    // context.loaderOverlay.show();
    final ApiResponse<BankListPayload> res =
        await si.walletService!.getBankList();
    // debugPrint("res first ${res.message}");

    // debugPrint("yess----: " + res.data.toString());
    // debugPrint("yess----1: " + res.message.toString());
    // debugPrint("yess----2: " + res.success.toString());

    if (res.success == false) {
      // context.loaderOverlay.hide();
      isLoading = res.success;
      message = res.message ?? "Error occurred";
      // debugPrint("res err mess ${res.message}");
      showTopSnackBar(
          context!,
          CustomSnackBar.error(
            message: message!,
          ));
      // changeStatus();
      // changeStatus();
      return res.success;
    } else {
      bankNameList = ["Select a bank"];
      // context.loaderOverlay.hide();
      message = "Success!";
      bankList = res.data!.data!;
      // showTopSnackBar(
      //     context,
      //     CustomSnackBar.success(
      //       message: message!,
      //     ));
      isLoading = false;

      bankList.forEach((BankData item) {
        //getting the key directly from the name of the key
        bankNameList.add(item.bankName!);
      });
      bankNameList.sort();
      debugPrint("========34==$bankList=====");
      notifyListeners();
      // changeStatus();
      // changeStatus();
      return res.success;
    }
  }

  Future<String> resolveAccountName({required String accNo}) async {
    accName = "";
    debugPrint("res firs=================$accNo === $selectedBankCode=====");
    // changeStatus();
    // changeStatus();
    // context.loaderOverlay.show();

    final ApiResponse<ResolveBankPayload> res =
        await si.walletService!.resolveBankName(accNo, selectedBankCode);
    // debugPrint("res first ${res.message}");

    // debugPrint("yess----: " + res.data.toString());
    debugPrint("yess----1: " + res.message.toString());
    // debugPrint("yess----2: " + res.success.toString());

    if (res.success == false) {
      // context.loaderOverlay.hide();
      isLoading = res.success;
      message = res.message ?? "Error occurred";
      // debugPrint("res err mess ${res.message}");
      showTopSnackBar(
          context!,
          CustomSnackBar.error(
            message: message!,
          ));
      // changeStatus();
      // changeStatus();
      return "";
    } else {
      // context.loaderOverlay.hide();
      message = "Success!";

      // showTopSnackBar(
      //     context,
      //     CustomSnackBar.success(
      //       message: message!,
      //     ));
      isLoading = false;
      accName = res.data!.data!.accountName!;
      debugPrint("==========$accName=====");
      notifyListeners();
      return accName;
    }
  }

  Future<String> withdrawCoin(
      {required BuildContext context,
      required WithdrawModel withdrawModel}) async {
    // accName = "";
    debugPrint(
        "res firs=================${withdrawModel.bankName} === ${withdrawModel.bankCode}=====");

    final ApiResponse<WithdrawResponseModel> res =
        await si.walletService!.withdrawCoin(withdrawModel);
    debugPrint("yess----1: " + res.message.toString());

    if (res.success == false) {
      // context.loaderOverlay.hide();
      isLoading = res.success;
      message = res.message ?? "Error occurred";
      // debugPrint("res err mess ${res.message}");
      showTopSnackBar(
          context!,
          CustomSnackBar.error(
            message: message!,
          ));

      return "";
    } else {
      // context.loaderOverlay.hide();
      message = "Success!";

      Navigator.pop(context);

      await showModalBottomSheet(
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return withdrawalSuccess(context);
        },
      );
      isLoading = false;
      // accName = res.data!.data!.accountName!;
      // debugPrint("==========$accName=====");
      notifyListeners();
      return accName;
    }
  }

  Future<bool?> confirmPin(BuildContext context,
      {required pin, required WithdrawModel withdrawModel}) async {
    // changeStatus();
    // context.loaderOverlay.show();

    debugPrint("==========$pin=====");
    final ApiResponse<ConfirmPinModel> res =
        await si.walletService!.confirmPin(pin);
    // debugPrint("res first ${res.message}");

    // print("yess----: " + res.data.toString());
    // print("yess----1: " + res.message.toString());
    // print("yess----2: " + res.success.toString());

    if (res.success == false) {
      // context.loaderOverlay.hide();
      isLoading = res.success;
      message = res.message ?? "Error occurred";
      // debugPrint("res err mess ${res.message}");
      showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: message!,
          ));

      return res.success;
    } else {
      // context.loaderOverlay.hide();
      message = "Success!";
      debugPrint("========33==$message=====");
      isLoading = false;
      // Navigator.pop(context);

      await withdrawCoin(context: context, withdrawModel: withdrawModel);

      notifyListeners();
      return res.success;
    }
  }

  Future<bool?> getCoinHistory() async {
    changeStatus();
    // changeStatus();
    // context.loaderOverlay.show();
    final ApiResponse<CoinHistoryPayload> res =
        await si.walletService!.getCoinHistory();
    // debugPrint("res first ${res.message}");

    print("yess----: " + res.data.toString());
    print("yess----1: " + res.message.toString());
    print("yess----2: " + res.success.toString());

    if (res.success == false) {
      // context.loaderOverlay.hide();
      isLoading = res.success;
      message = res.message ?? "Error occured";
      // debugPrint("res err mess ${res.message}");

      showTopSnackBar(
          context!,
          CustomSnackBar.error(
            message: message!,
          ));
      changeStatus();
      changeStatus();
      return res.success;
    } else {
      // context.loaderOverlay.hide();
      message = "Success!";
      coinHistoryContent = res.data!.data!.coinHistories!;
      showTopSnackBar(
          context!,
          CustomSnackBar.success(
            message: message!,
          ));
      isLoading = false;
      debugPrint("heyyy" + res.data!.data!.toString());

      notifyListeners();

      return res.success;
    }
  }

  Future<bool?> getWalletBalance() async {
    // changeStatus();
    // changeStatus();
    final ApiResponse<BalancePayload> res =
        await si.walletService!.getWalletBalance();
    // debugPrint("res first ${res.message}");

    if (res.success == false) {
      isLoading = res.success;
      message = res.message ?? "Error occurred";
      // debugPrint("res err mess ${res.message}");
      showTopSnackBar(
          context!,
          CustomSnackBar.error(
            message: message!,
          ));
      return res.success;
    } else {
      message = "Success!";

      showTopSnackBar(
          context!,
          CustomSnackBar.success(
            message: message!,
          ));
      isLoading = false;
      debugPrint("heyyy" + res.data!.data!.toString());

      totalToken = res.data!.data!.token!.token!;
      totalCoin = res.data!.data!.coin!.currentBalance!;

      // Navigator.push(
      //   context,
      //   MainRouter.generateRoute(
      //     const RouteSettings(name: RoutePaths.login),
      //   ),
      // );
      notifyListeners();
      return res.success;
    }
  }
}
