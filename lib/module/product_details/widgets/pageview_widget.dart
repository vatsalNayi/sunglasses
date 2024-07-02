import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/models/product_model.dart';
import 'package:sunglasses/module/product_details/product_details_controller.dart';

class PageViewWidget extends StatelessWidget {
  final product;
  const PageViewWidget({
    super.key,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    ProductDetailsController controller = Get.put(ProductDetailsController());
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 225.h,
            // // width: 200.w,
            // height: 180,
            // width: 180,
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: product!.images!.length,
              itemBuilder: (context, index) {
                ImageModel imageData = product!.images!.elementAt(index);
                return Stack(
                  children: [
                    Positioned.fill(
                      bottom: -10,
                      child: Image.network(
                        '${imageData.src}',
                        height: 180.h,
                        width: 231.w,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20.0),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < product!.images!.length; i++)
          GetBuilder<ProductDetailsController>(builder: (controller) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.getCurrentPage == i
                    ? AppColors.primaryColor
                    : AppColors.grey,
              ),
            );
          }),
      ],
    );
  }
}
