import 'package:flutter/material.dart';

class AppStyles {
  static InputBorder border = OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xff181A20)),
    borderRadius: BorderRadius.circular(20),
  );
  static InputBorder kmenuborder = OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xff181A20)),
    borderRadius: BorderRadius.circular(12),
  );
  static CircularProgressIndicator progressIndicator =
      const CircularProgressIndicator(
    strokeWidth: 2,
    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    backgroundColor: Colors.grey,
  );
}

class AppColors {
  static const Color kdarkBlueColor = Color(0xff181A20);
  static const Color ktextFieldColor = Color(0xff262A34);
  static const Color kbuttonColor = Color(0xff5468FF);
  static const Color kgreyColor = Color(0xff4A4B51);
}
