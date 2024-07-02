import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/module/address/saved_address_screen.dart';
import 'package:sunglasses/module/cart/cart_controller.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/values/strings.dart';
import '../../../../models/profile_model.dart';

class ProfileAddressCard extends StatelessWidget {
  final String title;
  final bool billingAddress;
  final bool fromProfile;
  final ProfileAddressModel? address;
  final bool formAddress;
  const ProfileAddressCard(
      {required this.title,
      required this.billingAddress,
      required this.fromProfile,
      this.address,
      this.formAddress = false});

  @override
  Widget build(BuildContext context) {
    return formAddress
        ? Container(
            width: Dimensions.WEB_MAX_WIDTH,
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            // padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, 0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.RADIUS_LARGE)),
              border:
                  Border.all(color: AppColors.primaryColor.withOpacity(0.20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${address!.firstName} ${address!.lastName}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                            ).copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                          const SizedBox(),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_SMALL,
                            vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? Theme.of(context).primaryColorLight
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                                Dimensions.PADDING_SIZE_DEFAULT),
                            border: Border.all(
                              color: Get.isDarkMode
                                  ? Theme.of(context).primaryColor
                                  : AppColors.primaryColor,
                            )),
                        child: Text(
                          billingAddress ? 'billing'.tr : 'shipping'.tr,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                          ).copyWith(
                            fontSize: 12.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ]),
                const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Text(
                    '${address!.address1} ${address!.address2} ${address!.city} ${address!.postcode}, ${address!.state != null ? address!.state : ''} , ${address!.country} ',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                    ).copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).textTheme.labelSmall!.color)),
                const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Text('${address!.phone}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                    ).copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).textTheme.labelSmall!.color)),
                const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                billingAddress
                    ? Text('${address!.email}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                        ).copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color:
                                Theme.of(context).textTheme.labelSmall!.color))
                    : const SizedBox(),
                billingAddress
                    ? const SizedBox(height: Dimensions.PADDING_SIZE_SMALL)
                    : const SizedBox(),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[Get.isDarkMode ? 700 : 200]!,
                    blurRadius: 10)
              ],
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GetBuilder<CartController>(builder: (cartController) {
                return InkWell(
                  onTap: () => cartController.isLoading
                      ? null
                      : formAddress
                          ? null
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SavedAddressScreen(
                                      fromBilling: billingAddress,
                                      fromShipping: !billingAddress,
                                      fromProfile: fromProfile))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                          ).copyWith(fontSize: Dimensions.fontSizeLarge),
                        ),
                      ),
                      formAddress
                          ? const SizedBox()
                          : cartController.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator())
                              : Image.asset(
                                  ImagePath.chooseAddress,
                                  height: 20,
                                  scale: 3,
                                ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              address != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          address!.firstName != ''
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      bottom:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: Row(children: [
                                    Text(
                                      '${'name'.tr}:',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                      ).copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    const SizedBox(
                                        width: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    Expanded(
                                        child: Text(
                                      (address!.firstName != null &&
                                              address!.lastName != null)
                                          ? ('${address!.firstName!} ${address!.lastName!}')
                                          : '',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                      ).copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: AppColors.primaryColor,
                                      ),
                                    )),
                                  ]),
                                )
                              : const SizedBox(),
                          address!.address1 != ''
                              ? Row(children: [
                                  Text(
                                    '${'address'.tr}:',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                    ).copyWith(
                                        fontSize: Dimensions.fontSizeDefault),
                                  ),
                                  const SizedBox(
                                      width:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  Expanded(
                                      child: Text(
                                    address!.address1 ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                    ).copyWith(
                                        fontSize: Dimensions.fontSizeDefault),
                                  )),
                                ])
                              : const SizedBox(),
                          Wrap(children: [
                            (address!.city != '' && address!.city!.isNotEmpty)
                                ? Text(
                                    '${'city'.tr}: ${address!.city!}, ',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                    ).copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).hintColor),
                                  )
                                : const SizedBox(),
                            (address!.state != '' && address!.state != null)
                                ? Text(
                                    '${'state'.tr}: ${address!.state!}, ',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                    ).copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).hintColor),
                                  )
                                : const SizedBox(),
                            (address!.postcode != null &&
                                    address!.postcode!.isNotEmpty)
                                ? Text(
                                    '${'post_code'.tr}: ${address!.postcode!}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                    ).copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).hintColor),
                                  )
                                : const SizedBox(),
                            (address!.country != '' && address!.country != null)
                                ? Text(
                                    '${'country'.tr}: ${address!.country!}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                    ).copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).hintColor),
                                  )
                                : const SizedBox(),
                          ]),
                          SizedBox(
                              height: (address!.phone != null &&
                                      address!.phone!.isNotEmpty)
                                  ? Dimensions.PADDING_SIZE_SMALL
                                  : 0),
                          (address!.phone != null && address!.phone!.isNotEmpty)
                              ? Text(
                                  address!.phone ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                  ).copyWith(
                                      fontSize: Dimensions.fontSizeSmall),
                                )
                              : const SizedBox(),
                          (address!.email != null && address!.email!.isNotEmpty)
                              ? Text(
                                  address!.email ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                  ).copyWith(
                                      fontSize: Dimensions.fontSizeSmall),
                                )
                              : const SizedBox(),
                        ])
                  : const SizedBox(),
              SizedBox(
                  height: address != null ? Dimensions.PADDING_SIZE_SMALL : 0),
              address == null
                  ? const Center(
                      child: Text('LOADING...'),
                      // child: CircularProgressIndicator(),
                    )
                  : (address!.country == '' &&
                          address!.state == '' &&
                          address!.firstName == '' &&
                          address!.firstName == '')
                      ? Center(
                          child: Text(
                              billingAddress
                                  ? 'add_billing_address'.tr
                                  : 'add_shipping_address'.tr,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                              ).copyWith(
                                  color: Colors.red,
                                  fontSize: Dimensions.fontSizeSmall)))
                      : const SizedBox(),
            ]),
          );
  }
}
