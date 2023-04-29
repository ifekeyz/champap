import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../shared/utils/color.dart';
import '../../../shared/utils/styles.dart';

exploreChampApp(
    {required BuildContext context,
    required VideoPlayerController videoPlayerController,
    required Future<void> initializeVideoPlayerFuture,
    required void Function() onPressed}) {
  return Container(
    height: 340.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: bottomSheetBlue,
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Styles.regular('Explore the Champs Play App',
                  fontSize: 18.sp, fontWeight: FontWeight.w600, color: white),
              VSpace(8.h),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.647.w,
                  child: Styles.regular(
                      'Watch introductory video to know your way around here easily',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: champTextGrey))
            ]),
            // IconButton(
            //     onPressed: onPressed,
            //     icon: const Icon(
            //       Icons.cancel_outlined,
            //       color: white,
            //       size: 25,
            //     )),
          ],
        ),
        VSpace(36.h),
        FutureBuilder(
          future: initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return AspectRatio(
                aspectRatio:
                    113 / 66, //videoPlayerController.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: Center(child: VideoPlayer(videoPlayerController)),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return const Center(
                child: CircularProgressIndicator(
                  color: white,
                ),
              );
            }
          },
        ),
        VSpace(21.h),
        IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.cancel_outlined,
              color: white,
              size: 25,
            )),
      ],
    ),
  );
}
