// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:champ_app/shared/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  String hintText;
  String label;
  Color? labelColor;
  String? Function(String? val)? validator;
  Function(String)? onChanged;
  Color? fillingColor;
  bool autofocus;
  bool isEnabled;
  TextInputType? keyboardType;

  int? maxLines;
  TextInputType? textInputType;
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;

  CustomTextFormField({
    Key? key,
    this.textInputType,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.label = '',
    this.labelColor,
    this.fillingColor,
    this.hintText = '',
    this.obscureText = false,
    this.controller,
    this.validator,
    this.onChanged,
    this.autofocus = false,
    this.isEnabled = true,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onChanged: widget.onChanged,
          style: TextStyle(
              color: champTextGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
          enabled: widget.isEnabled,
          inputFormatters: widget.inputFormatters,
          controller: widget.controller,
          maxLines: widget.maxLines,
          obscureText: widget.obscureText,
          obscuringCharacter: '*',
          keyboardType: widget.textInputType,
          validator: widget.validator,
          decoration: InputDecoration(
            // errorStyle: TextStyle(height: 0.h, color: Colors.red),
            // contentPadding:
            //     EdgeInsets.only(top: 16.h, bottom: 16.h, left: 20.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.r),
              borderSide: const BorderSide(
                color: primaryColor,
                width: 0.5,
                style: BorderStyle.solid,
              ),
            ),
            fillColor: widget.fillingColor ?? Colors.transparent,
            filled: true,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: champTextGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.r)),
                borderSide: BorderSide(
                    color: champTextGrey,
                    width: 0.5.w,
                    style: BorderStyle.solid)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.r)),
                borderSide: BorderSide(
                    color: champTextGrey,
                    width: 0.5.w,
                    style: BorderStyle.solid)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.r)),
                borderSide: BorderSide(
                    color: Colors.red, width: 0.5.w, style: BorderStyle.solid)),
          ),
        ),
      ],
    );
  }
}
