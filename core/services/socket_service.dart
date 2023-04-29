// import 'package:flutter/cupertino.dart';
// import 'package:laravel_echo/laravel_echo.dart';
// import 'package:pusher_client/pusher_client.dart';
//
// class LaravelEcho {
//   static LaravelEcho? _singleton;
//   static late Echo _echo;
//   final String token;
//   LaravelEcho._({
//     required this.token,
//   }) {
//     _echo = createLaravelEcho(token);
//     debugPrint("xxxxx------" + _echo.toString());
//   }
//   factory LaravelEcho.init({
//     required String token,
//   }) {
//     _singleton = LaravelEcho._(token: token);
//     return _singleton!;
//   }
//   static Echo get instance => _echo;
//   static String get socketId => _echo.socketId() ?? "11111.11111111";
// }
//
// class PusherConfig {
//   static const hostAuthEndPoint =
//       "https://146.190.217.81/api/v1/broadcasting/auth";
//   static const PUSHER_APP_ID = "1523753";
//   // static const PUSHER_APP_ID = "champsplay";
//   static const PUSHER_APP_KEY = "c94a7f88fd42e6c99285";
//   // static const PUSHER_APP_KEY = "champsplay_key";
//   static const PUSHER_APP_SECRET = "f063a88f0472e0871be8";
//   // static const PUSHER_APP_SECRET = "champsplay_secret";
//   static const PUSHER_HOST = "https://146.190.217.81";
//   // static const PUSHER_HOST = "146.190.217.81";
//   static const PUSHER_PORT = 6001;
//   static const PUSHER_SCHEME = "https";
//   static const PUSHER_APP_CLUSTER = "mt1";
//   static const PUSHER_ENCRYPTED = true;
//   static const PUSHER_TLS = true;
// }
//
// PusherClient createPusherClient({required String token}) {
//   PusherOptions options = PusherOptions(
//     wsPort: PusherConfig.PUSHER_PORT,
//     wssPort: PusherConfig.PUSHER_PORT,
//     encrypted: PusherConfig.PUSHER_ENCRYPTED,
//     host: PusherConfig.PUSHER_HOST,
//     cluster: PusherConfig.PUSHER_APP_CLUSTER,
//     auth: PusherAuth(PusherConfig.hostAuthEndPoint, headers: {
//       'Authorization': "Bearer $token",
//       'Accept': "application/json",
//       'Content-Type': "application/json"
//     }),
//   );
//
//   PusherClient pusherClient = PusherClient(
//     PusherConfig.PUSHER_APP_KEY,
//     options,
//     autoConnect: false,
//     enableLogging: true,
//   );
//
//   // Channel channel = pusherClient.subscribe("public.playground.1");
//
//   // // channel.unbind(".playground");
//   // channel.bind(".playground", (event) {
//   //   debugPrint("here582-----");
//   // });
//   // pusherClient.onConnectionStateChange((state) {
//   //   print(
//   //       "previousState: ${state?.previousState}, currentState: ${state?.currentState}");
//   // });
//   //
//   // pusherClient.onConnectionError((error) {
//   //   print("errorFortune: ${error?.message}");
//   // });
//
//   // channel.bind('pusher:subscription_error', (data) {
//   //   debugPrint("data----${data!.eventName!}");
//   // });
//
//   // pusherClient.connect();
//   return pusherClient;
// }
//
// Echo createLaravelEcho(tokens) {
//   return Echo(
//       client: createPusherClient(token: tokens),
//       broadcaster: EchoBroadcasterType.Pusher);
// }
