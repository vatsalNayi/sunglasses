import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: Get.isDarkMode
              ? Theme.of(context).colorScheme.background
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    ));
  }
}
