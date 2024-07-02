import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/app_constants.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/utils/styles.dart';
import 'package:sunglasses/models/order_model.dart';

class SellerDetailsWidget extends StatelessWidget {
  final OrderModel? order;
  const SellerDetailsWidget({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
          border: Border.all(
              color: Theme.of(context).primaryColorLight.withOpacity(0.30)),
          color: Theme.of(context).cardColor),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: order!.stores!.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Column(
            children: [
              orderBodyText(
                  'store_name'.tr,
                  (AppConstants.vendorType == VendorType.singleVendor)
                      ? AppConstants.APP_NAME
                      : (AppConstants.vendorType == VendorType.dokan &&
                              order!.stores![index].shopName == '')
                          ? AppConstants.DOKAN_ADMIN_STORE_NAME
                          : order!.stores![index].shopName != null
                              ? order!.stores![index].shopName!.capitalizeFirst!
                              : ''),
              order!.stores![index].address != null
                  ? const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL)
                  : const SizedBox(),
              order!.stores![index].address != null
                  ? orderBodyText(
                      'address'.tr,
                      '${order!.stores![index].address!.street1} ${order!.stores![index].address!.street2} ${order!.stores![index].address!.street2 == '' ? '' : ','} '
                      '${order!.stores![index].address!.zip} ${order!.stores![index].address!.zip == '' ? '' : ','} ${order!.stores![index].address!.city} ${order!.stores![index].address!.city == '' ? '' : ','}'
                      ' ${order!.billing!.country}')
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }

  Widget orderBodyText(String title, String value) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(Get.context!).hintColor))),
          SizedBox(
              width: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(value,
                      style: poppinsRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                      textAlign: TextAlign.end),
                ],
              ))
        ],
      ),
    );
  }
}
