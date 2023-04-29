import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/service_injector/service_injector.dart';
import '../../../core/services/home_service.dart';
import '../../../core/view_model/base_vm.dart';
import '../../../router/main_router.dart';
import '../../../router/route_paths.dart';
import '../../../shared/models/Notification/notification_status_model.dart';
import '../../../shared/models/api_model.dart';
import '../../home_module/widgets/constants.dart';

class SettingsViewModel extends BaseViewModel {
  final HomeService? homeService;
  final BuildContext context;

  SettingsViewModel({this.homeService, required this.context});

  bool onClicked = true;
  bool isOnClicked = true;
  bool offClicked = false;
  String message = "";

  @override
  FutureOr<void> init() {
    // TODO: implement init
    // throw UnimplementedError();
  }

  signOut(context) async {

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("LOGGED_IN", false);
    FirebaseAuth.instance.signOut();
    FacebookAuth.instance.logOut().then((value) {
      userObj = {};
    });

    si.storageService.removeItem('auth_data');
    si.storageService.removeItem('token');

    Navigator.pushReplacement(
      context,
      MainRouter.generateRoute(
        const RouteSettings(name: RoutePaths.login),
      ),
    );
  }

  Future<void> updateNotifStatus({BuildContext? context}) async {
    // changeStatus();
    final ApiResponse<NotificationStatusPayload> res =
        await si.homeService!.updateNotifStatus();

    if (res.success == false) {
      // isLoading = res.hasErrors!;
      message = res.message!;
      showTopSnackBar(
        context!,
        CustomSnackBar.error(
          message: message!,
        ),
      );
    } else {
      message = res.message!;
      isOnClicked = res.data!.data!.deviceTokenStatus!;

      showTopSnackBar(
        context!,
        CustomSnackBar.success(
          message: message!,
        ),
      );
      notifyListeners();
    }
  }
}
