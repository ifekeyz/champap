import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/color.dart';
import '../../../shared/utils/styles.dart';

Widget rank(
    String userName,
    int position,
    String imageURL,
    bool isInclined,
    bool isCurrentUser
    ){
  return ListTile(
    tileColor: isCurrentUser ? lightBlue : darkBlue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r)
    ),
    leading: CircleAvatar(
      backgroundImage: NetworkImage(
          imageURL),
      radius: 16.r,
    ),
    title: Styles.regular( isCurrentUser ? 'My Ranking':'@$userName', fontSize: 14.sp, fontWeight: FontWeight.w500, color: white),

    trailing: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Styles.regular('$position', fontSize: 14.sp, fontWeight: FontWeight.w500, color: white),
        Icon(isInclined ? Icons.arrow_drop_up:Icons.arrow_drop_down, size: 30, color: isInclined ? Colors.green : Colors.red,),
      ],
    ),
  );
}