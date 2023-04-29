import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/utils/images.dart';
import '../../shared/utils/utils.dart';

class Games extends StatelessWidget {
  Games({Key? key}) : super(key: key);

  List games = [
    {
      'name': 'Ludo',
      'image': chessBoard,
    },
    {
      'name': 'Snooker',
      'image': pool,
    },
    {
      'name': 'Dice',
      'image': dice,
    },
    {
      'name': 'Chess',
      'image': chess,
    },
    {
      'name': 'Whot',
      'image': whot,
    },
    {
      'name': 'Ayo Olopon',
      'image': ayo,
    },
  ];

  @override
  Widget build(BuildContext context) {
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
          title: Styles.bold('GAMES', fontSize: 20.sp, color: white),
        ),
        body: Container(
          width: deviceWidth(context),
          height: deviceHeight(context),
          padding: EdgeInsets.only(top: 20.h),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    bckgroundImg,
                  ),
                  fit: BoxFit.cover)),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              // implement GridView.builder
              child: SizedBox(
                height: 140.h,
                child: GridView.builder(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0.w,
                      mainAxisSpacing: 20.h,
                    ),
                    itemCount: games.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return game(
                          context, games[index]['image'], games[index]['name']);
                    }),
              ),
            ),
          ),
        ));
  }
}
