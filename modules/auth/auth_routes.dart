// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:champ_app/shared/models/route_model.dart';
import 'login_first_user.dart';

class AuthModule {
  AuthModule();

  static final List<RouteOption> routes = <RouteOption>[
    RouteOption(
      path: 'login',
      // builder: (BuildContext context, AjanuwRouting<Object> r) {
      //   return LoginFirstUser();
      // },
    ),
  ];
}
