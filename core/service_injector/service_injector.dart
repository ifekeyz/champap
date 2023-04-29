import 'package:champ_app/core/services/api_service.dart';
import 'package:champ_app/core/services/auth_service.dart';
import 'package:champ_app/core/services/color_service.dart';
import 'package:champ_app/core/services/layout_service.dart';
import 'package:champ_app/core/services/router_service.dart';
import 'package:champ_app/core/services/storage_service.dart';
import 'package:champ_app/core/services/store_service.dart';
import 'package:champ_app/core/services/user_service.dart';

import '../services/game_service.dart';
import '../services/home_service.dart';
import '../services/wallet_service.dart';

class Injector {
  StoreService storeService = StoreService();
  StorageService storageService = StorageService();
  LayoutService layoutService = LayoutService();
  RouterService routerService = RouterService();
  ApiService? apiService;
  AuthService? authService;
  HomeService? homeService;
  WalletService? walletService;
  GameService? gameService;
  ColorService? colorService;
  UserService? userService;
  Future<bool> init() async {
    // init storage service
    await storageService.initStorage();

    apiService = ApiService(storeService);
    // color and theme service
    colorService = ColorService(storageService);
    authService = AuthService(
      storageService: storageService,
      storeService: storeService,
    );
    homeService = HomeService(
      storageService: storageService,
      storeService: storeService,
    );
    walletService = WalletService(
      storageService: storageService,
      storeService: storeService,
    );
    gameService = GameService(
      storageService: storageService,
      storeService: storeService,
    );
    userService = UserService(
      storageService: storageService,
      apiService: apiService,
    );

    return true;
  }
}

Injector si = Injector();
