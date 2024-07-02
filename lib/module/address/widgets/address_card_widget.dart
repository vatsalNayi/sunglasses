import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/styles.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/custom_widgets/confirm_dialog.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/values/strings.dart';
import '../../../models/address_model.dart';
import '../../more/profile/profile_controller.dart';
import '../add_address_screen.dart';
import '../location_controller.dart';

class AddressCardWidget extends StatelessWidget {
  final AddressModel? addressModel;
  final int? index;
  final bool fromBilling;
  final bool fromShipping;
  final bool? fromProfile;
  const AddressCardWidget(
      {Key? key,
      this.addressModel,
      this.index,
      this.fromBilling = false,
      this.fromShipping = false,
      this.fromProfile})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_EXTRA_SMALL,
          Dimensions.PADDING_SIZE_DEFAULT, 15, 0),
      child: InkWell(
        onTap: () {
          if (fromProfile! && fromShipping) {
            Get.find<ProfileController>()
                .setProfileAddress(addressModel!, fromShipping);
            Get.find<LocationController>()
                .setProfileSelectedShippingAddressIndex(index);
            Get.back();
          } else if (fromProfile! && fromBilling) {
            Get.find<ProfileController>()
                .setProfileAddress(addressModel!, false);
            Get.find<LocationController>()
                .setProfileSelectedBillingAddressIndex(index);
            Get.back();
          } else if (fromBilling) {
            Get.find<LocationController>().setBillingAddressIndex(index);
            Get.find<LocationController>()
                .setProfileSelectedBillingAddressIndex(index);
            Get.back();
          } else if (fromShipping) {
            Get.find<LocationController>()
                .setShippingAddressIndex(index, notify: true);
            Get.find<LocationController>()
                .setProfileSelectedShippingAddressIndex(index);
            Get.back();
          }
        },
        child: Container(
          width: Dimensions.WEB_MAX_WIDTH,
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.RADIUS_LARGE)),
            border: Border.all(color: AppColors.primaryColor.withOpacity(0.20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${addressModel!.firstName} ${addressModel!.lastName}',
                        style: poppinsBold.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: AppColors.primaryColor,
                        )),
                    const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    InkWell(
                        child: Image.asset(ImagePath.editAddress,
                            height: 20, width: 20),
                        onTap: () {
                          Get.to(() => AddAddressScreen(
                              address: addressModel,
                              index: index,
                              fromEdit: true));
                        }),
                  ],
                ),
                InkWell(
                    child: Image.asset(ImagePath.deleteAddress,
                        height: 20, width: 20),
                    onTap: () {
                      Get.dialog(
                          ConfirmationDialog(
                              icon: ImagePath.deleteAddress,
                              description: 'are_you_sure_to_delete_address'.tr,
                              isLogOut: true,
                              onYesPressed: () {
                                Get.find<LocationController>()
                                    .removeFromAddressList(index!);
                                Get.back();
                              }),
                          useSafeArea: false);
                    }),
              ]),
              const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Text(
                  '${addressModel!.address1} ${addressModel!.address2} ${addressModel!.city} ${addressModel!.postcode}, ${addressModel!.state != null ? addressModel!.state!.name : ''} , ${addressModel!.country!.name} ',
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.labelSmall!.color)),
              const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text('${addressModel!.phone}',
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.labelSmall!.color)),
              const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text('${addressModel!.email}',
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.labelSmall!.color)),
              const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            ],
          ),
        ),
      ),
    );
  }
}
