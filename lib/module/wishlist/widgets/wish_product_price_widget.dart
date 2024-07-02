import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/helper/price_converter.dart';
import 'package:sunglasses/models/product_model.dart';

class WishProductPriceWidget extends StatelessWidget {
  final ProductModel? product;
  const WishProductPriceWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    double? _startingPrice;
    double? _startingDiscountedPrice;
    double? _endingPrice;
    double? _endingDiscountedPrice;
    bool _hasDiscount = false;
    int? _discountInPercentage;
    if (product!.variation != null && product!.variation!.isNotEmpty) {
      List<double> _priceList = [];
      List<double> _discountedPriceList = [];

      for (var variation in product!.variation!) {
        if (variation.regularPrice != null &&
            variation.regularPrice.toString().trim().isNotEmpty) {
          //if(variation.salePrice != null && variation.salePrice.toString().trim().isNotEmpty) {
          _priceList.add(double.parse(variation.regularPrice.toString()));
          //}
        } else {
          _priceList.add(0);
        }
      }

      for (var variation in product!.variation!) {
        if (variation.salePrice.toString() != 'null') {
          _hasDiscount = true;
          _discountedPriceList
              .add(double.parse(variation.salePrice.toString()));
        } else if (variation.regularPrice != null) {
          _discountedPriceList
              .add(double.parse(variation.regularPrice.toString()));
        }
      }

      // Get.find<ProductController>().variations.forEach((variation) {
      //   print('========${variation.toJson()}');
      //   if(variation.regularPrice != null && variation.regularPrice.trim().isNotEmpty) {
      //     _priceList.add(double.parse(variation.regularPrice));
      //   }else {
      //     _priceList.add(0);
      //   }
      // });
      // Get.find<ProductController>().variations.forEach((variation) {
      //   if(variation.salePrice.isNotEmpty) {
      //     _hasDiscount = true;
      //     _discountedPriceList.add(double.parse(variation.salePrice));
      //   }
      // });

      _priceList.sort((a, b) => a.compareTo(b));
      _discountedPriceList.sort((a, b) => a.compareTo(b));
      if (_priceList.isNotEmpty) {
        _startingPrice = _priceList[0];
        // log('Starting Price: $_startingPrice');
      }

      if (_discountedPriceList.isNotEmpty) {
        _startingDiscountedPrice = _discountedPriceList[0];
      }
      if (_priceList.isNotEmpty) {
        if (_priceList[0] < _priceList[_priceList.length - 1]) {
          _endingPrice = _priceList[_priceList.length - 1];
        }
      }
      if (_discountedPriceList.isNotEmpty &&
          _discountedPriceList[0] <
              _discountedPriceList[_discountedPriceList.length - 1]) {
        _endingDiscountedPrice =
            _discountedPriceList[_discountedPriceList.length - 1];
      }
    } else {
      _hasDiscount = product!.salePrice!.isNotEmpty;
      _startingPrice = product!.regularPrice != ''
          ? double.parse(product!.regularPrice.toString())
          : 0;
      _startingDiscountedPrice =
          product!.price != '' ? double.parse(product!.price!) : 0;
      _discountInPercentage =
          (100 - (_startingDiscountedPrice / _startingPrice) * 100).round();
      // log('Had Discount: $_hasDiscount');
      // log('Starting Price: $_startingPrice');
      // log('Starting Discounted Price: $_startingDiscountedPrice');
      // log('Discount: $_discountInPercentage');
      // (100 - (_salePrice / _regularPrice) * 100)
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _startingDiscountedPrice != null
                ? Text(
                    '${PriceConverter.convertPrice(
                      _hasDiscount
                          ? _startingDiscountedPrice.toString()
                          : _startingPrice.toString(),
                      taxStatus: product!.taxStatus,
                      taxClass: product!.taxClass,
                    )}'
                    '${_endingPrice != null ? ' - ${PriceConverter.convertPrice(
                        _endingDiscountedPrice != null
                            ? _endingDiscountedPrice.toString()
                            : _endingPrice.toString(),
                        taxStatus: product!.taxStatus,
                        taxClass: product!.taxClass,
                      )}' : ''}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: Dimensions.fontSizeExtraSmall,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(width: 5),
            _hasDiscount
                ? Text(
                    '${PriceConverter.convertPrice(_startingPrice.toString(), taxStatus: product!.taxStatus, taxClass: product!.taxClass)}'
                    '${_endingPrice != null ? ' - ${PriceConverter.convertPrice(_endingPrice.toString(), taxStatus: product!.taxStatus, taxClass: product!.taxClass)}' : ''}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                    ).copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: Dimensions.fontSizeExtraSmall,
                        decoration: TextDecoration.lineThrough),
                  )
                : const SizedBox(),
            const SizedBox(
              width: 5,
            ),
            _hasDiscount &&
                    (_discountInPercentage != null && _discountInPercentage > 0)
                ? Text(
                    '$_discountInPercentage% OFF',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.fontSizeExtraSmall,
                      color: const Color.fromARGB(255, 255, 154, 195),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
