import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle buildTextStyle({required double fontSize, required Color color}) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
    );
TextStyle headerTextStyle({Color? color}) {
  return buildTextStyle(fontSize: 25.sp, color: color ?? Colors.black);
}

TextStyle bodyStyle({Color? color}) {
  return buildTextStyle(fontSize: 16.sp, color: color ?? Colors.white);
}
