import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sunglasses/core/values/colors.dart';

class SvgIcon extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;

  const SvgIcon(
      {super.key,
      required this.imagePath,
      this.width,
      this.height,
      this.color,
      this.fit = BoxFit.scaleDown});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imagePath,
      height: width,
      width: height,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
      fit: fit,
    );
  }
}
