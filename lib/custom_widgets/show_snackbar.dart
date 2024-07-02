import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/helper/responsive_helper.dart';

SnackbarController showSnackbar(
    {required String title, required String message, bool? isError = false}) {
  return Get.snackbar(
    title,
    colorText: AppColors.white,
    message,
    backgroundColor: isError != null
        ? isError
            ? AppColors.red
            : AppColors.green
        : AppColors.green,
  );
}

void showCustomSnackBar(
  String? message, {
  bool isError = true,
  bool isCart = false,
}) {
  if (message != null && message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.only(
        right: ResponsiveHelper.isDesktop(Get.context)
            ? Get.context!.width * 0.7
            : Dimensions.PADDING_SIZE_SMALL,
        top: Dimensions.PADDING_SIZE_SMALL,
        bottom: Dimensions.PADDING_SIZE_SMALL,
        left: Dimensions.PADDING_SIZE_SMALL,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: (isError && !isCart) ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      content: Text(
        message,
        style: GoogleFonts.poppins().copyWith(color: Colors.white),
        overflow: TextOverflow.ellipsis,
      ),
      action: isCart
          ? null
          // ? SnackBarAction(
          //     label: 'view_cart'.tr,
          //     onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
          //     textColor: Colors.white,
          //   )
          : null,
    ));
  }
}

void showCustomSnackBarHTML(
  Widget? message, {
  bool isError = true,
  bool isCart = false,
}) {
  if (message != null) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.only(
        right: ResponsiveHelper.isDesktop(Get.context)
            ? Get.context!.width * 0.7
            : Dimensions.PADDING_SIZE_SMALL,
        top: Dimensions.PADDING_SIZE_SMALL,
        bottom: Dimensions.PADDING_SIZE_SMALL,
        left: Dimensions.PADDING_SIZE_SMALL,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: (isError && !isCart) ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      content: SizedBox(height: 100, child: message),
      action: isCart
          ? null
          // ? SnackBarAction(
          //     label: 'view_cart'.tr,
          //     onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
          //     textColor: Colors.white,
          //   )
          : null,
    ));
  }
}
