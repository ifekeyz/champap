

import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/utils/color.dart';
import '../../shared/utils/images.dart';
import '../../shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/custom_button.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 24.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        VSpace(120.h),
                        Image.asset(
                          c2,
                          height: 76.h,
                          width: 80.57.w,
                        ),

                        VSpace(40.h),
                        Text('WELCOME, Philips' , style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold,
                            fontSize: 20, fontFamily: 'Inter') ),

                        VSpace(9.h),
                        Text('Welcome to our mobile game where we are thrilled to have you onboard.'
                            'You will be taken through the next few screen which will give you all the information'
                            'you need to play the game. This screens will cover the basics of how to move and how'
                            ' to interract with the objects and how to level up. These basics will be followed by some tips and tricks, that will '
                            'help you progress through the entire game. If you have any question or need question with anything, '
                            'Please do not hesitate to reach out to our custumer team, Have Fun!' , textAlign: TextAlign.justify, style: TextStyle(height: 1.7 , color: Colors.white, fontWeight:FontWeight.w100,
                            fontSize: 14, fontFamily: 'Inter-Light') ),

                        VSpace(100.h),
                        CustomButton(
                            title: "Let's go",
                            isActive: true,
                            onPress: () async {

                              }
                            ),

                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }




}
