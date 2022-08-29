import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> errorToast(String message)async
{
  await Fluttertoast.showToast(
        msg:message,
        fontSize: 14.sp,

        textColor: Colors.white,
                    backgroundColor:Colors.red );
}