import 'package:flutter/material.dart';

void closeKeyboard(BuildContext context) {
  FocusManager.instance.primaryFocus!.unfocus();
  // FocusScope.of(context).requestFocus(FocusNode());
}
