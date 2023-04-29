import 'package:flutter/material.dart';

class RouteOption {
  RouteOption({
    @required this.path,
    // this.builder,
    this.title,
    this.persist = false,
    this.redirectTo,
  });

  String? title;
  String? path;
  String? redirectTo;
  bool persist;
  // Widget Function(BuildContext, AjanuwRouting<Object>) builder;
}
