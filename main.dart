import 'package:champ_app/router/main_router.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import 'core/locator/locator.dart';
import 'core/service_injector/service_injector.dart';
import 'core/services/local_notifs_service.dart';
import 'firebase_options.dart';
import 'modules/splash.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("notiff backroung1 ===>" + message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  await Firebase.initializeApp(
    name: "Champ-play",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  MobileAds.instance.initialize();
  runApp(RouteObserverProvider(
    child: const MyApp(
      appKey: ValueKey<String>('root'),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({this.appKey}) : super(key: appKey);
  final ValueKey<String>? appKey;

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  // bool _splashDone = false;
  // AssetsAudioPlayer? _assetsAudioPlayer;
  @override
  void initState() {
    _init();

    LocalNotificationService.initialize(context);

    FirebaseMessaging.instance.requestPermission().then((value) {
      print(value);
    });
    FirebaseMessaging.instance.getToken().then((token) {
      print(token);
    });
    FirebaseMessaging.instance.getAPNSToken().then((APNStoken) {
      print(APNStoken);
    });
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
      ),
    );

    // // The preferred screen orientation
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]).then((_) {});
    super.initState();

    // _assetsAudioPlayer = AssetsAudioPlayer();
    //
    // _assetsAudioPlayer!.open(
    //   Audio("assets/audios/beat.mp3"),
    //   showNotification: true,
    // );
    // _assetsAudioPlayer!.playOrPause();
  }

  Future<void> _init() async {
    await si.init();

    setState(() {
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)

    // return ScreenUtilInit(
    //   designSize: Size(logicalWidth(), logicalHeight()),
    //   builder: () => MultiProvider(
    //     providers: allProviders,
    //     child: MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         theme: ThemeData(
    //           primarySwatch: Colors.green,
    //           textTheme: TextTheme(
    //               //To support the following, you need to use the first initialization method
    //               bodyText1: GoogleFonts.montserrat(),
    //               button: TextStyle(fontSize: 45.sp)),
    //         ),
    //         onGenerateRoute: MainRouter.generateRoute,
    //         // home: HelpScreen()),
    //         home: const Splash()),
    //   ),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(
            //To support the following, you need to use the first initialization method
            bodyText1: GoogleFonts.montserrat(),
            button: TextStyle(fontSize: 45.sp)),
      ),
      onGenerateRoute: MainRouter.generateRoute,
            // home: HelpScreen()),
            home: const Splash()
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _assetsAudioPlayer = null;
  }
}
