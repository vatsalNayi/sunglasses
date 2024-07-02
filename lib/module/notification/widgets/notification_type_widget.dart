import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/values/colors.dart';

class NotificationType extends StatelessWidget {
  final String? image;
  final String? title;
  final int? unSeenCount;
  final Function? onTap;
  const NotificationType(
      {Key? key, this.image, this.title, this.unSeenCount, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(image!, height: 25, width: 25),
                const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Text(title!,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                    ).copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: AppColors.primaryColor,
                    )),
              ],
            ),
            Icon(Icons.arrow_forward_ios,
                size: 15, color: Theme.of(context).primaryColorLight),
          ],
        ),
      ),
    );
  }
}
