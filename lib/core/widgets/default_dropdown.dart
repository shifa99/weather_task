import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utills/style_manager.dart';

Widget defaultDropdownButtonWithIcon({
  required String title,
  String? value,
  required Function onChanged,
  required IconData icon,
  String? Function(String?)? validator,
  required List<DropdownMenuItem<String>> items,
}) {
  return Container(
    //height: 48.h,
    padding: EdgeInsetsDirectional.only(
      start: 10.w,
    ),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4.r),
      border: Border.all(color:const Color(0xffF1F1F1)),
    ),
    child: DropdownButtonFormField<String>(
        isExpanded: true,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            size: 25.sp,
          ),
          // hintStyle: TextStyle(color: Colors.black),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
        iconEnabledColor: Color(0xff989898),
        value: value,
        onChanged: (value) {
          onChanged(value);
        },
        hint: Text(title,style: bodyStyle(),),
        items: items),
  );
}