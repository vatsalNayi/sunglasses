import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/custom_widgets/svg_icon.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final String icon;
  final Color? iconBgColor;
  const CustomButtonWithIcon({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
    this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AbsorbPointer(
            absorbing: true,
            child: Container(
              width: 256.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(
                  20.r,
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: AppColors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            right: 3.w,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 38.h,
                width: 38.w,
                decoration: BoxDecoration(
                  color: iconBgColor ?? AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: SvgIcon(
                  imagePath: icon,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
