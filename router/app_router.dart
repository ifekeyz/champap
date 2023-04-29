// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:champ_app/core/gaurds/app_guard.dart';
import 'package:champ_app/modules/app_module/app_module.dart';
import 'package:champ_app/modules/auth/auth_routes.dart';
import 'package:champ_app/router/route_animation.dart';
import 'package:champ_app/router/route_composer.dart';
import 'package:champ_app/shared/models/route_model.dart';

List<RouteOption> routeOpts = <RouteOption>[
  // RouteOption(
  //   builder: null,
  //   path: '',
  //   title: 'SBSC',
  //   redirectTo: AppGuard.route,
  // ),
  // RouteOption(
  //   path: AppGuard.route.substring(1),
  //   builder: (BuildContext context, AjanuwRouting<Object> r) {
  //     return AppGuard();
  //   },
  // ),
  RouteOption(
    path: '**',
    // @TODO: handle some logic here to ensure navigation to destination and for deep-linking
    redirectTo: AppGuard.route,
    //   builder: (BuildContext ctx, AjanuwRouting<Object> r) {
    //     print(r.settings.name);

    //     return Container();
    //   },
  ),

  // Module routes
  ...RouteComposer.compose(
    'auth',
    AuthModule.routes,
  ),

  ...RouteComposer.compose(
    'app',
    AppModule.routes,
  ),
];

class AppRouter {
  AppRouter();

  // static AjanuwRouter router = AjanuwRouter();
  // static final List<AjanuwRoute<Object>> routes =
  //     routeOpts.map((RouteOption e) {
  //   return AjanuwRoute<Object>(
  //     title: e.title,
  //     path: e.path,
  //     redirectTo: e.redirectTo,
  //     builder: e.builder,
  //     maintainState: e.persist ?? false,
  //     transitionDuration: transitionDuration(),
  //     transitionsBuilder: transitionsBuilder,
  //   );
  // }).toList();
}
