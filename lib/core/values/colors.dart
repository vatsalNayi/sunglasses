import 'package:flutter/material.dart';

class AppColors {
  static const white = Colors.white;
  static const black = Colors.black;
  static const transparent = Colors.transparent;
  static const lightBlack = Color.fromARGB(255, 67, 67, 67);
  static const cyan = Color(0xff48FFEB);
  static const green = Colors.green;
  static const classicRose = Color(0xFFF5CADB);
  static const oysterPink = Color(0xFFF3C9D7);
  static const softPink = Color.fromARGB(255, 255, 154, 195);
  static const lightRose = Color(0x7FF5CADB);
  static const lightoysterPink = Color(0XFFF1CADC);
  static const grey = Color(0XFF959598);
  static const regentGrey = Color(0xFF959597);
  static const smokeyGrey = Color(0xFF707070);
  static const brightGrey = Color(0xFF37474F);
  static const lightGrey = Color(0xB737474F);
  static const halloweenOrange = Color(0xFFDA6A2B);
  static const red = Colors.red;
  static const sweetCorn = Color(0xFFFFEB98);
  static const seaShell = Color(0xFFF0F1F2);
  static const lightGreen = Color(0xFF66D39A);
  static const darkGray = Color(0xFF252525);
  static const bgColorLogo = Color(0xFFEBEBEB);
  static const bgColorCard = Color(0xFFF4F4F4);
  static const bgGrey = Color(0xFFD9D9D9);
  static const bgGreyDark = Color(0xFFDCDBDB);
  static const checkboxColor = Color(0xFFE9E9E9);
  static const primaryColor = Color(0xFF34D2FF);
  static const skyBlue = Color(0xFFC2F1FF);
  static const dashboard = Color(0xFFD8F6FF);
  // static const gradient1 = Color(0xFFFF5F6D);
  static const gradient2 = Color(0xFFFFC371);
  static const iconColor = Color(0xFFFF686D);
  static const categoryBg = Color(0xFFF0F0F0);
  static const seaPink = Color(0xFFFF8892);
  static const hitPink = Color(0xFFFFB070);
  static const reddishOrange = Color(0xFFFFF2E9);
  static const lawnGreen = Color(0xFF43AE01);
  static const lineFont = Color(0xFFA4A4A4);
  static const yellow = Color(0xFFFFC600);
  static const esterGreen = Color(0xFF70FF76);
  static const brightRed = Color(0xFFFF0000);
  static const lightSlate = Color(0xFFD0FFFF);
}

const LinearGradient gradientLeftToRight = LinearGradient(
  colors: [
    AppColors.primaryColor,
    AppColors.gradient2,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient gradientTopToBottom = LinearGradient(
  colors: [
    AppColors.primaryColor,
    AppColors.gradient2,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

LinearGradient gradientTopToBottomOpacity = LinearGradient(
  colors: [
    AppColors.primaryColor.withOpacity(.15),
    AppColors.gradient2.withOpacity(.15),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
