// To parse this JSON data, do
//
//     final unityScoreModel = unityScoreModelFromJson(jsonString);

import 'dart:convert';

UnityScoreModel unityScoreModelFromJson(String str) =>
    UnityScoreModel.fromJson(json.decode(str));

String unityScoreModelToJson(UnityScoreModel data) =>
    json.encode(data.toJson());

class UnityScoreModel {
  UnityScoreModel({
    this.youWon,
    this.yourScore,
    this.draw,
    this.winnerId,
    this.matchId,
    this.scores,
  });

  bool? youWon;
  int? yourScore;
  bool? draw;
  String? winnerId;
  String? matchId;
  List<int>? scores;

  factory UnityScoreModel.fromJson(Map<String, dynamic> json) =>
      UnityScoreModel(
        youWon: json["you_won"],
        yourScore: json["your_score"],
        draw: json["draw"],
        winnerId: json["winner_id"],
        matchId: json["match_id"],
        scores: json["scores"] == null
            ? []
            : List<int>.from(json["scores"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "you_won": youWon,
        "your_score": yourScore,
        "draw": draw,
        "winner_id": winnerId,
        "match_id": matchId,
        "scores":
            scores == null ? [] : List<dynamic>.from(scores!.map((x) => x)),
      };
}
