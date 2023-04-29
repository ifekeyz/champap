
import 'package:flutter/material.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/styles.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
  final Widget? icon;
  final String title;
  final onPress;
  final Color? color;
  final Color? txtColor;
  final double? width;
  final double? height;
  final bool hasElevation;
  final double? txtSize;
  final bool isActive;

  const CustomButton(
      {Key? key,
      this.icon,
      required this.title,
      required this.onPress,
      this.color,
      this.txtColor,
      this.txtSize,
      this.width,
      this.height,
      this.isActive = false,
      this.hasElevation = false})
      : super(key: key);
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.sp),
      ),
      width: widget.width ?? 321.w, //double.infinity,
      height: widget.height ?? 48.h,
      child: ElevatedButton(
        onPressed: widget.onPress,
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(6)),
            backgroundColor: MaterialStateProperty.all<Color>(
                //widget.color ?? Color(0xffF2902F)
                widget.isActive
                    ? primaryColor
                    : primaryColor.withOpacity(0.4))),
        // child: Text(
        //   widget.title,
        //   style: TextStyle(
        //     color: widget.txtColor ?? Colors.white,
        //     fontWeight: FontWeight.bold,
        //     fontSize: widget.txtSize ?? 16,
        //   ),
        // ),

        child: Styles.semiBold(widget.title,
            color: widget.isActive ? white : Color(0xff8692A6),
            fontSize: 14.sp),
      ),
    );
  }
}
