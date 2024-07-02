import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/custom_widgets/custom_image.dart';
import 'package:sunglasses/custom_widgets/discount_tag.dart';
import 'package:sunglasses/module/wishlist/controller/wish_controller.dart';
import '../core/utils/dimensions.dart';
import '../core/utils/styles.dart';
import '../core/values/colors.dart';
import '../core/values/strings.dart';
import '../helper/price_converter.dart';
import '../models/product_model.dart';
import '../module/home/products/controller/product_controller.dart';
import '../routes/pages.dart';
import 'svg_icon.dart';

class ProductCard extends StatelessWidget {
  final bool allProduct;
  final ProductModel? productModel;
  final int index;
  final List<ProductModel>? productList;
  const ProductCard(
      {Key? key,
      this.productModel,
      this.allProduct = false,
      required this.index,
      required this.productList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      return SizedBox(
        width: 200,
        height: 255,
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.getProductDetailsRoute(
                          productModel!.id, '', false),
                    );
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 292,
                            height: 231,
                            decoration: ShapeDecoration(
                              // color: AppColors.sweetCorn,
                              color: AppColors.primaryColor.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: CustomImage(
                                height: double.maxFinite,
                                image: productController
                                    .getImageUrl(productModel!.images!),
                                fit: BoxFit.cover,
                              ),
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
                              horizontal: 15.h,
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
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 15.h,
                                left: 10.w,
                                right: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.24,
                                        child: Text(
                                          productModel!.name ?? '',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            // height: 0.04,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      GetBuilder<WishListController>(
                                          builder: (wishListController) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.find<WishListController>()
                                                .addProductToWishlist(
                                                    productList!
                                                        .elementAt(index));
                                          },
                                          child: Center(
                                            child: Icon(
                                              size: 18.w,
                                              wishListController.wishIdList
                                                      .contains(productList!
                                                          .elementAt(index)
                                                          .id)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: wishListController
                                                      .wishIdList
                                                      .contains(productList!
                                                          .elementAt(index)
                                                          .id)
                                                  ? AppColors.red
                                                  : Theme.of(context).hintColor,
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      (productModel!.regularPrice !=
                                              productModel!.price)
                                          ? Text(
                                              PriceConverter.convertPrice(
                                                  productModel!.regularPrice!,
                                                  taxStatus:
                                                      productModel!.taxStatus,
                                                  taxClass:
                                                      productModel!.taxClass),
                                              style: poppinsBold.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeSmall,
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                  decoration: TextDecoration
                                                      .lineThrough))
                                          : const SizedBox(),
                                      SizedBox(width: 5.w),
                                      (productModel!.regularPrice !=
                                              productModel!.price)
                                          ? const SizedBox(width: 3)
                                          : const SizedBox(),
                                      Text(
                                          PriceConverter.convertPrice(
                                              productModel!.price!,
                                              taxStatus:
                                                  productModel!.taxStatus,
                                              taxClass: productModel!.taxClass),
                                          style: poppinsBold.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ],
                                  ),
                                ],
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
              right: 10,
              top: 10,
              child: Align(
                alignment: Alignment.topRight,
                child: DiscountTag(
                  regularPrice: productModel!.regularPrice,
                  salePrice: productModel!.salePrice,
                ),
              ),
            ),
            Positioned.fill(
              right: 20.0,
              top: 220,
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.getProductDetailsRoute(
                          productModel!.id, '', false),
                    );
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: ShapeDecoration(
                      color: AppColors.primaryColor.withOpacity(.5),
                      shape: const OvalBorder(
                        side: BorderSide(width: 3, color: AppColors.white),
                      ),
                    ),
                    child: const SvgIcon(
                      imagePath: ImagePath.backRightSvg,
                      fit: BoxFit.scaleDown,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
