import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import '../../../../core/values/colors.dart';

class PopularProductShimmer extends StatelessWidget {
  const PopularProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
          child: SizedBox(
            width: 200,
            height: 255,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 292,
                                height: 231,
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
                            ),
                          ),
                          Positioned.fill(
                            left: 0,
                            right: 0,
                            bottom: 45.h,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 262.w,
                                height: 75.h,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                ),
                                decoration: ShapeDecoration(
                                  color: AppColors.white
                                      .withOpacity(0.800000011920929),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20.r,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  right: 20.0,
                  top: 220,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {},
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
                    ),
                  ),
                )
              ],
            ),
          )
              .animate(
                  onComplete: (controller) => controller.repeat(reverse: false))
              .shimmer(duration: 1000.ms),
        );
      },
    );
  }
}
