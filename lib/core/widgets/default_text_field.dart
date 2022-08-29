import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextFormField defaultTextField({
  required TextEditingController controller,
  required String hint,
  required Function validator,
  Function? onSubmitted,
  Function? onTap,
  Function? onChanged,
  FocusNode? focusNode,
  Color? fillColor = Colors.white,
  required TextInputType type,
  String? title,
  TextInputAction? action,
  int? maxLines = 1,
  double radius = 5,
  Widget? prefix,
  Widget? suffix,
  bool? isPassword,
}) {
  return TextFormField(
    focusNode: focusNode,
    onChanged: (value) {
      if (onChanged != null) onChanged(value);
    },
    obscureText: isPassword ?? false,
    onTap: () {
      if (onTap != null) onTap();
    },
    onFieldSubmitted: (String? value) {
      if (onSubmitted != null) onSubmitted();
    },
    controller: controller,
    validator: (String? value) {
      return validator(value);
    },
    keyboardType: type,
    maxLines: maxLines,
    textInputAction: action ?? TextInputAction.next,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.w,
            color: const Color(0xffF1F1F1),
          ),
          borderRadius: BorderRadius.circular(radius.r)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: Color(0xff009F8B),
          )),
      filled: true,
      labelText: title,
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      ),
      contentPadding: EdgeInsetsDirectional.only(
          start: 15.7.w, end: 10.w, top: 1.5.h, bottom: 1.5.h),
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 13.sp,
        color: Colors.black,
        fontWeight: FontWeight.w300,
      ),
      prefixIcon: prefix,
      suffixIcon: suffix,

      //suffix: suffix,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xffF1F1F1))),
      fillColor: fillColor,
    ),
  );
}
