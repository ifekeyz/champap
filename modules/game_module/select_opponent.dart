import 'dart:ui';

import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectOpponent extends StatelessWidget {
  SelectOpponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 5,
        leading: IconButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: white,
              size: 20.sp,
            )),
        title: Styles.bold('Select Opponent', fontSize: 20.sp, color: white),
        actions: [
          IconButton(
              onPressed: () {},
              icon:
                  Icon(Icons.search_rounded, size: 25.sp, color: primaryColor))
        ],
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: SingleChildScrollView(
              primary: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Styles.regular('Recently Challenged',
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                  VSpace(25.h),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container();
                      // opponent(context);
                    },
                  ),
                  VSpace(40.h),
                  Styles.regular('Online (216)',
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                  VSpace(25.h),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container();
                      // opponent(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
