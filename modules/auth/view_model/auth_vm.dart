import 'dart:async';
import 'dart:convert';

import 'package:champ_app/modules/app_module/layout/bottom_nav.dart';
import 'package:champ_app/modules/auth/login_first_user.dart';
import 'package:champ_app/shared/models/registration_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/service_injector/service_injector.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/view_model/base_vm.dart';
import '../../../router/main_router.dart';
import '../../../router/route_paths.dart';
import '../../../shared/models/api_model.dart';
import '../../../shared/models/change_password_model.dart';
import '../../../shared/models/login_model.dart';
import '../../../shared/models/login_success_model.dart';
import '../../home_module/widgets/constants.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService? authService;

  AuthViewModel({this.authService});

  bool isValidEmail = false;
  bool saveCredentials = false;
  String? message;
  String? _message;
  String email = "";
  String password = "";
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController emailCrt = TextEditingController();
  TextEditingController refEmailCrt = TextEditingController();
  TextEditingController passwordCrt = TextEditingController();
  TextEditingController confirmPasswordCrt = TextEditingController();
  TextEditingController newPasswordCrt = TextEditingController();
  TextEditingController usernameCrt = TextEditingController();
  TextEditingController fullNameCrt = TextEditingController();

  @override
  FutureOr<void> init() {
    isLoading = false;
    generateEmail();
  }

  validateEmail(value) {
    isValidEmail = value;
    notifyListeners();
  }

  generateEmail() {
    email = si.storageService.getItemSync('login_email');
    password = si.storageService.getItemSync('login_password');
    if (email.length > 3) {
      emailCrt.text = email;
      passwordCrt.text = password;
    }
    notifyListeners();
  }

  toggleSaveCredentials(value) {
    saveCredentials = value;
    notifyListeners();
  }

  Future<bool?> login(
      {required LoginModel cred, required BuildContext context}) async {
    // changeStatus();
    // context.loaderOverlay.show();
    final ApiResponse<LoginSuccessPayload> res =
        await si.authService!.login(cred);
    // print(json.encode(res.data.toJson()));
    if (!res.success) {
      isLoading = res.success;
      message = res.message;
      context.loaderOverlay.hide();
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: res.message!,
        ),
      );
      // Navigator.pushNamed(context, RoutePaths.bottomNav);
    } else {
      message = res.message;

      debugPrint(res.data!.token!.toString());

      /// cache user data locally here
      si.storageService.setItem('auth_data', json.encode(res.data!.toJson()));
      if (saveCredentials) {
        si.storageService.setItem('login_email', cred.email!);
        si.storageService.setItem('login_password', cred.password!);
      } // si.storageService.setItem('jwt_data', json.encode(res.data!.token));
      si.storageService.setItem('token', json.encode(res.data!.token));

      context.loaderOverlay.hide();
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: message!,
        ),
      );
      if (res.data!.first_time_login!) {
        Navigator.pushReplacementNamed(context, RoutePaths.createPIN);
      } else {
        Navigator.pushReplacementNamed(context, RoutePaths.bottomNav);
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("LOGGED_IN", true);
      }
    }
    // changeStatus();
    notifyListeners();
  }

  Future<bool?> changePassword(
      {required ChangePasswordModel cred,
      required BuildContext context}) async {
    // changeStatus();
    // context.loaderOverlay.show();
    final ApiResponse<dynamic> res = await si.authService!.changePass(cred);
    // print(json.encode(res.data.toJson()));
    if (!res.success) {
      isLoading = res.success;
      message = res.message;
      context.loaderOverlay.hide();
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: res.message!,
        ),
      );
      // Navigator.pushNamed(context, RoutePaths.bottomNav);
    } else {
      message = res.message;

      // debugPrint(res.data!.token!.toString());

      /// cache user data locally here
      // si.storageService.setItem('auth_data', json.encode(res.data!.toJson()));
      // si.storageService.setItem('login_email', cred.email!);
      // // si.storageService.setItem('jwt_data', json.encode(res.data!.token));
      // si.storageService.setItem('token', json.encode(res.data!.token));

      context.loaderOverlay.hide();
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: message!,
        ),
      );
      Navigator.pop(context);
    }
    // changeStatus();
    notifyListeners();
  }

  Future<bool?> register(BuildContext context, {required RegModel cred}) async {
    // changeStatus();
    context.loaderOverlay.show();
    final ApiResponse<RegistrationPayload> res =
        await si.authService!.signUp(cred: cred);
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
      Navigator.push(
        context,
        MainRouter.generateRoute(
          const RouteSettings(name: RoutePaths.createPIN),
        ),
      );
      notifyListeners();
      return res.success;
    }
  }

  Future<bool?> createPin(BuildContext context,
      {required pin, required pinConfirmed}) async {
    // changeStatus();
    // context.loaderOverlay.show();
    final ApiResponse<LoginSuccessPayload> res =
        await si.authService!.createPin(pin, pinConfirmed);
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
      Navigator.push(
        context,
        MainRouter.generateRoute(
          const RouteSettings(name: RoutePaths.welcome),
        ),
      );
      notifyListeners();
      return res.success;
    }
  }

  // initiateFacebookLogin(context) async {
  //   context.loaderOverlay.show();
  //   final facebookLogin = FacebookLogin();
  //   print(facebookLogin.toString());
  //   final facebookLoginResult = await facebookLogin.logIn(permissions: [
  //     FacebookPermission.publicProfile,
  //     FacebookPermission.email,
  //   ]);
  //
  //   switch (facebookLoginResult.status) {
  //     case FacebookLoginStatus.error:
  //       // onLoginStatusChanged(false);
  //       _message = facebookLoginResult.error!.developerMessage;
  //       print('error...........' + _message!);
  //       break;
  //     case FacebookLoginStatus.cancel:
  //       // onLoginStatusChanged(false);
  //       _message = 'Login cancelled by the user.';
  //       print('cancelled...........' + _message!);
  //       break;
  //     case FacebookLoginStatus.success:
  //       final accessToken = facebookLoginResult.accessToken;
  //       print('access token: ${accessToken!.token}');
  //
  //       _message = '';
  //
  //       final ApiResponse<LoginSuccessPayload> res =
  //           await si.authService!.fbLogin(accessToken.token);
  //
  //       if (!res.success) {
  //         isLoading = res.success;
  //         message = res.message;
  //         context.loaderOverlay.hide();
  //         showTopSnackBar(
  //           context,
  //           CustomSnackBar.error(message: res.message!),
  //         );
  //         // Navigator.pushNamed(context, RoutePaths.bottomNav);
  //       } else {
  //         message = res.message;
  //
  //         /// cache user data locally here
  //         si.storageService
  //             .setItem('auth_data', json.encode(res.data!.toJson()));
  //
  //         Map<String, dynamic> decodedToken =
  //             JwtDecoder.decode(res.data!.token!);
  //         bool tokenTime = JwtDecoder.isExpired(res.data!.token!);
  //         si.storageService.setItem('token_data', json.encode(decodedToken));
  //         context.loaderOverlay.hide();
  //         showTopSnackBar(
  //           context,
  //           CustomSnackBar.success(
  //             message: message!,
  //           ),
  //         );
  //         // Navigator.pushReplacementNamed(context, RoutePaths.onboarding);
  //       }
  //       // changeStatus();
  //       notifyListeners();
  //   }
  // }

  initiateFacebookLogin(context) async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email'],
    );

    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      FacebookAuth.instance.getUserData().then((userData) async {
        userObj = userData;
        Navigator.pushReplacementNamed(context, RoutePaths.bottomNav);
      });
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(message: result.message ?? "An error has occur"),
      );
      print(result.status);
      print(result.message);
    }

    // FacebookAuth.instance
    //     .login(permissions: ["public_profile", "email"]).then((value) {
    //   FacebookAuth.instance.getUserData().then((userData) async {
    //     userObj = userData;
    //     Navigator.pushReplacementNamed(context, RoutePaths.bottomNav);
    //   });
    // });
  }

  initiateGoogleLogin(BuildContext context) async {
    context.loaderOverlay.show();
    FirebaseAuth.instance.signOut();
    final GoogleSignInAccount? googleUserSignOut =
        await GoogleSignIn(scopes: ['email']).signOut();
    print('google user1');
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ['email']).signIn();
    // try {
    //   final GoogleSignInAccount? googleUser =
    //       await GoogleSignIn(scopes: ['email']).signIn();
    // } catch (error) {
    //   print(error);
    // }
    debugPrint('google user: $googleUser');
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    debugPrint('google auth: $googleAuth');
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    debugPrint('access token: $accessToken');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(idToken!);
    debugPrint('id token: $idToken');

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    _message = '';
    await FirebaseAuth.instance.signInWithCredential(credential);

    // final ApiResponse<LoginSuccessPayload> res =
    //     await si.authService!.googleLogin(idToken);

    if (googleAuth == null) {
      // isLoading = res.success;
      // message = res.message;
      context.loaderOverlay.hide();
      showTopSnackBar(
        context,
        const CustomSnackBar.error(message: "An error has occur"),
      );
    } else {
      message = "success";

      // /// cache user data locally here
      // si.storageService.setItem('auth_data', json.encode(res.data!.toJson()));
      //
      // Map<String, dynamic> decodedToken = JwtDecoder.decode(res.data!.token!);
      // bool tokenTime = JwtDecoder.isExpired(res.data!.token!);
      // si.storageService.setItem('token_data', json.encode(decodedToken));
      context.loaderOverlay.hide();
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: message!,
        ),
      );
      Navigator.pushReplacementNamed(context, RoutePaths.bottomNav);
    }
    notifyListeners();
    // changeStatus();

    // return
  }

  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomNav();
          } else {
            return const LoginFirstUser();
          }
        });
  }
}
