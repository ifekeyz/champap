import 'dart:async';

import 'package:champ_app/core/services/wallet_service.dart';
import 'package:champ_app/shared/models/token_history_payload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/service_injector/service_injector.dart';
import '../../../core/view_model/base_vm.dart';
import '../../../shared/models/api_model.dart';
import '../../../shared/models/balance_model.dart';

class WalletViewModel extends BaseViewModel {
  final WalletService? walletService;
  final BuildContext context;

  WalletViewModel({this.walletService, required this.context});

  List<PayloadFromTokenHistory> tokenHistoryContent = [];

  int totalToken = 0;
  String totalCoin = "0";

  @override
  FutureOr<void> init() {
    // TODO: implement init
    getTokenHistory();
    getWalletBalance();
  }

  String? message;

  Future<bool?> getTokenHistory() async {
    changeStatus();
    // changeStatus();
    context.loaderOverlay.show();
    final ApiResponse<TokenHistoryPayload> res =
        await si.walletService!.getTokenHistory();
    // debugPrint("res first ${res.message}");

    print("yess----: " + res.data.toString());
    print("yess----1: " + res.message.toString());
    print("yess----2: " + res.success.toString());

    if (res.success == false) {
      context.loaderOverlay.hide();
      isLoading = res.success;
      message = res.message ?? "Error occured";
      // debugPrint("res err mess ${res.message}");
      showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: message!,
          ));
      changeStatus();
      changeStatus();
      return res.success;
    } else {
      context.loaderOverlay.hide();
      message = "Success!";

      showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: message!,
          ));
      isLoading = false;
      debugPrint("heyyy" + res.data!.data!.toString());
      tokenHistoryContent = res.data!.data!;

      tokenHistoryContent.forEach((PayloadFromTokenHistory item) {
        //getting the key directly from the name of the key
        totalToken += item.token!;
      });

      // Navigator.push(
      //   context,
      //   MainRouter.generateRoute(
      //     const RouteSettings(name: RoutePaths.login),
      //   ),
      // );
      notifyListeners();
      changeStatus();
      changeStatus();
      return res.success;
    }
  }

  Future<bool?> getWalletBalance() async {
    // changeStatus();
    // changeStatus();
    // context.loaderOverlay.show();
    final ApiResponse<BalancePayload> res =
        await si.walletService!.getWalletBalance();
    // debugPrint("res first ${res.message}");

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

      showTopSnackBar(
          context,
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
