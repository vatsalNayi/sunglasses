import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/svg_icon.dart';
import 'package:sunglasses/module/cart/cart_controller.dart';
import 'package:sunglasses/module/home/home_controller.dart';
import 'package:sunglasses/routes/pages.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? leadingIcon;
  void Function()? onTapLeading;
  String title;
  String? trailingIcon;
  VoidCallback? onTapTrailing;
  bool isCartIcon;
  Color? trailingColor;
  bool automaticallyImplyLeading;
  Color? backgroundColor;
  CustomAppBar({
    super.key,
    this.leadingIcon,
    this.onTapLeading,
    required this.title,
    this.trailingIcon,
    this.onTapTrailing,
    this.isCartIcon = false,
    this.trailingColor,
    this.automaticallyImplyLeading = false,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading:
          automaticallyImplyLeading && leadingIcon == null ? true : false,
      leading: leadingIcon == null
          ? null
          : GestureDetector(
              onTap: onTapLeading,
              child: SvgIcon(
                imagePath: leadingIcon!,
                color: AppColors.black,
                fit: BoxFit.scaleDown,
              )),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        trailingIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: onTapTrailing,
                  child: GetBuilder<HomeController>(
                    builder: (_) {
                      return SvgIcon(
                        imagePath: trailingIcon!,
                        color: trailingColor,
                        height: 15.0,
                        width: 15.0,
                      );
                    },
                  ),
                ),
              )
            : const SizedBox(),
        isCartIcon
            ? Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: GetBuilder<CartController>(builder: (cartController) {
                  return GestureDetector(
                    onTap: () {
                      debugPrint('Global widget pressed');

                      final fullRouteName =
                          ModalRoute.of(context)?.settings.name;
                      if (fullRouteName != null) {
                        final routeName = Uri.parse(fullRouteName).path;
                        if (routeName != '/cart') {
                          Get.toNamed(Routes.getCartRoute());
                          debugPrint('Navigate to cart page ');
                        } else {
                          debugPrint('Not Navigate to cart page');
                        }
                      }
                    },
                    child: AbsorbPointer(
                      child: Badge(
                        alignment: Alignment.topRight,
                        smallSize: 10,
                        largeSize: 18,
                        isLabelVisible:
                            Get.find<CartController>().cartList != null &&
                                Get.find<CartController>().cartList!.isNotEmpty,
                        label: Center(
                          child: Text(
                            cartController.cartList!.length.toString(),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ).copyWith(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        child: SizedBox(
                          height: 30.h,
                          width: 30.w,
                          child: const SvgIcon(
                            imagePath: ImagePath.cartSvg,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              )
            : const SizedBox(),
      ],
    );
  }
}
