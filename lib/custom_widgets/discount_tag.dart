import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/dimensions.dart';
import '../core/utils/styles.dart';
import '../helper/responsive_helper.dart';

class DiscountTag extends StatelessWidget {
  final String? regularPrice;
  final String? salePrice;
  final double fromTop;
  final double? fontSize;
  final bool inLeft;
  final bool inTop;
  final double? fromBottom;
  final bool isRoundedStyle;
  DiscountTag({
    required this.regularPrice,
    required this.salePrice,
    this.fromTop = 10,
    this.fontSize,
    this.inLeft = true,
    this.inTop = false,
    this.isRoundedStyle = false,
    this.fromBottom,
  });

  @override
  Widget build(BuildContext context) {
    double _regularPrice =
        regularPrice!.isNotEmpty ? double.parse(regularPrice!) : 0;
    double _salePrice = salePrice!.isNotEmpty ? double.parse(salePrice!) : -1;
    double _percentage = (100 - (_salePrice / _regularPrice) * 100);
    String _newline = inTop ? ' ' : '\n';

    return (_salePrice != -1 && _salePrice < _regularPrice)
        ? Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.all(Radius.circular(
                  isRoundedStyle ? 200 : Dimensions.RADIUS_SMALL)),
            ),
            child: Text(
              '${_percentage.round()}%$_newline${'off'.tr}',
              style: poppinsMedium.copyWith(
                color: Colors.white,
                fontSize: isRoundedStyle
                    ? 12
                    : fontSize ?? (ResponsiveHelper.isMobile(context) ? 8 : 12),
              ),
              textAlign: TextAlign.center,
            ),
          )
        : const SizedBox();
  }
}
