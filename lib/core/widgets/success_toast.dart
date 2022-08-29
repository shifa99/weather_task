import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void successToast(String message)
{
  Fluttertoast.showToast(
        msg:message,
        fontSize: 14.sp,
        textColor: Colors.white,
                    backgroundColor:Colors.green );
}