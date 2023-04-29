import 'dart:async';
import 'package:champ_app/modules/game_module/view_model/unity_view.dart';
import 'package:champ_app/shared/models/match_model.dart';
import 'package:champ_app/shared/models/token_history_payload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/service_injector/service_injector.dart';
import '../../../core/services/game_service.dart';
import '../../../core/view_model/base_vm.dart';
import '../../../router/transitional_router.dart';
import '../../../shared/models/api_model.dart';
// import '../../home_module/ /tournament.dart';
import '../versus.dart';

class GameViewModel extends BaseViewModel {
  final GameService? gameService;
  final BuildContext context;
  final bool isVersus;

  GameViewModel(
      {this.gameService, required this.context, this.isVersus = false});

  List<PayloadFromTokenHistory> tokenHistoryContent = [];

  int totalToken = 0;
  int stakeAmount = 0;

  @override
  FutureOr<void> init() {
    // TODO: implement init
    getTokenHistory();

    if (isVersus) {
      Timer(const Duration(seconds: 5), () => loadGameUp());
    }
  }

  void loadGameUp() {

    Navigator.push(context, TransitionalRoute(UnityScreen()));
    // Navigator.push(context, TransitionalRoute(Tournament()));

    /// TODO: ADD THE CODE TO ENTER UNITY HERE
    ///
    ///
    ///
  }

  String? message;

  List<int> stakeAmountOptions = [0, 200, 500, 1000, 2000, 5000, 10000];

  void increaseStakeAmount() {
    if (totalToken > stakeAmount) {
      if (stakeAmount < stakeAmountOptions.length) {
        stakeAmount += 1;
        stakeAmountOptions[stakeAmount];
        notifyListeners();
      } else {
        showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: "Max reached!",
          ),
        );
      }
    } else {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Max reached!",
        ),
      );
    }
  }

  void decreaseStakeAmount() {
    if (stakeAmount > 0) {
      stakeAmount -= 1;

      notifyListeners();
    } else {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Limit reached!",
        ),
      );
    }
  }

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

      for (var item in tokenHistoryContent) {
        totalToken += item.token!;
      }

      notifyListeners();
      changeStatus();
      changeStatus();
      return res.success;
    }
  }

  Future<bool?> startMatch(BuildContext context, index) async {
    context.loaderOverlay.show();

    final ApiResponse<MatchPayload> res = await si.gameService!.startMatch(
        stakeAmount: stakeAmount, gameType: index == 1 ? 'coin' : 'token');

    debugPrint("yess----: " + res.data.toString());
    debugPrint("yess----1: " + res.message.toString());
    debugPrint("yess----2: " + res.success.toString());

    if (res.success == false) {
      context.loaderOverlay.hide();
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
      context.loaderOverlay.hide();
      message = "Success!";

      showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: message!,
          ));
      isLoading = false;

      debugPrint("MATCH OUTPUT ----- ${res.data!.data![0].users!.fullname}");
      debugPrint("MATCH OUTPUT ----- ${res.data!.data![1].users!.fullname}");

      Navigator.push(
        context,
        TransitionalRoute(
          Versus(matchData: res.data!.data!, amount: stakeAmount),
        ),
      );

      notifyListeners();
      return res.success;
    }
  }
}
