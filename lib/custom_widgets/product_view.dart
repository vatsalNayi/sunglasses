import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/custom_widgets/no_data_page.dart';
import 'package:sunglasses/custom_widgets/product_card.dart';
import 'package:sunglasses/custom_widgets/product_shimmer.dart';
import '../core/utils/dimensions.dart';
import '../helper/responsive_helper.dart';
import '../models/product_model.dart';
import '../models/shop_model.dart';

class ProductView extends StatelessWidget {
  final List<ProductModel>? products;
  final List<ShopModel>? shops;
  final EdgeInsetsGeometry padding;
  final bool isShop;
  final bool isScrollable;
  final int shimmerLength;
  final String? noDataText;
  const ProductView(
      {super.key,
      required this.products,
      this.isScrollable = false,
      this.shimmerLength = 20,
      this.padding = const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      this.noDataText,
      this.shops,
      this.isShop = false});

  @override
  Widget build(BuildContext context) {
    bool isNull = true;
    int length = 0;
    if (isShop) {
      isNull = shops == null;
      if (!isNull) {
        length = shops!.length;
      }
    } else {
      isNull = products == null;
      if (!isNull) {
        length = products!.length;
      }
    }

    return !isNull
        ? length > 0
            ? GridView.builder(
                key: UniqueKey(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: Get.height * 0.03,
                  childAspectRatio: isShop
                      ? .58
                      : Get.width < 400
                          ? Get.width / 560
                          // ?  .58
                          : .78,
                  crossAxisCount: isShop ? 2 : 2,
                ),
                physics: isScrollable
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                shrinkWrap: isScrollable ? false : true,
                itemCount: length,
                padding: padding,
                itemBuilder: (context, index) {
                  return isShop
                      ? Container()
                      :
                      // return isShop ? AllShopCardWidget(shopModel: shops![index]) :
                      ProductCard(
                          productModel: products![index],
                          allProduct: true,
                          index: index,
                          productList: products,
                        );
                },
              )
            : SizedBox(
                height: Get.context!.height - 150,
                width: Get.context!.width,
                child: NoDataScreen(
                    text: noDataText ??
                        (isShop
                            ? 'no_shop_available'.tr
                            : 'no_product_available'.tr),
                    type: NoDataType.SEARCH))
        : GridView.builder(
            key: UniqueKey(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
              mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                  ? Dimensions.PADDING_SIZE_LARGE
                  : 0.05,
              childAspectRatio: .58,
              crossAxisCount: 2,
            ),
            physics: isScrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            shrinkWrap: isScrollable ? false : true,
            itemCount: shimmerLength,
            padding: padding,
            itemBuilder: (context, index) {
              return const ProductShimmer();
            },
          );
  }
}
