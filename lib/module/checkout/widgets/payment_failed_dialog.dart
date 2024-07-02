import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/styles.dart';
import '../../../core/values/strings.dart';

class PaymentFailedDialog extends StatelessWidget {
  final int orderID;
  const PaymentFailedDialog({super.key, required this.orderID});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: Image.asset(ImagePath.warning, width: 70, height: 70),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Text(
                  'are_you_agree_with_this_order_fail'.tr,
                  textAlign: TextAlign.center,
                  style: poppinsMedium.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: Text(
                  'if_you_do_not_pay'.tr,
                  style: poppinsMedium.copyWith(
                      fontSize: Dimensions.fontSizeLarge),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              // GetBuilder<OrderController>(builder: (orderController) {
              //   return !orderController.isLoading
              //       ? Column(children: [
              //           CustomButtonSec(
              //             buttonText: 'switch_to_cash_on_delivery'.tr,
              //             onPressed: () => orderController.switchToCOD(orderID),
              //             radius: Dimensions.RADIUS_SMALL,
              //             height: 40,
              //           ),
              //           const SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
              //           TextButton(
              //             onPressed: () {
              //               // Get.offAllNamed(RouteHelper.getInitialRoute());
              //             },
              //             style: TextButton.styleFrom(
              //               backgroundColor: Theme.of(context)
              //                   .disabledColor
              //                   .withOpacity(0.3),
              //               minimumSize:
              //                   const Size(Dimensions.WEB_MAX_WIDTH, 40),
              //               padding: EdgeInsets.zero,
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(
              //                       Dimensions.RADIUS_SMALL)),
              //             ),
              //             child: Text('continue_with_order_fail'.tr,
              //                 textAlign: TextAlign.center,
              //                 style: poppinsBold.copyWith(
              //                     color: Theme.of(context)
              //                         .textTheme
              //                         .bodyLarge!
              //                         .color)),
              //           ),
              //         ])
              //       : const Center(child: CircularProgressIndicator());
              // }),
            ]),
          )),
    );
  }
}
