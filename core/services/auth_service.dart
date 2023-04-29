import 'dart:async';
import 'dart:convert';

import 'package:champ_app/core/service_injector/service_injector.dart';
import 'package:champ_app/core/services/storage_service.dart';
import 'package:champ_app/core/services/store_service.dart';
import 'package:champ_app/shared/models/api_model.dart';
import 'package:champ_app/shared/utils/config.dart';
import 'package:flutter/material.dart';

import '../../shared/models/change_password_model.dart';
import '../../shared/models/login_model.dart';
import '../../shared/models/login_success_model.dart';
import '../../shared/models/registration_model.dart';

class AuthService {
  AuthService({
    required this.storageService,
    required this.storeService,
  });

  StorageService storageService;
  StoreService storeService;

  // bool _refreshing = false;
  //
  // Future<bool> isLoggedIn() async {
  //   final AuthPayload auth = await getAuthData();
  //   return auth != null && auth.token != null && auth.token!.isNotEmpty;
  // }
  //
  // bool _isExpired(Duration lifespan, int time) {
  //   final DateTime ago = DateTime.now().subtract(lifespan);
  //   final DateTime lastUpdated = DateTime.fromMillisecondsSinceEpoch(time);
  //
  //   return lastUpdated.isBefore(ago);
  // }
  ///
  // Future<AuthPayload> getAuthData() async {
  //   final Completer<AuthPayload> completer = Completer<AuthPayload>();
  //
  //   final String data = si.storageService.getItemSync('auth_data');
  //   if (data.isEmpty) {
  //     completer.complete(null);
  //   } else {
  //     final AuthPayload auth = AuthPayload.fromJson(json.decode(data));
  //     completer.complete(auth);
  //   }
  //
  //   return completer.future;
  // }
  ///

  Future<LoginSuccessPayload> getAuthData() async {
    final Completer<LoginSuccessPayload> completer =
        Completer<LoginSuccessPayload>();

    final String data = storageService.getItemSync('auth_data');

    if (data == null || data.isEmpty) {
      completer.complete(null);
    } else {
      final LoginSuccessPayload auth =
          LoginSuccessPayload.fromJson(json.decode(data));
      completer.complete(auth);
    }

    return completer.future;
  }

  Future<void> signOut() async {
    AppConfig.profilePictureTimestamp = DateTime.now().millisecondsSinceEpoch;

    si.apiService!.postApi<dynamic>(
      'users/logout',
      <String, dynamic>{},
    );

    await Future<void>.delayed(const Duration(milliseconds: 500));
    await si.storageService.removeItem('auth_data');
    storeService.reset();
  }

  Future<ApiResponse<LoginSuccessPayload>> login(LoginModel cred) {
    final Map<String, String?> body = <String, String?>{
      'email': cred.email,
      'password': cred.password,
    };

    AppConfig.profilePictureTimestamp = DateTime.now().millisecondsSinceEpoch;
    return si.apiService!.postApiNoHeader<LoginSuccessPayload>(
      'auth/login',
      body,
      transform: (dynamic res) {
        return LoginSuccessPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<dynamic>> changePass(ChangePasswordModel cred) {
    final Map<String, String?> body = <String, String?>{
      "old_password": cred.oldPassword,
      "new_password": cred.newPassword,
      "new_password_confirmation": cred.confirmPassword,
    };

    return si.apiService!.putApi<dynamic>(
      'users/change-password',
      body,
      transform: (dynamic res) {
        return res;
      },
    );
  }

  Future<ApiResponse<RegistrationPayload>> signUp({required RegModel cred}) {
    final Map<String?, dynamic?> body = <String?, dynamic?>{
      "fullname": cred.fullname,
      "username": cred.username,
      "email": cred.email,
      "password": cred.password,
      "password_confirmation": cred.password_confirmation,
      "referrer_username": cred.referrer_username,
    };

    print(body.toString());

    AppConfig.profilePictureTimestamp = DateTime.now().millisecondsSinceEpoch;
    return si.apiService!.postApiNoHeader<RegistrationPayload>(
      'users',
      body,
      transform: (dynamic res) {
        debugPrint("auth ress $res");
        return RegistrationPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<LoginSuccessPayload>> createPin(
      String pin, String pinConfirmed) {
    final Map<String, String> body = <String, String>{
      "pin": pin,
      "pin_confirmation": pinConfirmed
    };
    print("body" + body.toString());
    return si.apiService!.patchApi<LoginSuccessPayload>(
      'users/pin',
      body,
      transform: (dynamic res) {
        return LoginSuccessPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<LoginSuccessPayload>> fbLogin(String token) {
    final Map<String, String> body = <String, String>{
      'facebookToken': token,
    };
    return si.apiService!.postApiAdd<LoginSuccessPayload>(
      'Authentication/FacebookLogin',
      body,
      transform: (dynamic res) {
        return LoginSuccessPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<LoginSuccessPayload>> googleLogin(String token) {
    final Map<String, String> body = <String, String>{
      'idToken': token,
    };
    return si.apiService!.postApiAdd<LoginSuccessPayload>(
      'Authentication/GoogleLogin',
      body,
      transform: (dynamic res) {
        return LoginSuccessPayload.fromJson(res);
      },
    );
  }

  //
  // Future<ApiResponse<RegisterPayload>> getToken({
  //   String? email,
  // }) {
  //   final Map<String?, String?> body = <String?, String?>{
  //     "email": email!.trim(),
  //   };
  //
  //   AppConfig.profilePictureTimestamp = DateTime.now().millisecondsSinceEpoch;
  //   return si.apiService!.postApiNoHeader<RegisterPayload>(
  //     'auth/login-token',
  //     body,
  //     transform: (dynamic res) {
  //       debugPrint("auth ress $res");
  //       return RegisterPayload.fromJson(res);
  //     },
  //   );
  // }
}
