import 'package:flutter/material.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode currenFocus, FocusNode nextFocus) {
    currenFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
