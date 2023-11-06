import 'package:flutter/material.dart';

abstract class Pallets {
  static const primary = Color(0xFFCD0683);
  static const pinkLight = Color(0xFFEF0096);
  static const primaryDark = Color(0xFF800066);
  static const primaryLight = Color(0xFFFFE1F4);
  static const maybeBlack = Color(0xFF101010);
  static const black = Colors.black;
  static const red = Colors.red;
  static const white = Colors.white;

  static const grey = Color(0xff6D6D6D);
  static const chatTextFiledGrey = Color(0xffF7F7FC);
  static const searchGrey = Color(0xffF3F3F3);
  static const onboardingTextWhite = Color(0xfbF7F9FA);

  static const borderGrey = Color(0xffCCCCCC);
  static const unselectedGrey = Color(0xffB4B4B4);
  static const navBarColor = Color(0xffFAFAFA);
  static const otpBorderGrey = Color(0xffE6E6E6);
  static const hintGrey = Color(0xff868686);
  static const error = Color(0xffCA1818);
  static const secondary = Color(0xFFCC9933);

  static const MaterialColor kToDark = MaterialColor(
    0xff09447f,
    <int, Color>{
      50: Color(0xff083d72),
      100: Color(0xff073666),
      200: Color(0xff063059),
      300: Color(0xff05294c),
      400: Color(0xff052240),
      500: Color(0xff041b33),
      600: Color(0xff031426),
      700: Color(0xff020e19),
      800: Color(0xff01070d),
      900: Color(0xff000000),
    },
  );
  static const MaterialColor kToLight = MaterialColor(
    0xff09447f,
    <int, Color>{
      50: Color(0xff22578c),
      100: Color(0xff3a6999),
      200: Color(0xff537ca5),
      300: Color(0xff6b8fb2),
      400: Color(0xff84a2bf),
      500: Color(0xff9db4cc),
      600: Color(0xffb5c7d9),
      700: Color(0xffcedae5),
      800: Color(0xffe6ecf2),
      900: Color(0xffffffff),
    },
  );
}
