import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/utils/styles.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/custom_widgets/custom_image.dart';
import 'package:sunglasses/helper/price_converter.dart';
import 'package:sunglasses/models/order_model.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel? order;
  final int? index;
  const OrderWidget({Key? key, this.order, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Container(
          width: Dimensions.WEB_MAX_WIDTH,
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.RADIUS_SMALL)),
            border: Border.all(
                color: Theme.of(context).primaryColorLight.withOpacity(0.20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${'order'.tr}# ${order!.id}',
                      style: poppinsBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .color)),
                  const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Text(PriceConverter.convertPrice(order!.total!),
                      style: poppinsBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: AppColors.primaryColor,
                      )),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  Container(
                    decoration: BoxDecoration(
                        color: (order!.status == 'pending' ||
                                order!.status == 'processing')
                            ? Colors.blue.withOpacity(0.15)
                            : (order!.status == 'cancelled' ||
                                    order!.status == 'failed')
                                ? Colors.red.withOpacity(0.15)
                                : order!.status == 'completed'
                                    ? Colors.green.withOpacity(0.15)
                                    : Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.15),
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL)),
                    height: 35,
                    width: 100,
                    child: Center(
                        child: Text(order!.status!.tr,
                            style: poppinsMedium.copyWith(
                                color: (order!.status == 'pending' ||
                                        order!.status == 'processing')
                                    ? Colors.blue
                                    : (order!.status == 'cancelled' ||
                                            order!.status == 'failed')
                                        ? Colors.red.withOpacity(0.50)
                                        : order!.status == 'completed'
                                            ? Colors.green
                                            : Theme.of(context).primaryColor))),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      order!.lineItems!.isNotEmpty
                          ? orderProductImage(order!.lineItems![0].image!.src)
                          : const SizedBox(),
                      const SizedBox(
                          height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      order!.lineItems!.length >= 2
                          ? orderProductImage(order!.lineItems![1].image!.src)
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  order!.lineItems!.length > 2
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            order!.lineItems!.length >= 3
                                ? orderProductImage(
                                    order!.lineItems![2].image!.src)
                                : const SizedBox(),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            order!.lineItems!.length > 3
                                ? Container(
                                    height: 49,
                                    width: 49,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.RADIUS_SMALL),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).hintColor)),
                                    child: Center(
                                        child: Text(
                                            order!.lineItems!.length == 4
                                                ? 'see'.tr
                                                : order!.lineItems!.length
                                                    .toString(),
                                            style: poppinsBold.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeDefault,
                                                color: Theme.of(context)
                                                    .hintColor))))
                                : const SizedBox(),
                          ],
                        )
                      : const SizedBox(),
                ],
              )
            ],
          )),
    );
  }
}

Widget orderProductImage(String? image) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
    child: CustomImage(
      height: 50,
      width: 50,
      image: image,
    ),
  );
}
