import 'dart:async';

import 'package:champ_app/shared/models/match/match_score_model.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/service_injector/service_injector.dart';
import '../../../core/services/game_service.dart';
import '../../../core/view_model/base_vm.dart';
import '../../../shared/models/api_model.dart';

class EndGameViewModel extends BaseViewModel {
  final GameService? gameService;
  final BuildContext context;
  final bool isVersus;
  final UnityScoreModel? unityScoreModel;

  EndGameViewModel(
      {this.gameService,
      required this.context,
      this.isVersus = false,
      this.unityScoreModel});

  String message = "";

  @override
  FutureOr<void> init() async {
    // TODO: implement init

    await submitScores(context, unityScoreModel!);
    throw UnimplementedError();
  }

  Future<bool?> submitScores(
      BuildContext context, UnityScoreModel unityScoreModel) async {
    context.loaderOverlay.show();

    final ApiResponse<dynamic> res =
        await si.gameService!.submitScores(unityScoreModel);

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

      // Navigator.push(
      //   context,
      //   TransitionalRoute(
      //     Versus(matchData: res.data!.data!, amount: stakeAmount),
      //   ),
      // );

      notifyListeners();
      return res.success;
    }
  }
}
