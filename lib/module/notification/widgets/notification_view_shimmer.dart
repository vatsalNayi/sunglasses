import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../controller/theme_controller.dart';

class NotificationViewShimmer extends StatelessWidget {
  const NotificationViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Shimmer(
                child: Padding(
                  padding: EdgeInsets.all(Get.isDarkMode
                      ? Dimensions.PADDING_SIZE_EXTRA_SMALL
                      : Dimensions.PADDING_SIZE_DEFAULT),
                  child: Container(
                    height: 55,
                    padding: EdgeInsets.all(
                        Get.isDarkMode ? Dimensions.PADDING_SIZE_DEFAULT : 0.0),
                    color: Get.isDarkMode
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey[
                                Get.find<ThemeController>().darkTheme
                                    ? 700
                                    : 300],
                            borderRadius: BorderRadius.circular(
                                Dimensions.RADIUS_DEFAULT),
                          ),
                        ),
                        const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 15,
                                  width: 200,
                                  color: Colors.grey[
                                      Get.find<ThemeController>().darkTheme
                                          ? 700
                                          : 300]),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Container(
                                  height: 12,
                                  width: 150,
                                  color: Colors.grey[
                                      Get.find<ThemeController>().darkTheme
                                          ? 700
                                          : 300]),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Container(
                                  height: 10,
                                  width: 130,
                                  color: Colors.grey[
                                      Get.find<ThemeController>().darkTheme
                                          ? 700
                                          : 300]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
