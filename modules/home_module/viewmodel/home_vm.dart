import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:champ_app/shared/models/home_model.dart';
import 'package:champ_app/shared/models/login_success_model.dart';
import 'package:champ_app/shared/models/reward_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
// import 'package:pusher_client/pusher_client.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:video_player/video_player.dart';

import '../../../core/service_injector/service_injector.dart';
import '../../../core/services/home_service.dart';
import '../../../core/services/local_notifs_service.dart';
import '../../../core/view_model/base_vm.dart';
import '../../../router/transitional_router.dart';
import '../../../shared/models/api_model.dart';
import '../../../shared/models/match_model.dart';
import '../../../shared/utils/adManager.dart';
import '../../game_module/versus.dart';
import '../../settings_module/notifications.dart';
import '../widgets/explore_champ_app.dart';

class HomeViewModel extends BaseViewModel with WidgetsBindingObserver{
  final HomeService? homeService;
  final BuildContext context;

  HomeViewModel({this.homeService, required this.context});

  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  PayloadFromHome homeContent = PayloadFromHome();

  final adManager = AdManager();

  LoginSuccessPayload authPayload = LoginSuccessPayload();
  initializeFirebase() {
    FirebaseMessaging.instance.getToken().then((token) {
      // print("reg roken" + tokenData.sub);
      debugPrint("reg roken1" + token!);

      ///uncomment
      sendDeviceId(context: context, deviceId: token!);
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // newNotifs = true;
        ///add functionality
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => NotificationScreen(
              notifResponse: message.data,
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message != null) {
        // newNotifs = true;
        // getNotifCount();
        // notifyListeners();

        // getDashboard();
        // getContent(
        //     context: context, pageIndex: 1.toString(), jobRange: 2.toString());
        // print("notification!" + message.data.toString());
      }
      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('A new onMessageOpenedApp event was published!');
      if (message != null) {
        // newNotifs = true;
        ///add functionality
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => NotificationScreen(
              notifResponse: message.data,
            ),
          ),
        );
      }
    });
  }

  AssetsAudioPlayer? _assetsAudioPlayer;

  @override
  FutureOr<void> init() {
    // TODO: implement init
    //
    _assetsAudioPlayer = AssetsAudioPlayer();

    _assetsAudioPlayer!.open(Audio("assets/audios/beat.mp3"),
        showNotification: true, loopMode: LoopMode.single);
    _assetsAudioPlayer!.playOrPause();
    WidgetsBinding.instance.addObserver(this);
    adManager.addAds(true, true, true);
    adManager.showRewardedAd();
    initializeFirebase();
    getDashboard();
    // listenChatChannel();

    /// dont delete
    // _videoPlayerController = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    // )..initialize().then((_) {
    //     _videoPlayerController.play();
    //   });
    //
    // // Initialize the controller and store the Future for later use.
    // _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    //
    // //       // Use the controller to loop the video.
    // // _videoPlayerController.setLooping(true);
    //
    // // invoking the bottom sheet on screen launch
    // Future.delayed(Duration.zero, () => _showBottomSheet(context));
    //
    // throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    // _videoPlayerController.dispose();
    // leaveChatChannel();
    _assetsAudioPlayer = null;

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _assetsAudioPlayer?.pause();
    }
    else{
      _assetsAudioPlayer?.play();
    }
  }

  String? message;

  Future<bool?> getDashboard() async {
    // changeStatus();
    context.loaderOverlay.show();
    final ApiResponse<HomePayload> res = await si.homeService!.getHome();
    // debugPrint("res first ${res.message}");

    print("yess----: " + res.data.toString());
    print("yess----1: " + res.message.toString());
    print("yess----2: " + res.success.toString());

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
      homeContent = res.data!.data!;
      // Navigator.push(
      //   context,
      //   MainRouter.generateRoute(
      //     const RouteSettings(name: RoutePaths.login),
      //   ),
      // );
      notifyListeners();
      return res.success;
    }
  }

  Future<bool?> addToken() async {
    // changeStatus();
    context.loaderOverlay.show();
    final ApiResponse<RewardPayload> res = await si.homeService!.addToken();
    // debugPrint("res first ${res.message}");

    print("yess----: " + res.data.toString());
    print("yess----1: " + res.message.toString());
    print("yess----2: " + res.success.toString());

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
      message = res.data!.data!.token.toString();

      showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: message!,
          ));
      isLoading = false;

      // Navigator.push(
      //   context,
      //   MainRouter.generateRoute(
      //     const RouteSettings(name: RoutePaths.login),
      //   ),
      // );
      notifyListeners();
      return res.success;
    }
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      isDismissible: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return exploreChampApp(
          context: context,
          videoPlayerController: _videoPlayerController,
          initializeVideoPlayerFuture: _initializeVideoPlayerFuture,
          onPressed: () {
            if (_videoPlayerController.value.isPlaying) {
              _videoPlayerController.pause();
              _videoPlayerController.dispose();
            }

            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> sendDeviceId(
      {required String deviceId, BuildContext? context}) async {
    // changeStatus();
    final ApiResponse<dynamic> res =
        await si.homeService!.sendDeviceId(deviceId);

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
      showTopSnackBar(
        context!,
        CustomSnackBar.success(
          message: message!,
        ),
      );
    }
  }

  Future<bool?> startMatch(BuildContext context, stakeAmount, gameType) async {
    context.loaderOverlay.show();

    final ApiResponse<MatchPayload> res = await si.gameService!
        .startMatch(stakeAmount: stakeAmount, gameType: gameType ?? "coin");

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

      Navigator.push(
        context,
        TransitionalRoute(
          Versus(matchData: res.data!.data!, amount: stakeAmount),
        ),
      );

      notifyListeners();
      return res.success;
    }
  }
}
