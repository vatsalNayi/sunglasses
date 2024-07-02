import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/custom_widgets/custom_image.dart';
import '../model/notification_model.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationModel notificationModel;
  final String? type;
  const NotificationDialog(
      {super.key, required this.notificationModel, this.type});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL))),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              ((notificationModel.image != '') &&
                      (type == 'feed' || type == 'offer'))
                  ? Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.20)),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        child: CustomImage(
                          image: notificationModel.image,
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : const SizedBox(),
              ((notificationModel.image != '') && type == 'feed' ||
                      type == 'offer')
                  ? const SizedBox(height: Dimensions.PADDING_SIZE_SMALL)
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Text(
                  notificationModel.title!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                  ).copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Text(
                  notificationModel.description!.replaceAll('\\', ''),
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                  ).copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
