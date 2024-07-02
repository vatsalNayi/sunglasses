import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/helper/product_type.dart';
import 'package:sunglasses/models/product_model.dart';
import 'package:sunglasses/module/home/widgets/popular_product_shimmer.dart';
import 'package:sunglasses/module/home/widgets/title_widget.dart';
import 'package:sunglasses/module/product_details/product_details.dart';
import 'package:sunglasses/routes/pages.dart';
import '../products/all_product_screen.dart';
import '../products/controller/product_controller.dart';

class PopularProductView extends StatelessWidget {
  final bool isPopular;
  final bool newArrival;
  const PopularProductView(
      {super.key, required this.isPopular, this.newArrival = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      List<ProductModel>? _productList = [];
      _productList = isPopular
          ? productController.popularProductList
          : newArrival
              ? productController.productList!
              : productController.reviewedProductList!;
      ScrollController _scrollController = ScrollController();

      return (_productList != null && _productList.isEmpty)
          ? const SizedBox()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      Dimensions.PADDING_SIZE_DEFAULT,
                      15,
                      Dimensions.PADDING_SIZE_DEFAULT,
                      10),
                  child: TitleWidget(
                    title: isPopular
                        ? 'popular_products'.tr
                        : newArrival
                            ? 'new_arrival'.tr
                            : 'most_reviewed_products'.tr,
                    onTap: () {
                      Get.to(() => AllProductScreen(
                          productType: isPopular
                              ? ProductType.POPULAR_PRODUCT
                              : newArrival
                                  ? ProductType.LATEST_PRODUCT
                                  : ProductType.REVIEWED_PRODUCT));
                    },
                  ),
                ),
                SizedBox(
                  height: 260,
                  child: _productList != null
                      ? ListView.builder(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(
                              left: Dimensions.PADDING_SIZE_SMALL),
                          itemCount: _productList.length > 10
                              ? 10
                              : _productList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  2, 2, Dimensions.PADDING_SIZE_SMALL, 2),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.getProductDetailsRoute(
                                        _productList![index].id, '', false),
                                    arguments: ProductDetails(
                                      formSplash: false,
                                      product: _productList[index],
                                      url: '',
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Text('data'),
                                ),
                                // child: ProductCard(
                                //     productModel: _productList![index],
                                //     index: index,
                                //     productList: _productList),
                              ),
                            );
                          },
                        )
                      : const PopularProductShimmer(),
                  // PopularFoodShimmer(enabled: _productList == null),
                ),
              ],
            );
    });
  }
}
