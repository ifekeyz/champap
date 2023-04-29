import 'dart:ui';

import 'package:champ_app/modules/game_module/view_model/unity_view.dart';
import 'package:champ_app/modules/game_module/widgets/tournament_journey.dart';
import 'package:champ_app/modules/leader_board_module/widgets/ranking_tile.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/bottom_tip.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:champ_app/shared/widgets/token_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tournament extends StatelessWidget {
  Tournament({Key? key}) : super(key: key);
  final firstPlayer =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60';
  final String secondPlayer =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60";

  List leaderboard = [
    {
      'image':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      'user-name': 'Phillp',
      'position': 23,
      'is_inclined': false,
      'is_current_user': false
    },
    {
      'image':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      'user-name': 'Phillp',
      'position': 3,
      'is_inclined': true,
      'is_current_user': false
    },
    {
      'image':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      'user-name': 'Phillp',
      'position': 15,
      'is_inclined': true,
      'is_current_user': false
    },
    {
      'image':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      'user-name': 'Phillp',
      'position': 13,
      'is_inclined': true,
      'is_current_user': false
    },
    {
      'image':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      'user-name': 'Phillp',
      'position': 13,
      'is_inclined': false,
      'is_current_user': false
    }
  ];

  // journey(
  //                                         'final',
  //                                         firstPlayer,
  //                                         secondPlayer,
  //                                         'Richard',
  //                                         'John',
  //                                         false),

  List tournamentJourney = [
    {
      'stage': 'final',
      'is_waiting': true,
      'player1-image':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      'player2-image':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      'player1': 'Richard',
      'player2': 'John',
    },
    {
      'stage': 'Group 2',
      'is_waiting': false,
      'player1-image':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      'player2-image':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      'player1': 'Richard',
      'player2': 'John',
    },
    {
      'stage': 'Group 1',
      'is_waiting': false,
      'player1-image':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      'player2-image':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      'player1': 'Richard',
      'player2': 'John',
    }
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: black,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UnityScreen()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.rocket_launch_rounded),

      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: white,
              size: 20.sp,
            )),

        title: Styles.bold('TOURNAMENT', fontSize: 20.sp, color: white),
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    trophy,
                    width: 130.w,
                    height: 179.h,
                  ),
                  VSpace(27.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150.w,
                        height: 95.h,
                        decoration: BoxDecoration(
                          color: black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            VSpace(5.h),
                            Image.asset(
                              userColored,
                              width: 32.w,
                              height: 32.h,
                            ),
                            Styles.regular('Participants',
                                color: champTextGrey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                            Styles.regular('4',
                                color: white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                            VSpace(5.h),
                          ],
                        ),
                      ),
                      Container(
                        width: 167.w,
                        height: 95.h,
                        decoration: BoxDecoration(
                          color: black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            VSpace(5.h),
                            Image.asset(
                              stackedIcon,
                              width: 34.w,
                              height: 34.h,
                            ),
                            Styles.regular('Total Stake',
                                color: champTextGrey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                                children: <TextSpan>[
                                  const TextSpan(text: '40,000'),
                                  TextSpan(
                                      text: ' coins',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                            VSpace(5.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  DefaultTabController(
                    length: 2, // length of tabs
                    initialIndex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TabBar(
                          labelColor: white,
                          labelPadding: EdgeInsets.only(right: 30.w),
                          indicatorPadding:
                              EdgeInsets.symmetric(horizontal: 0.w),
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 1.0.w,
                                color: white,
                              ),
                              insets: EdgeInsets.symmetric(horizontal: 0.w)),
                          indicatorColor: white.withOpacity(0.2),
                          // indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelColor: white.withOpacity(0.2),
                          padding: EdgeInsets.symmetric(horizontal: 0.w),
                          isScrollable: true,
                          tabs: const [
                            Tab(
                              text: 'PARTICIPANTS',
                            ),
                            Tab(text: '    TOURNAMENT JOURNEY'),
                          ],
                        ),
                        Container(
                            height: 200.h, //height of TabBarView
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: white, width: 0.5))),
                            child: TabBarView(children: <Widget>[
                              SizedBox(
                                height: 300.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: leaderboard.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 0.h, top: 15),
                                      child: rank(
                                          leaderboard[index]['user-name'],
                                          leaderboard[index]['position'],
                                          leaderboard[index]['image'],
                                          leaderboard[index]['is_inclined'],
                                          leaderboard[index]
                                              ['is_current_user']),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 400.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: tournamentJourney.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 0.h, top: 15),
                                      child: journey(
                                          tournamentJourney[index]['stage'],
                                          tournamentJourney[index]['is_waiting'],
                                          tournamentJourney[index]['player1-image'],
                                          tournamentJourney[index]['player2-image'],
                                          tournamentJourney[index]['player1'],
                                          tournamentJourney[index]['player2']
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ])),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }


}
