import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/values/colors.dart';

class ProductShimmer extends StatefulWidget {
  const ProductShimmer({super.key});

  @override
  State<ProductShimmer> createState() => _ProductShimmerState();
}

class _ProductShimmerState extends State<ProductShimmer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 292.w,
      height: 255.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  // Get.toNamed(
                  //     Routes.getProductDetailsRoute(-1, '', false));
                },
                child: Stack(
                  children: [
                    Container(
                      width: 292, //
                      height: 231, //
                      decoration: ShapeDecoration(
                        color: AppColors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 15.h,
                      child: Container(
                        width: 262.w, //
                        height: 75.h, //
                        margin: EdgeInsets.symmetric(
                          horizontal: 15.w,
                        ),
                        decoration: ShapeDecoration(
                          color: AppColors.white.withOpacity(0.800000011920929),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20.r,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 15.h,
                            left: 15.w,
                            right: 15.r,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: Text(
                                      '',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        color: AppColors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        // height: 0.04,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 20.0,
            top: 220,
            child: Container(
              width: 36,
              height: 36,
              decoration: const ShapeDecoration(
                color: AppColors.grey,
                shape: OvalBorder(
                  side: BorderSide(width: 3, color: AppColors.white),
                ),
              ),
            ),
          )
        ],
      ),
    )
        .animate(onComplete: (controller) => controller.repeat(reverse: false))
        .shimmer(duration: 1000.ms);
  }
}
