import 'package:flutter/material.dart';
import '../core/utils/dimensions.dart';
import '../core/utils/styles.dart';
import '../core/values/strings.dart';

enum NoDataType {
  CART,
  NOTIFICATION,
  ORDER,
  COUPON,
  OTHERS,
  WISH,
  SEARCH,
  PAGES
}

class NoDataScreen extends StatelessWidget {
  final NoDataType? type;
  final String? text;
  NoDataScreen({required this.text, this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(),
            // // Image.asset(
            // //   ImagePath.tShirt2Png,
            // (type == NoDataType.CART)
            //     ? Images.empty_cart
            //     : type == NoDataType.COUPON
            //         ? Images.empty_coupon
            //         : type == NoDataType.PAGES
            //             ? Images.no_pages_found
            //             : type == NoDataType.NOTIFICATION
            //                 ? Images.no_notification_found
            //                 : type == NoDataType.ORDER
            //                     ? Images.no_order_found
            //                     : type == NoDataType.WISH
            //                         ? Images.empty_wishlist
            //                         : type == NoDataType.SEARCH
            //                             ? Images.no_search_found
            //                             : Images.no_internet,
            // // width: MediaQuery.of(context).size.height * 0.20,
            // // height: MediaQuery.of(context).size.height * 0.20,
            // // ),
            const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
            Text(
              text!,
              style: poppinsMedium.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.0175,
                  color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
          ]),
    );
  }
}
