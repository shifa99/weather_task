import 'package:flutter/material.dart';
import 'package:weather_app/core/utills/style_manager.dart';

TextButton defaultTextButton(
    {required Function onPressed, required String title, Color? buttonColor,
    Color?textColor}) {
  return TextButton(
    onPressed: () {
      onPressed();
    },
    // ignore: sort_child_properties_last
    child: Text(
      title,
      style: bodyStyle(color: textColor),
    ),
    style: TextButton.styleFrom(
      backgroundColor: buttonColor ?? Colors.green,
    ),
  );
}
