import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/custom_image.dart';
import 'package:sunglasses/helper/date_converter.dart';

class NotificationWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? description;
  final String? dateTime;
  final int? unSeenCount;
  final Function? onTap;
  final String? form;
  final int? id;
  const NotificationWidget(
      {Key? key,
      this.image,
      this.title,
      this.unSeenCount,
      this.onTap,
      this.description,
      this.dateTime,
      this.form,
      this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: EdgeInsets.all(Get.isDarkMode
            ? Dimensions.PADDING_SIZE_EXTRA_SMALL
            : Dimensions.PADDING_SIZE_DEFAULT),
        child: Container(
          padding: EdgeInsets.all(
              Get.isDarkMode ? Dimensions.PADDING_SIZE_DEFAULT : 0.0),
          color:
              Get.isDarkMode ? Theme.of(context).cardColor : Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ((image != '') && (form == 'feed' || form == 'offer'))
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      child: CustomImage(
                        image: image,
                        height: 48,
                        width: 48,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                            form == 'activity'
                                ? ImagePath.activity
                                : form == 'offer'
                                    ? ImagePath.offer
                                    : ImagePath.feed,
                            height: 24,
                            width: 24)
                      ],
                    ),
              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                      ).copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: AppColors.primaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    Text(description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                        ).copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Get.isDarkMode
                                ? null
                                : AppColors.primaryColor.withOpacity(0.80)),
                        textAlign: TextAlign.justify),
                    const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    Text(
                      DateConverter.estimatedDateTime(DateTime.parse(dateTime!))
                          .toString(),
                      //DateTime.parse(dateTime).toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                      ).copyWith(fontSize: Dimensions.fontSizeSmall),
                    ),

                    // Text(
                    //   id.toString(),
                    //   style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
