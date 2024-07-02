import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/styles.dart';
import 'package:sunglasses/module/address/saved_address_screen.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/values/strings.dart';
import '../../../models/address_model.dart';
import '../../cart/cart_controller.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final AddressModel? address;
  final bool billingAddress;
  final bool fromProfile;
  const AddressCard(
      {required this.title,
      required this.address,
      required this.billingAddress,
      required this.fromProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[Get.isDarkMode ? 700 : 200]!, blurRadius: 10)
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GetBuilder<CartController>(builder: (cartController) {
          return InkWell(
            onTap: () => cartController.isLoading
                ? null
                : Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SavedAddressScreen(
                        fromBilling: billingAddress,
                        fromShipping: !billingAddress,
                        fromProfile: false))),
            child: Row(
              children: [
                Expanded(
                    child: Text(title,
                        style: poppinsMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge))),
                cartController.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator())
                    : Image.asset(ImagePath.chooseAddress,
                        height: 25, scale: 3),
              ],
            ),
          );
        }),
        const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        address != null
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                address!.firstName != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                            bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Row(children: [
                          Text(
                            '${'name'.tr}:',
                            style: poppinsRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(
                              width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Expanded(
                              child: Text(
                            (address!.firstName != null &&
                                    address!.lastName != null)
                                ? ('${address!.firstName!} ${address!.lastName!}')
                                : '',
                            style: poppinsMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).primaryColor),
                          )),
                        ]),
                      )
                    : const SizedBox(),
                address!.address1 != null
                    ? Row(children: [
                        Text(
                          '${'address'.tr}:',
                          style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                        const SizedBox(
                            width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Expanded(
                            child: Text(
                          address!.address1 ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault),
                        )),
                      ])
                    : const SizedBox(),
                Wrap(children: [
                  (address!.city != null && address!.city!.isNotEmpty)
                      ? Text(
                          '${'city'.tr}: ${address!.city!}, ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).hintColor),
                        )
                      : const SizedBox(),
                  (address!.state != null && address!.state != null)
                      ? Text(
                          '${'state'.tr}: ${address!.state!.name!}, ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).hintColor),
                        )
                      : const SizedBox(),
                  (address!.postcode != null && address!.postcode!.isNotEmpty)
                      ? Text(
                          '${'post_code'.tr}: ${address!.postcode!}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).hintColor),
                        )
                      : const SizedBox(),
                  (address!.country != null && address!.country != null)
                      ? Text(
                          '${'country'.tr}: ${address!.country!.name!}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).hintColor),
                        )
                      : const SizedBox(),
                ]),
                SizedBox(
                    height:
                        (address!.phone != null && address!.phone!.isNotEmpty)
                            ? Dimensions.PADDING_SIZE_SMALL
                            : 0),
                (address!.phone != null && address!.phone!.isNotEmpty)
                    ? Text(
                        address!.phone ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: poppinsRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall),
                      )
                    : const SizedBox(),
                (address!.email != null && address!.email!.isNotEmpty)
                    ? Text(
                        address!.email ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: poppinsRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall),
                      )
                    : const SizedBox(),
              ])
            : const SizedBox(),
        SizedBox(height: address != null ? Dimensions.PADDING_SIZE_SMALL : 0),
      ]),
    );
  }
}
