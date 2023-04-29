import 'dart:async';

import 'package:champ_app/core/service_injector/service_injector.dart';
import 'package:champ_app/core/services/storage_service.dart';
import 'package:champ_app/core/services/store_service.dart';
import 'package:champ_app/shared/models/api_model.dart';
import 'package:champ_app/shared/models/reward_model.dart';
import 'package:champ_app/shared/utils/config.dart';
import 'package:flutter/material.dart';

import '../../shared/models/Notification/notification_status_model.dart';
import '../../shared/models/home_model.dart';

class HomeService {
  HomeService({
    required this.storageService,
    required this.storeService,
  });

  StorageService storageService;
  StoreService storeService;

  Future<ApiResponse<HomePayload>> getHome() async {
    return si.apiService!.getApi<HomePayload>(
      'users/index',
      transform: (dynamic res) {
        debugPrint("auth ress $res");
        return HomePayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<RewardPayload>> addToken() {
    final Map<String?, dynamic?> body = <String?, dynamic?>{
      "video_id": 1,
    };

    print(body.toString());

    AppConfig.profilePictureTimestamp = DateTime.now().millisecondsSinceEpoch;
    return si.apiService!.postApi<RewardPayload>(
      'users/token/video',
      body,
      transform: (dynamic res) {
        debugPrint("auth ress $res");
        return RewardPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<dynamic>> sendDeviceId<T>(String deviceId) {
    final Map<String, String> body = <String, String>{'token': deviceId};

    debugPrint("------------------------ test nofif---" + body.toString());
    return si.apiService!.putApi<dynamic>(
      'update-token',
      body,
      transform: (dynamic res) {
        return res;
      },
    );
  }

  Future<ApiResponse<NotificationStatusPayload>> updateNotifStatus<T>() {
    return si.apiService!.putApi<NotificationStatusPayload>(
      'users/update-notification',
      null,
      transform: (dynamic res) {
        return NotificationStatusPayload.fromJson(res);
      },
    );
  }
}
