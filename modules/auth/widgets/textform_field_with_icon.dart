// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:champ_app/shared/utils/styles.dart';

class TextFormFieldWithIcon extends StatefulWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;

  const TextFormFieldWithIcon(
      {Key? key,
      this.prefixIcon,
      this.suffixIcon,
      this.labelText,
      this.validator,
      this.obscureText = false,
      this.controller})
      : super(key: key);

  @override
  _TextFormFieldWithIconState createState() => _TextFormFieldWithIconState();
}

class _TextFormFieldWithIconState extends State<TextFormFieldWithIcon> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        //border: InputBorder.none,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.sp),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        fillColor: const Color(0xffF3F3F3),
        filled: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.sp)),
            borderSide: const BorderSide(color: primaryColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.sp)),
            borderSide: const BorderSide(color: Colors.red)),
      ),
    );
  }
}
