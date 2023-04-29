import 'dart:async';

import 'package:champ_app/shared/models/leader_board/leader_board_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/service_injector/service_injector.dart';
import '../../../core/services/game_service.dart';
import '../../../core/view_model/base_vm.dart';
import '../../../shared/models/api_model.dart';

class LeaderViewModel extends BaseViewModel {
  final GameService? gameService;
  final BuildContext context;

  LeaderViewModel({this.gameService, required this.context});

  String message = "";
  PayloadFromLeaderboard payloadFromLeaderboard = PayloadFromLeaderboard();
  List<PayloadFromLeaderboard> leaderboardData = [];

  @override
  FutureOr<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  Future<bool?> getTokenHistory() async {
    changeStatus();
    // changeStatus();
    context.loaderOverlay.show();

    final ApiResponse<LeaderBoardPayload> res =
        await si.gameService!.getLeaderboard();
    // debugPrint("res first ${res.message}");

    debugPrint("yess----: " + res.data.toString());
    debugPrint("yess----1: " + res.message.toString());
    debugPrint("yess----2: " + res.success.toString());

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
      leaderboardData = res.data!.data!;

      notifyListeners();
      changeStatus();
      changeStatus();
      return res.success;
    }
  }
}
