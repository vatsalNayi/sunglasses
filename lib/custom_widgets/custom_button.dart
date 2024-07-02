import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/values/colors.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onPress;
  String btnText;
  Color? bgColor;
  TextStyle? style;
  EdgeInsetsGeometry? textPadding;
  bool loading;
  double? width;
  double? height;
  double? radius;
  CustomButton({
    required this.onPress,
    required this.btnText,
    this.bgColor,
    this.style,
    this.textPadding,
    required this.loading,
    this.width,
    this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: gradientTopToBottom,
      //   borderRadius: BorderRadius.circular(
      //     radius ?? 10.r,
      //   ),
      // ),
      // width: textPadding != null ? null : double.infinity,
      width: width ?? double.infinity,
      height: height ?? 48.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              radius ?? 10.r,
            ),
          ),
        ),
        onPressed: onPress,
        child: loading
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.white,
                ),
              )
            : Padding(
                padding: textPadding ?? EdgeInsets.all(0.w),
                child: Text(btnText,
                    style: style ??
                        GoogleFonts.poppins(
                          fontSize: 20.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.0,
                        )),
              ),
      ),
    );
  }
}
