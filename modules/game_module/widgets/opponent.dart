// Widget opponent(
//   BuildContext context,
// ) {
//   return GestureDetector(
//     onTap:  () => Navigator.push(
//                   context,  TransitionalRoute( Versus(matchData: [],))),
//     child: Padding(
//       padding:  EdgeInsets.only(bottom:20.h),
//       child: Row(
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 width: 57.w,
//                 height: 57.h,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: white,
//                   borderRadius: BorderRadius.circular(10.r),
//                 ),
//                 child: Image.asset(
//                   femaleAvatar,
//                   width: 41.61.w,
//                   height: 47.31.h,
//                 ),
//               ),
//               Positioned(
//                 top: -8,
//                 right: -5,
//                 child: Container(
//                   width: 17.w,
//                   height: 17.h,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: champTextGreen,
//                       borderRadius: BorderRadius.circular(50.r)),
//                 ),
//               ),
//             ],
//           ),
//           HSpace(10.w),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Styles.regular('@Tayo4win',
//                   color: white, fontSize: 16.sp, fontWeight: FontWeight.w500),
//               VSpace(17.h),
//               RichText(
//                 text: TextSpan(
//                   style: TextStyle(
//                       color: white, fontSize: 14.sp, fontWeight: FontWeight.w500),
//                   children: const <TextSpan>[
//                     TextSpan(text: 'Rank '),
//                     TextSpan(text: '15th', style: TextStyle(color: primaryColor))
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }
