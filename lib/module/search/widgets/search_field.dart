import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/values/colors.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/styles.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String suffixIcon;
  final Function iconPressed;
  final Function? onSubmit;
  final Function? onChanged;
  const SearchField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.suffixIcon,
      required this.iconPressed,
      this.onSubmit,
      this.onChanged});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            width: .2,
            color: AppColors.primaryColor.withOpacity(.3),
          ),
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(.1),
                spreadRadius: 1,
                blurRadius: 5)
          ]),
      child: TextField(
        controller: widget.controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_SMALL,
              right: Dimensions.PADDING_SIZE_SMALL),
          hintText: widget.hint,
          hintStyle: poppinsRegular.copyWith(
              color: AppColors.primaryColor.withOpacity(.8)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: AppColors.primaryColor.withOpacity(.1),
          isDense: true,
          suffixIcon: Container(
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? Theme.of(context).cardColor
                    : AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                  onTap: widget.iconPressed as void Function()?,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: SizedBox(
                          height: 10,
                          width: 10,
                          child: Image.asset(widget.suffixIcon,
                              scale: 2,
                              color: Colors.white,
                              height: 10,
                              width: 10))))),
        ),
        onSubmitted: widget.onSubmit as void Function(String)?,
        onChanged: widget.onChanged as void Function(String)?,
      ),
    );
  }
}
