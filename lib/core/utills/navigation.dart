import 'package:flutter/material.dart';

Future<dynamic> navigateTo(
    {required BuildContext context, required Widget screen}) async {
  return await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

Future<dynamic> navigateAndFinish(
    {required BuildContext context, required Widget screen}) async {
  Navigator.popUntil(context, (route) => false);
  navigateTo(context: context, screen: screen);
}
