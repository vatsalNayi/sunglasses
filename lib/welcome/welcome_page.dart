import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/svg_icon.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:sunglasses/routes/pages.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            left: -35,
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                ImagePath.bg,
                height: 312.h,
                width: 312.h,
              ),
            ),
          ),
          Positioned.fill(
            left: -40,
            bottom: -180,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                ImagePath.bg,
                height: 500.h,
                width: 500.h,
              ),
            ),
          ),
          Positioned.fill(
            right: -230,
            bottom: -450,
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                ImagePath.bg,
                height: 500.h,
                width: 500.h,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.welcome,
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            bottom: 30.h,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 192.h,
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  vertical: 40.h,
                  horizontal: 15.w,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 30.w,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 191.w,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Discover Latest Style ',
                          style: GoogleFonts.poppins(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'With Us',
                              style: GoogleFonts.poppins(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      child: Text(
                        '"Sunglasses protect your eyes from harmful UV rays while adding a stylish flair to your look."',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    GetBuilder<AuthController>(builder: (authController) {
                      return GestureDetector(
                        onTap: () {
                          authController.setIsWelcomed(true);
                          debugPrint('${authController.getIsWelcomed()}');
                          Get.offAndToNamed(Routes.dashboardPage);
                        },
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const SvgIcon(
                            imagePath: ImagePath.arrowNext,
                            color: AppColors.white,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
