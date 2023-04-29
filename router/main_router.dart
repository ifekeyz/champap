import 'package:champ_app/modules/auth/create_pin.dart';
import 'package:champ_app/modules/auth/fund_wallet.dart';
import 'package:champ_app/modules/auth/login_first_user.dart';
import 'package:champ_app/modules/game_module/select_game_mode.dart';
import 'package:champ_app/modules/home_module/welcome.dart';
import 'package:champ_app/modules/settings_module/help_screen.dart';
import 'package:champ_app/modules/splash.dart';
import 'package:champ_app/modules/wallet_module/wallet_coin.dart';
import 'package:champ_app/modules/wallet_module/wallet_token.dart';
import 'package:champ_app/router/route_paths.dart';
import 'package:flutter/material.dart';

import '../modules/app_module/layout/bottom_nav.dart';
import '../modules/auth/proceed_to_fund_wallet.dart';
import '../modules/auth/signup.dart';
import '../modules/settings_module/reset_password.dart';

class MainRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splash:
        return MaterialPageRoute(builder: (_) => const Splash());
      case RoutePaths.login:
        return MaterialPageRoute(builder: (_) => const LoginFirstUser());
      case RoutePaths.signUp:
        return MaterialPageRoute(builder: (_) => const RegisterUser());
      case RoutePaths.createPIN:
        return MaterialPageRoute(builder: (_) => CreatePin());
      case RoutePaths.fundWallet:
        return MaterialPageRoute(builder: (_) => FundWallet());
      case RoutePaths.fundWallet2:
        return MaterialPageRoute(builder: (_) => ProceedFundWallet());
      case RoutePaths.bottomNav:
        return MaterialPageRoute(builder: (_) => BottomNav());
      case RoutePaths.welcome:
        return MaterialPageRoute(builder: (_) => Welcome());
      case RoutePaths.walletCoin:
        return MaterialPageRoute(builder: (_) => WalletCoin());
      case RoutePaths.walletToken:
        return MaterialPageRoute(builder: (_) => WalletToken());
      case RoutePaths.resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case RoutePaths.helpScreen:
        return MaterialPageRoute(builder: (_) => HelpScreen());
      case RoutePaths.selectGameMode:
        return MaterialPageRoute(builder: (_) => SelectGameMode());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
