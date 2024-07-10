import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/models/product_model.dart';
import 'package:sunglasses/module/home/products/controller/product_controller.dart';
import 'package:sunglasses/module/wishlist/controller/wish_controller.dart';

import '../../cart/cart_controller.dart';

class GridProducts extends StatelessWidget {
  ProductModel productList;
  int index;
  GridProducts({
    super.key,
    required this.productList,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.skyBlue.withOpacity(.5),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: AppColors.black.withOpacity(.25),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  '${productList.images?.first.src}',
                  fit: BoxFit.contain,
                  width: 100.w,
                  height: 100.h,
                ),
                SizedBox(height: 6.h),
                Text(
                  '${productList.name}',
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black.withOpacity(.7),
                  ),
                ),
                Text(
                  '₹${productList.price}',
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // SizedBox(height: 8.h),
                // GetBuilder<ProductController>(builder: (productController) {
                //   return GestureDetector(
                //     onTap: () {
                //       Get.find<CartController>().addToCart(
                //         productController.cartModel,
                //         index,
                //       );
                //     },
                //     child: Container(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: 20.w,
                //         vertical: 5.h,
                //       ),
                //       decoration: BoxDecoration(
                //         color: AppColors.white,
                //         borderRadius: BorderRadius.circular(5.r),
                //       ),
                //       child: Text(
                //         'ADD TO CART',
                //         style: GoogleFonts.poppins(
                //           fontSize: 14.sp,
                //           fontWeight: FontWeight.w500,
                //           color: AppColors.black,
                //         ),
                //       ),
                //     ),
                //   );
                // }),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10.0,
          right: 10.0,
          child: GetBuilder<WishListController>(builder: (wishListController) {
            return GestureDetector(
              onTap: () {
                Get.find<WishListController>()
                    .addProductToWishlist(productList);
              },
              child: Icon(
                wishListController.wishIdList.contains(productList.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: wishListController.wishIdList.contains(productList.id)
                    ? AppColors.red
                    : Theme.of(context).hintColor,
              ),
            );
          }),
        ),
      ],
    );
  }
}
