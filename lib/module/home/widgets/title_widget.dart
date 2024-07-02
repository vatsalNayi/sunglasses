import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/helper/responsive_helper.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Function? onTap;
  const TitleWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ).copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: AppColors.black,
          )),
      (onTap != null && !ResponsiveHelper.isDesktop(context))
          ? InkWell(
              onTap: onTap as void Function()?,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  'see_all'.tr,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                  ).copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: AppColors.black,
                  ),
                ),
              ),
            )
          : const SizedBox(),
    ]);
  }
}
