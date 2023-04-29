// ignore_for_file: unused_field, deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:champ_app/core/service_injector/service_injector.dart';
import 'package:champ_app/core/services/utilities_service.dart';
import 'package:champ_app/shared/models/layout_model.dart';
import 'package:champ_app/shared/models/theme_model.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/dims.dart';

class RouterOutlet extends StatefulWidget {
  const RouterOutlet({
    @required this.child,
  });

  final Widget? child;

  @override
  _RouterOutletState createState() {
    return _RouterOutletState();
  }
}

class _RouterOutletState extends State<RouterOutlet> {
  late StreamSubscription<ThemeModel> _color$;
  late StreamSubscription<LayoutConfig> _layout$;
  bool _restarting = false;
  LayoutConfig _layout = LayoutConfig();
  late StreamSubscription<bool> _bottomInset$;
  bool _bottomInset = true;

  @override
  void initState() {
    super.initState();

    _layout$ = si.layoutService.layout$.listen((LayoutConfig cfg) {
      setState(() {
        _layout = cfg ?? LayoutConfig();
      });
    });

    _bottomInset$ = si.layoutService.bottomInset$.listen((bool value) {
      setState(() {
        _bottomInset = value;
      });
    });

    _color$ = si.colorService!.color$.listen((ThemeModel value) {
      setState(() {
        _restarting = true;
      });

      Future<int>.delayed(const Duration(milliseconds: 700)).then((int value) {
        setState(() {
          _restarting = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dims.deviceSize!.height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: white,
      ),
      child: _restarting
          ? Container()
          : WillPopScope(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: _bottomInset,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: AppBar(
                    backgroundColor: Colors.black,
                    brightness: Brightness.dark,
                  ),
                ),
                body: GestureDetector(
                  onTap: () {
                    UtilitiesService.removeFocus(context);
                  },
                  child: SafeArea(
                    child: Stack(
                      children: const <Widget>[
                        // if (_layout.type == AppLayoutTypes.DASHBOARD)
                        //   DashboardLayout(widget.child)
                        // else
                        //   widget.child,
                        // ModalShield(),
                      ],
                    ),
                  ),
                ),
              ),
              onWillPop: () {
                final Completer<bool> completer = Completer<bool>();
                return completer.future;
              },
            ),
    );
  }

  @override
  void dispose() {
    _color$.cancel();
    _layout$.cancel();
    _bottomInset$.cancel();

    super.dispose();
  }
}
