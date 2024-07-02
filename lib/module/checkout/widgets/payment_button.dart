import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/styles.dart';

class PaymentButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final bool isSelected;
  final Function onTap;
  PaymentButton(
      {required this.isSelected,
      required this.title,
      required this.icon,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(
                width: isSelected ? 1 : 0,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor),
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                  blurRadius: 5,
                  spreadRadius: 1)
            ],
          ),
          child: ListTile(
            leading: Image.asset(icon, height: 40, width: 40),
            title: Text(
              title,
              style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
            ),
            // subtitle: Text(
            //   subtitle,
            //   style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
            //   maxLines: 1, overflow: TextOverflow.ellipsis,
            // ),
            trailing: isSelected
                ? Icon(Icons.check_circle,
                    color: Theme.of(context).primaryColor)
                : null,
          ),
        ),
      ),
    );
  }
}
