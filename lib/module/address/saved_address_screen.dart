import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/custom_widgets/custom_appbar.dart';
import '../../../../routes/pages.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';
import '../more/profile/profile_controller.dart';
import '../more/profile/widgets/profile_address_card.dart';
import 'location_controller.dart';
import 'widgets/address_card_widget.dart';

class SavedAddressScreen extends StatefulWidget {
  final bool fromBilling;
  final bool fromShipping;
  final bool? fromProfile;
  const SavedAddressScreen(
      {super.key,
      this.fromBilling = false,
      this.fromShipping = false,
      this.fromProfile});

  @override
  _SavedAddressScreenState createState() => _SavedAddressScreenState();
}

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<LocationController>().getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: widget.fromShipping
                ? 'shipping_address'.tr
                : widget.fromBilling
                    ? 'billing_address'.tr
                    : 'saved_address'.tr),
        body: GetBuilder<LocationController>(builder: (locationController) {
          return GetBuilder<ProfileController>(builder: (profileController) {
            return SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                child: SingleChildScrollView(
                  child: Column(children: [
                    (profileController.profileShippingAddress1 == null &&
                            profileController.profileBillingAddress1 == null)
                        ? const SizedBox()
                        : Container(
                            // padding: EdgeInsets.all(profileController.profileShippingAddress1.country == '' ? 0 :  Dimensions.PADDING_SIZE_LARGE),
                            padding: EdgeInsets.fromLTRB(
                                profileController
                                            .profileShippingAddress1!.country ==
                                        ''
                                    ? 0
                                    : Dimensions.PADDING_SIZE_DEFAULT,
                                profileController
                                            .profileShippingAddress1!.country ==
                                        ''
                                    ? 0
                                    : Dimensions.PADDING_SIZE_DEFAULT,
                                profileController
                                            .profileShippingAddress1!.country ==
                                        ''
                                    ? 0
                                    : Dimensions.PADDING_SIZE_DEFAULT,
                                0),

                            child: Column(
                              children: [
                                (profileController.profileShippingAddress1!
                                                .state ==
                                            '' &&
                                        profileController
                                                .profileShippingAddress1!
                                                .country ==
                                            '')
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          if (!widget.fromProfile! &&
                                              (widget.fromShipping ||
                                                  widget.fromBilling)) {
                                            locationController
                                                .selectProShipping(
                                                    widget.fromShipping);
                                          }
                                        },
                                        child: ProfileAddressCard(
                                          title: 'shipping_address'.tr,
                                          address: profileController
                                              .profileShippingAddress1,
                                          billingAddress: false,
                                          fromProfile: true,
                                          formAddress: true,
                                        ),
                                      ),
                                (profileController.profileShippingAddress1!
                                                .state ==
                                            '' &&
                                        profileController
                                                .profileShippingAddress1!
                                                .country ==
                                            '')
                                    ? const SizedBox()
                                    : const SizedBox(
                                        height:
                                            Dimensions.PADDING_SIZE_DEFAULT),
                                (profileController.profileBillingAddress1!
                                                .state ==
                                            '' &&
                                        profileController
                                                .profileBillingAddress1!
                                                .country ==
                                            '')
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          if (!widget.fromProfile! &&
                                              (widget.fromShipping ||
                                                  widget.fromBilling)) {
                                            locationController.selectProBilling(
                                                widget.fromBilling);
                                          }
                                        },
                                        child: ProfileAddressCard(
                                          title: 'billing_address'.tr,
                                          address: profileController
                                              .profileBillingAddress1,
                                          billingAddress: true,
                                          fromProfile: false,
                                          formAddress: true,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_SMALL),
                      itemCount: locationController.addressList!.length,
                      itemBuilder: (context, index) {
                        return AddressCardWidget(
                            addressModel:
                                locationController.addressList![index],
                            index: index,
                            fromBilling: widget.fromBilling,
                            fromShipping: widget.fromShipping,
                            fromProfile: widget.fromProfile);
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          color: AppColors.primaryColor,
                          radius: const Radius.circular(5),
                          dashPattern: [3, 2],
                          strokeWidth: 1,
                          child: Container(
                            height: 54,
                            width: Dimensions.WEB_MAX_WIDTH,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_DEFAULT)),
                            child: Center(
                                child: Text('+ ${'add_address'.tr}',
                                    style: poppinsMedium.copyWith(
                                      fontSize: Dimensions.fontSizeDefault,
                                      color: AppColors.primaryColor,
                                    ))),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.getAddAddressRoute(null, -1));
                      },
                    )
                  ]),
                ));
          });
        }));
  }
}
