import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MaincategoriesShimmerWidget extends StatelessWidget {
  const MaincategoriesShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            color: Colors.grey.withOpacity(0.4),
          );
        },
        separatorBuilder: (context, index) {
          return const VerticalDivider();
        },
      ),
    )
        .animate(
          onComplete: (controller) => controller.repeat(),
        )
        .shimmer(duration: 1500.ms);
  }
}
