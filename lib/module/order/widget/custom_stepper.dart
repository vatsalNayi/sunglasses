import 'package:flutter/material.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/utils/styles.dart';

class CustomStepper extends StatelessWidget {
  final bool isActive;
  final bool haveLeftBar;
  final bool haveRightBar;
  final String title;
  final bool rightActive;
  const CustomStepper(
      {super.key,
      required this.title,
      required this.isActive,
      required this.haveLeftBar,
      required this.haveRightBar,
      required this.rightActive});

  @override
  Widget build(BuildContext context) {
    Color _color = isActive
        ? Theme.of(context).primaryColor
        : Theme.of(context).disabledColor;
    Color _right = rightActive
        ? Theme.of(context).primaryColor
        : Theme.of(context).disabledColor;

    return Expanded(
      child: Column(children: [
        Row(children: [
          Expanded(
              child: haveLeftBar
                  ? Divider(color: _color, thickness: 2)
                  : const SizedBox()),
          Padding(
            padding: EdgeInsets.symmetric(vertical: isActive ? 0 : 5),
            child: Icon(isActive ? Icons.check_circle : Icons.blur_circular,
                color: _color, size: isActive ? 25 : 15),
          ),
          Expanded(
              child: haveRightBar
                  ? Divider(color: _right, thickness: 2)
                  : const SizedBox()),
        ]),
        Text(
          '$title\n',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: poppinsMedium.copyWith(
              color: _color, fontSize: Dimensions.fontSizeExtraSmall),
        ),
      ]),
    );
  }
}
