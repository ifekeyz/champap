// ignore_for_file: unused_import

import 'dart:convert';

import 'package:champ_app/modules/game_module/game.dart';
import 'package:champ_app/modules/leader_board_module/leaders.dart';
import 'package:champ_app/modules/settings_module/settings.dart';
import 'package:champ_app/modules/wallet_module/wallet.dart';
import 'package:flutter/material.dart';

import '../../modules/home_module/home.dart';
import '../../shared/utils/color.dart';

class BottomNavModel extends ChangeNotifier {
  ///current index of the bottom nav-bar
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  ///children of the bottom Nav
  List<Widget> _children = [
     Home(),
     Leaders(),
      Games(),
      Wallet(),
      Settings()
  ];

  List<Widget> get children => _children;

  ///updates the current index of the bottom nav
  updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
