import 'package:champ_app/modules/leader_board_module/viewModel/leaderboard_vm.dart';
import 'package:champ_app/modules/leader_board_module/widgets/ranking_tile.dart';
import 'package:champ_app/modules/leader_board_module/widgets/runner_up_leaders.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/service_injector/service_injector.dart';
import '../../shared/utils/images.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/base_view.dart';

class Leaders extends StatelessWidget {
  Leaders({Key? key}) : super(key: key);

  // final firstLeader =
  //     'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60';
  // final String secondLeader =
  //     "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60";
  // final String thirdLeader =
  //     "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";

  // List leaderboard = [
  //   {
  //     'image':
  //         'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  //     'user-name': 'Phillp',
  //     'position': 13,
  //     'is_inclined': true,
  //     'is_current_user': true
  //   },
  //   {
  //     'image':
  //         'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  //     'user-name': 'Phillp',
  //     'position': 23,
  //     'is_inclined': false,
  //     'is_current_user': false
  //   },
  //   {
  //     'image':
  //         'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  //     'user-name': 'Phillp',
  //     'position': 3,
  //     'is_inclined': true,
  //     'is_current_user': false
  //   },
  //   {
  //     'image':
  //         'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  //     'user-name': 'Phillp',
  //     'position': 15,
  //     'is_inclined': true,
  //     'is_current_user': false
  //   },
  //   {
  //     'image':
  //         'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  //     'user-name': 'Phillp',
  //     'position': 13,
  //     'is_inclined': true,
  //     'is_current_user': false
  //   },
  //   {
  //     'image':
  //         'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  //     'user-name': 'Phillp',
  //     'position': 13,
  //     'is_inclined': false,
  //     'is_current_user': false
  //   }
  // ];
  @override
  Widget build(BuildContext context) {
    return BaseView<LeaderViewModel>(
      vmBuilder: (context) =>
          LeaderViewModel(gameService: si.gameService, context: context),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, LeaderViewModel viewModel) {
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
        title: Styles.bold('LEADER BOARD', fontSize: 20.sp, color: white),
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 24.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        VSpace(35.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            runnerUps(
                                viewModel.leaderboardData[2].user!.avatar!, 3),
                            Stack(
                              children: [
                                Container(
                                  width: 172.w,
                                  height: 172,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            spikeBg,
                                          ),
                                          fit: BoxFit.cover)),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: 119.w,
                                        height: 119.h,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(viewModel
                                                .leaderboardData[0]
                                                .user!
                                                .avatar!),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100.r)),
                                          border: Border.all(
                                            color: primaryColor,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -20,
                                        right: 40,
                                        child: Container(
                                          width: 38.w,
                                          height: 38.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(50.r)),
                                          child: Styles.regular('1',
                                              fontSize: 18.sp,
                                              color: black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Positioned(
                                        top: -48,
                                        right: 30,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 5.0.h),
                                          child: Image.asset(
                                            leaderCrown,
                                            width: 57.w,
                                            height: 37.h,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            runnerUps(
                                viewModel.leaderboardData[1].user!.avatar!, 2),
                          ],
                        ),
                        VSpace(35.h),
                        SizedBox(
                          height: 300.h,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: viewModel.leaderboardData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 15.h),
                                child: rank(
                                    viewModel
                                        .leaderboardData[index].user!.username!,
                                    viewModel.leaderboardData[index].user!
                                        .scoreBoardPosition!,
                                    viewModel
                                        .leaderboardData[index].user!.avatar!,
                                    viewModel.leaderboardData[index].user!
                                            .scoreBoardPosition! >
                                        index,
                                    false),
                              );
                            },
                          ),
                        ),
                        VSpace(20.h),
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
