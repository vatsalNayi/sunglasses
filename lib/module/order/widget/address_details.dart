import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import '../../../core/utils/styles.dart';
import '../../../models/address_model.dart';

class AddressDetails extends StatelessWidget {
  final AddressModel addressDetails;
  const AddressDetails({
    Key? key,
    required this.addressDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            addressDetails.address1!,
            style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            addressDetails.address2!,
            style: poppinsRegular.copyWith(
                fontSize: Dimensions.fontSizeExtraSmall,
                color: Theme.of(context).disabledColor),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Wrap(children: [
            (addressDetails.city != null && addressDetails.city!.isNotEmpty)
                ? Text(
                    '${'city'.tr}: ${addressDetails.city!}',
                    style: poppinsRegular.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                : const SizedBox(),

            // (addressDetails.state != null && addressDetails.state.isNotEmpty) ? Text((addressDetails.city != null ? ', ' : '')
            //     + 'state'.tr +': ' + addressDetails.state,
            //   style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall), maxLines: 2, overflow: TextOverflow.ellipsis,
            // ) : SizedBox(),
            //
            // (addressDetails.country != null && addressDetails.country.isNotEmpty) ? Text(((addressDetails.country != null
            //     || addressDetails.state != null) ? ', ' : '') + 'country'.tr+': ' + addressDetails.country ,
            //   style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall), maxLines: 2, overflow: TextOverflow.ellipsis,
            // ) : SizedBox(),
          ]),
        ]);
  }
}
