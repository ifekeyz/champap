import 'package:champ_app/shared/models/match/match_score_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../show_score_screen.dart';

class UnityScreen extends StatefulWidget {
  UnityScreen({Key? key}) : super(key: key);

  @override
  _UnityScreenState createState() => _UnityScreenState();
}

class _UnityScreenState extends State<UnityScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  late UnityWidgetController _unityWidgetController;

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: WillPopScope(
          onWillPop: () {
            throw ('');
            // Pop the category page if Android back button is pressed.
          },
          child: Container(
            color: Colors.yellow,
            child: UnityWidget(
              onUnityCreated: onUnityCreated,
              onUnityMessage:onUnityMessage,
            ),
          ),
        ),
      ),
    );
  }

  // Callback that connects the created controller to the unity controller
  Future<void> onUnityCreated(controller) async {
    this._unityWidgetController = controller;
    final prefs = await SharedPreferences.getInstance();
    final player_one = prefs.getString('playerOne') ?? '';
    final player_two = prefs.getString('playerTwo') ?? '';
    final username = prefs.getString('username') ?? '';
    print(player_one + player_two + username);
    int turn = 0;
    if (username == player_one) {
      turn = 1;
      await Future.delayed(const Duration(seconds: 7), () {
        setMatch(
            '{"player_one":"${player_one}", "player_two":"${player_two}", "matchID":"1E24W", "first":${turn} }');
      });
    } else {
      turn = 2;
      await Future.delayed(const Duration(seconds: 7), () {
        setMatch(
            '{"player_one":"${player_two}", "player_two":"${player_one}", "matchID":"1E24W", "first":${turn} }');
      });
    }
    // await Future.delayed(const Duration(seconds: 12), ()
    // {
    //   setMatch('{"player_one":"${player_one}", "player_two":"${player_two}", "matchID":"1E24W", "first":${turn} }');
    // }
    // );
  }

  void onUnityMessage(message) {
    debugPrint('Received message from unity: ${message.toString()}');

    /// HELLO SIMI, THIS VARIABLE message.toString() WILL HAVE THE INFORMATION FROM UNITY

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScoringScreen(
          unityScoreModel: UnityScoreModel.fromJson(message),
        ),
      ),
    );
    //  IT WILL BE A "json string" WHICH WILL BE CONVERTED TO JSON TO GET THE WINNER AND OTHER VARIABLES
    //  THEN UPLOADED TO THE BACKEND
  }

  void setMatch(String matchSettings) {
    _unityWidgetController.postMessage(
      'Manager',
      'SetMatch',
      matchSettings,
    );
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(SceneLoaded sceneInfo) {
    debugPrint('Received scene loaded from unity: ${sceneInfo.name}');
    debugPrint(
        'Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
  }
}
