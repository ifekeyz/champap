import 'dart:ui' as ui;

import 'package:champ_app/modules/settings_module/viewmodel/settings_vm.dart';
import 'package:champ_app/modules/settings_module/widgets/bordered-text.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/service_injector/service_injector.dart';
import '../../router/main_router.dart';
import '../../router/route_paths.dart';
import '../../shared/widgets/base_view.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late ui.Image customImage;
  double _soundValue = 60.0;
  double _vibrationValue = 40.0;
  double _musicValue = 90.0;

  Future<ui.Image> loadImage(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  void initState() {
    loadImage(diceImg).then((image) {
      setState(() {
        customImage = image;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsViewModel>(
      vmBuilder: (context) =>
          SettingsViewModel(homeService: si.homeService, context: context),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, SettingsViewModel viewModel) {
    return Scaffold(
      backgroundColor: black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: white,
              size: 20.sp,
            )),
        title: Styles.bold('SETTINGS', fontSize: 20.sp, color: white),
      ),
      body: Container(
        width: deviceWidth(context),
        height: deviceHeight(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  bckgroundImg,
                ),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      borderedText(text: 'SOUND'),
                      VSpace(25.h),
                      Container(
                        width: 262.44.w,
                        height: 25.71.h,
                        alignment: Alignment.topCenter,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              sliderBg,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: SliderTheme(
                          data: SliderThemeData(
                            activeTrackColor: primaryColor,
                            activeTickMarkColor: purple,
                            inactiveTrackColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            thumbShape: SliderThumbImage(customImage),
                            // tickMarkShape: const LineSliderTickMarkShape(),
                          ),
                          child: Slider(
                            divisions: 10,
                            min: 0.0,
                            max: 100.0,
                            onChanged: (value) {
                              setState(() {
                                _soundValue = value;
                                value++;
                              });
                            },
                            value: _soundValue,
                          ),
                        ),
                      )
                    ],
                  ),

                  VSpace(30.h),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      borderedText(text: 'VIBRATION'),
                      VSpace(25.h),
                      Container(
                        width: 262.44.w,
                        height: 25.71.h,
                        alignment: Alignment.topCenter,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              sliderBg,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: SliderTheme(
                          data: SliderThemeData(
                            activeTrackColor: primaryColor,
                            activeTickMarkColor: purple,
                            inactiveTrackColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            thumbShape: SliderThumbImage(customImage),
                            // tickMarkShape: const LineSliderTickMarkShape(),
                          ),
                          child: Slider(
                            divisions: 10,
                            min: 0.0,
                            max: 100.0,
                            onChanged: (value) {
                              setState(() {
                                _vibrationValue = value;
                                value++;
                              });
                            },
                            value: _vibrationValue,
                          ),
                        ),
                      )
                    ],
                  ),
                  // VSpace(50.h),
                  VSpace(30.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      borderedText(text: 'MUSIC'),
                      VSpace(25.h),
                      Container(
                        width: 262.44.w,
                        height: 25.71.h,
                        alignment: Alignment.topCenter,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              sliderBg,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: SliderTheme(
                          data: SliderThemeData(
                            activeTrackColor: primaryColor,
                            activeTickMarkColor: purple,
                            inactiveTrackColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            thumbShape: SliderThumbImage(customImage),
                            // tickMarkShape: const LineSliderTickMarkShape(),
                          ),
                          child: Slider(
                            divisions: 10,
                            min: 0.0,
                            max: 100.0,
                            onChanged: (value) {
                              setState(() {
                                _musicValue = value;
                                value++;
                              });
                            },
                            value: _musicValue,
                          ),
                        ),
                      )
                    ],
                  ),
                  VSpace(30.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MainRouter.generateRoute(
                                const RouteSettings(
                                    name: RoutePaths.resetPassword),
                              ),
                            );
                          },
                          child: borderedText(text: 'NOTIFICATIONS')),
                      VSpace(25.h),
                      Container(
                        width: 119.w,
                        height: 47.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 3.h),
                        alignment: Alignment.topCenter,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              counterBg,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                          alignment: Alignment.center,
                          decoration:
                              const BoxDecoration(color: Color(0xff9C1F48)),
                          child: Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  viewModel.offClicked = true;
                                  viewModel.onClicked = false;
                                  viewModel.notifyListeners();
                                  // });
                                },
                                child: Container(
                                  color: !viewModel.isOnClicked
                                      ? primaryColor
                                      : Colors.transparent,
                                  alignment: Alignment.center,
                                  child: Styles.regular('OFF',
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800),
                                ),
                              )),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  viewModel.onClicked = true;
                                  viewModel.offClicked = false;
                                  viewModel.updateNotifStatus(context: context);
                                  viewModel.notifyListeners();
                                  // });
                                },
                                child: Container(
                                  color: viewModel.isOnClicked
                                      ? primaryColor
                                      : Colors.transparent,
                                  alignment: Alignment.center,
                                  child: Styles.regular('ON',
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      VSpace(30.h),
                      borderedText(text: 'PASSWORD'),
                      // VSpace(25.h),
                      VSpace(25.h),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MainRouter.generateRoute(
                              const RouteSettings(
                                  name: RoutePaths.resetPassword),
                            ),
                          );
                        },
                        child: Container(
                          width: 175.w,
                          height: 40.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.h),
                          alignment: Alignment.topCenter,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                counterBg,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                            ),
                            alignment: Alignment.center,
                            decoration:
                                const BoxDecoration(color: Color(0xff9C1F48)),
                            child: Styles.regular('RESET PASSWORD',
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                  VSpace(30.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: borderedText(text: 'SIGN OUT'),
                              onTap: (){
                                viewModel.signOut(context);
                              },
                            ),

                            HSpace(30.w),
                            borderedText(text: 'HELP'),
                          ]),
                      VSpace(25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              viewModel.signOut(context);
                            },
                            child: Container(
                              width: 47.w,
                              height: 47.h,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    powerBtnBg,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Image.asset(powerBtn,
                                  width: 36.w, height: 36.h),
                            ),
                          ),
                          HSpace(30.w),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MainRouter.generateRoute(
                                  const RouteSettings(
                                      name: RoutePaths.helpScreen),
                                ),
                              );
                            },
                            child: Container(
                              width: 47.w,
                              height: 47.h,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    powerBtnBg,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Image.asset(questionMark,
                                  width: 36.w, height: 36.h),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class SliderThumbImage extends SliderComponentShape {
  final ui.Image image;

  SliderThumbImage(this.image);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(20, 20);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final imageWidth = image.width;
    final imageHeight = image.height;

    Offset imageOffset = Offset(
      center.dx - (imageWidth / 2.2),
      center.dy - (imageHeight / 2),
    );
    Paint paint = Paint()..filterQuality = FilterQuality.high;

    if (image != null) {
      canvas.drawImage(image, imageOffset, paint);
    }
  }
}
