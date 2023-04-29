// ignore_for_file: unnecessary_import

import 'package:champ_app/modules/home_module/home.dart';
import 'package:champ_app/modules/auth/fund_wallet.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/view_model/bottom_nav_model.dart';
import '../../../shared/utils/color.dart';
import '../../../shared/utils/styles.dart';

class BottomNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomNav();
  }
}

class _BottomNav extends State<BottomNav> {
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavModel>(
      builder: (context, model, child) => Scaffold(
        // key: _scaffoldKey,
        backgroundColor: white,
        bottomNavigationBar: Container(
          height: 90.h,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
        decoration: const  BoxDecoration(
          color: bottomNavBlue,
          border: Border(
            top: BorderSide(
              color: bottomNavBorderTop,
              width: 2,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: bottomNavBorderTop,
              blurRadius: 25.0,
              spreadRadius: 5.0,
              offset:  Offset(
                15.0,
                15.0,
              ),
            )
          ],
        ),
          child: BottomNavigationBar(
              onTap: (index) => model.updateIndex(index),
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              unselectedItemColor: champTextGrey,
              selectedItemColor: primaryColor,
              selectedLabelStyle: TextStyle(
                  color: white, fontSize: 10.sp, fontWeight: FontWeight.w600, height: 2.h),
              unselectedLabelStyle: TextStyle(
                  color: champTextGrey, fontSize: 10.sp, fontWeight: FontWeight.w600, height: 2.h),
              backgroundColor: bottomNavBlue,
              currentIndex: model.currentIndex,
              items: userBottomTabItems(context)
          ),
        ),
        body: SafeArea(
            child: IndexedStack(
                index: model.currentIndex, children: model.children)),
      ),
    );
  }

  ///bottom nav items
  userBottomTabItems(BuildContext context) {
    return [
      BottomNavigationBarItem(
        activeIcon: Image.asset(
          homeIcon,
          height: 22.h,
          width: 22.w,
          color: primaryColor
        ),
        icon: Image.asset(
          homeIcon,
          height: 22.h,
          width: 22.w,
          color: champTextGrey,
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
        activeIcon: Image.asset(
           trophyIcon,
          height: 23.h,
          width: 23.w,
          color: primaryColor
        ),
        icon: Image.asset(
          trophyIcon,
          height: 23,
          width: 23,
          color: champTextGrey,
        ),
        label: "Leaders",
      ),
      BottomNavigationBarItem(
        activeIcon: Image.asset(
          gameIcon,
          height: 22.h,
          width: 22.w,
          color: primaryColor,
        ),
        icon: Image.asset(
          gameIcon,
          height: 20,
          width: 20,
          color: champTextGrey,
        ),
        label: "Games",
      ),
      BottomNavigationBarItem(
        activeIcon: Image.asset(
          walletIcon,
          height: 22.h,
          width: 22.w,
          color: primaryColor
        ),
        icon: Image.asset(
          walletIcon,
          height: 18,
          width: 18,
          color: champTextGrey,
        ),
        label: "Wallet",
      ),
      BottomNavigationBarItem(
        activeIcon: Image.asset(
          settingsIcon,
          height: 18.h,
          width: 18.w,
          color: primaryColor,
        ),
        icon: Image.asset(
          settingsIcon,
          height: 20,
          width: 20,
          color: champTextGrey,
        ),
        label: "Settings",
      ),
      
    ];
  }
}

