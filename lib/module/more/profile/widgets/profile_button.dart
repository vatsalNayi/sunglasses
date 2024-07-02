import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/values/colors.dart';
import '../../../../core/utils/dimensions.dart';

class ProfileButton extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? image;
  ProfileButton({this.title, this.image, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Container(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(image!, height: 25, width: 25),
                  const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  Text(title!,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                      ).copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: AppColors.primaryColor,
                        // color: Theme.of(context).primaryColor,
                      )),
                  const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                ],
              ),
              Flexible(
                  child: Text(
                subTitle!,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                ).copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).hintColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          )),
    );
  }
}
