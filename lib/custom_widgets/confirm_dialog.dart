import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunglasses/custom_widgets/custom_button_comp.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import '../core/utils/dimensions.dart';
import '../core/utils/styles.dart';
import '../module/more/profile/profile_controller.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final Function? onNoPressed;
  const ConfirmationDialog(
      {super.key,
      required this.icon,
      this.title,
      required this.description,
      required this.onYesPressed,
      this.isLogOut = false,
      this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
          width: 500.w,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: Image.asset(icon, width: 120, height: 120),
              ),

              title != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: poppinsMedium.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Colors.red),
                      ),
                    )
                  : const SizedBox(),

              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: Text(description,
                    style: poppinsMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge),
                    textAlign: TextAlign.center),
              ),
              // SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              GetBuilder<ProfileController>(builder: (profileController) {
                // return GetBuilder<OrderController>(builder: (orderController) {

                return GetBuilder<AuthController>(builder: (authController) {
                  // return (!profileController.isLoading &&
                  //         !authController.isLoading &&
                  //         !orderController.isLoading) ?
                  return Row(children: [
                    Expanded(
                        child: TextButton(
                      onPressed: () => isLogOut
                          ? onYesPressed()
                          : onNoPressed != null
                              ? onNoPressed!()
                              : Get.back(),
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).disabledColor.withOpacity(0.3),
                        minimumSize: const Size(Dimensions.WEB_MAX_WIDTH, 40),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL)),
                      ),
                      child: Text(
                        isLogOut ? 'yes'.tr : 'no'.tr,
                        textAlign: TextAlign.center,
                        style: poppinsBold.copyWith(
                            color:
                                Theme.of(context).textTheme.bodyLarge!.color),
                      ),
                    )),
                    const SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                    Expanded(
                        child: CustomButtonSec(
                      buttonText: isLogOut ? 'no'.tr : 'yes'.tr,
                      onPressed: () => isLogOut ? Get.back() : onYesPressed(),
                      radius: Dimensions.RADIUS_SMALL,
                      height: 40,
                    )),
                  ]);
                  // : const Center(child: CircularProgressIndicator());
                });
                // });
              }),
            ]),
          )),
    );
  }
}
