import 'package:champ_app/modules/home_module/viewmodel/home_vm.dart';
import 'package:champ_app/modules/home_module/widgets/constants.dart';
import 'package:champ_app/shared/widgets/active-matche.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/service_injector/service_injector.dart';
import '../../shared/utils/color.dart';
import '../../shared/utils/images.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/game_card.dart';
import 'widgets/home_screen_header.dart';
import '../../shared/widgets/scroll_tag_action.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      vmBuilder: (context) =>
          HomeViewModel(homeService: si.homeService, context: context),
      builder: _buildScreen,
    );
  }

  Future<void> _store_username(HomeViewModel viewModel_) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', viewModel_.homeContent.username ?? '' );
  }

  Widget _buildScreen(BuildContext context, HomeViewModel viewModel) {
    _store_username(viewModel);

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
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        homeScreenHeader(
                            context,
                            viewModel.homeContent == null
                                ? "there"
                                : viewModel.homeContent.username ??
                                    FirebaseAuth
                                        .instance.currentUser?.displayName ??
                                    userObj["name"] ??
                                    'there'),
                        VSpace(30.h),
                        TextField(
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.w, color: bottomNavBorderTop),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.w, color: bottomNavBorderTop),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              prefixIcon: Icon(Icons.search_rounded,
                                  size: 20.sp, color: champTextGrey),
                              filled: true,
                              fillColor: darkBlue,
                              hintText: 'Search for a game...',
                              hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: champTextGrey)),
                        ),
                        VSpace(30.h),
                        scrollActionTag(
                          context,
                          'New Games',
                          '',
                        ),
                        VSpace(10.h),
                        SizedBox(
                          height: 130.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: games.length,
                            itemBuilder: (context, index) {
                              return game(context, games[index]['image'],
                                  games[index]['name']);
                            },
                          ),
                        ),
                        VSpace(30.h),
                        scrollActionTag(context, 'Popular Games', ''),
                        VSpace(10.h),
                        SizedBox(
                          height: 130.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: pGames.length,
                            itemBuilder: (context, index) {
                              return game(context, pGames[index]['image'],
                                  pGames[index]['name']);
                            },
                          ),
                        ),
                        VSpace(30.h),
                        scrollActionTag(
                          context,
                          'Active Matches',
                          'View All Matches',
                        ),
                        VSpace(10.h),
                        SizedBox(
                          height: 100.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: pGames.length,
                            itemBuilder: (context, index) {
                              return activeMatch(
                                  aGames[index]['image'],
                                  aGames[index]['name'],
                                  aGames[index]['user'],
                                  aGames[index]['coin']);
                            },
                          ),
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
