import 'dart:async';

import 'package:champ_app/core/service_injector/service_injector.dart';
import 'package:champ_app/core/services/storage_service.dart';
import 'package:champ_app/core/services/store_service.dart';
import 'package:champ_app/shared/models/api_model.dart';
import 'package:champ_app/shared/models/leader_board/leader_board_model.dart';
import 'package:flutter/material.dart';

import '../../shared/models/match/match_score_model.dart';
import '../../shared/models/match_model.dart';
import '../../shared/models/token_history_payload.dart';

class GameService {
  GameService({
    required this.storageService,
    required this.storeService,
  });

  StorageService storageService;
  StoreService storeService;

  Future<ApiResponse<TokenHistoryPayload>> getTokenHistory() async {
    return si.apiService!.getApi<TokenHistoryPayload>(
      'users/token/history',
      transform: (dynamic res) {
        debugPrint("auth ress2 $res");
        return TokenHistoryPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<LeaderBoardPayload>> getLeaderboard() async {
    return si.apiService!.getApi<LeaderBoardPayload>(
      'matches/token/leader-board',
      transform: (dynamic res) {
        debugPrint("leader ress2 $res");
        return LeaderBoardPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<MatchPayload>> startMatch(
      {stakeAmount, String? gameType}) {
    final Map<String, dynamic> body = <String, dynamic>{
      "amount": stakeAmount,
      "game_type": gameType ?? "token"
    };

    // print(body.toString());

    return si.apiService!.postApi<MatchPayload>(
      'matches',
      body,
      transform: (dynamic res) {
        debugPrint("match ress $res");
        return MatchPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<dynamic>> submitScores(UnityScoreModel unityScoreModel) {
    final Map<String, dynamic> body = <String, dynamic>{
      "draw": unityScoreModel.draw,
      "winner_id": unityScoreModel.winnerId,
      "match_id": unityScoreModel.matchId,
      "score": unityScoreModel.scores,
    };

    // print(body.toString());

    return si.apiService!.postApi<dynamic>(
      'matches/outcome',
      body,
      transform: (dynamic res) {
        debugPrint("match ress $res");
        return MatchPayload.fromJson(res);
      },
    );
  }
}
