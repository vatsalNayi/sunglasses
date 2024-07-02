import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/values/colors.dart';
import '../core/utils/dimensions.dart';
import '../core/utils/styles.dart';

class CustomButtonSec extends StatelessWidget {
  final Function? onPressed;
  final String? buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  const CustomButtonSec(
      {this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.margin,
      this.width,
      this.height,
      this.fontSize,
      this.radius = 5,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      //onPressed == null ? Theme.of(context).disabledColor : transparent ? Colors.transparent : Colors.transparent,
      minimumSize: Size(width != null ? width! : Dimensions.WEB_MAX_WIDTH,
          height != null ? height! : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Center(
        child: SizedBox(
            width: width ?? Dimensions.WEB_MAX_WIDTH,
            height: height ?? 50,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  // gradient: LinearGradient(
                  //   colors: transparent
                  //       ? [
                  //           Theme.of(context).cardColor,
                  //           Theme.of(context).cardColor
                  //         ]
                  //       : [
                  //           Get.isDarkMode
                  //               ? Theme.of(context).primaryColorDark
                  //               : AppColors.primaryColor,
                  //           // : Theme.of(context).primaryColor,
                  //           Theme.of(context).colorScheme.secondaryContainer
                  //         ],
                  // ),
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                      color: transparent
                          ? Theme.of(context).hintColor
                          : Colors.transparent)),
              child: Padding(
                padding: margin == null ? const EdgeInsets.all(0) : margin!,
                child: ElevatedButton(
                  onPressed: onPressed as void Function()?,
                  style: _flatButtonStyle,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon != null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: Icon(icon,
                                    color: transparent
                                        ? Get.isDarkMode
                                            ? Theme.of(context).primaryColorDark
                                            : Theme.of(context).primaryColor
                                        : Theme.of(context).cardColor),
                              )
                            : const SizedBox(),
                        Text(buttonText ?? '',
                            textAlign: TextAlign.center,
                            style: poppinsBold.copyWith(
                              //color: transparent  ? Get.isDarkMode ?  Theme.of(context).primaryColor : Theme.of(context).primaryColor : Theme.of(context).cardColor,
                              color: transparent
                                  ? Theme.of(context).hintColor
                                  : Get.isDarkMode
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).cardColor,
                              fontSize: fontSize ?? Dimensions.fontSizeLarge,
                            )),
                      ]),
                ),
              ),
            )));
  }
}
