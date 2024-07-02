import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/svg_icon.dart';
import 'package:sunglasses/models/cart_model.dart';
import 'package:sunglasses/module/cart/cart_controller.dart';

class ItemQuantityWidget extends StatelessWidget {
  bool isQtyBg;
  final CartModel? cartData;
  final CartController controller;
  ItemQuantityWidget({
    super.key,
    this.isQtyBg = false,
    this.cartData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (cartData!.quantity != null && cartData!.quantity! > 1) {
              cartData!.quantity = (cartData!.quantity! - 1);
              controller.update();
            }
          },
          child: GestureDetector(
            onTap: () {
              if (cartData!.quantity != null && cartData!.quantity! > 1) {
                cartData!.quantity = (cartData!.quantity! - 1);
                controller.update();
              }
            },
            child: Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(5.r),
              ),
              padding: EdgeInsets.all(6.w),
              child: const SvgIcon(
                imagePath: ImagePath.minus,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        GetBuilder<CartController>(
          builder: (_) {
            return Container(
              height: 18.h,
              width: 48.w,
              decoration: isQtyBg
                  ? BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5.r),
                    )
                  : null,
              child: Text(
                // '1',
                '${cartData?.quantity}',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () {
            if (cartData!.quantity != null) {
              cartData!.quantity = (cartData!.quantity! + 1);
              controller.update();
            }
          },
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5.r),
            ),
            padding: EdgeInsets.all(6.w),
            child: const SvgIcon(
              imagePath: ImagePath.plus,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
