import 'dart:async';

import 'package:champ_app/modules/auth/view_model/auth_vm.dart';
import 'package:champ_app/router/main_router.dart';
import 'package:champ_app/router/route_paths.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/service_injector/service_injector.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  getPermissions() async {
    // var status = await Permission.storage.status;
    // if (!status.isGranted) {
    //   // We didn't ask for permission yet or the permission has been denied before but not permanently.
    //   PermissionStatus s = await Permission.storage.request();
    //   if (s.isGranted) {
    //     print("dls");
    //     Timer(
    //         Duration(seconds: 3),
    //         () => Navigator.push(
    //               context,
    //               MainRouter.generateRoute(
    //                 RouteSettings(name: RoutePaths.loginFirstUser),
    //               ),
    //             ));
    //   } else {
    //     //close app
    //     print("close app here");
    //   }
    // }

    // Timer(Duration(seconds: 5),
    //     () => AuthViewModel(authService: si.authService).handleAuthState());
    final prefs = await SharedPreferences.getInstance();
      bool loggedIn = prefs.getBool("LOGGED_IN") ?? false;
      if (loggedIn) {
        Timer(
            Duration(seconds: 5),
                () => Navigator.push(
              context,
              MainRouter.generateRoute(
                RouteSettings(name: RoutePaths.bottomNav),
              ),
            ));

      } else {
        Timer(
            Duration(seconds: 5),
                () => Navigator.push(
              context,
              MainRouter.generateRoute(
                RouteSettings(name: RoutePaths.login),
              ),
            ));
      }


  }

  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the 360*690(dp)
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: deviceWidth(context), maxHeight: deviceHeight(context)),
        designSize: Size(deviceWidth(context), deviceHeight(context)),
        orientation: Orientation.portrait);
    return Scaffold(
      body: Container(
        width: deviceWidth(context),
        height: deviceHeight(context),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(bckgroundImg),
          ),
        ),
        child: Image.asset(logoImg),
      ),
    );
  }
}
