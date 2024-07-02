import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/values/colors.dart';

class CustomTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onChange;
  final Widget? prefixIcon;
  final InputBorder? border;
  final int? maxLines;
  final TextStyle? style;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool? obscureText;
  final VoidCallback? onTapSuffix;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final bool isEnabled;
  final TextInputType inputType;
  final Color fillColor;
  final TextCapitalization capitalization;
  final InputDecoration? inputDecoration;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;
  final double? borderRadius;

  const CustomTextfield({
    Key? key,
    required this.hintText,
    this.controller,
    this.validator,
    this.onChange,
    this.prefixIcon,
    this.border,
    this.maxLines = 1,
    this.style,
    this.suffixIcon,
    this.textStyle,
    this.hintStyle,
    this.obscureText = false,
    this.onTapSuffix,
    this.readOnly = false,
    this.keyboardType,
    this.inputFormatters,
    this.errorText,
    this.isEnabled = true,
    this.inputType = TextInputType.name,
    this.fillColor = Colors.transparent,
    this.capitalization = TextCapitalization.none,
    this.inputDecoration,
    this.textInputAction,
    this.onTap,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly ?? false,
      obscureText: widget.obscureText ?? false,
      enabled: widget.isEnabled,
      controller: widget.controller,
      maxLines: widget.obscureText == true ? 1 : widget.maxLines,
      textCapitalization: widget.capitalization,
      textInputAction: widget.textInputAction,
      decoration: widget.inputDecoration == null
          ? InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              prefixIcon: widget.prefixIcon,
              fillColor: widget.fillColor,
              suffixIcon: GestureDetector(
                onTap: widget.onTapSuffix,
                child: SizedBox(
                  child: widget.suffixIcon,
                ),
              ),
              // border: widget.border,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? 5.r,
                ),
                borderSide: BorderSide(
                  color: AppColors.black.withOpacity(.25),
                ),
              ),
              errorText: widget.errorText,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
            )
          : widget.inputDecoration!,
      validator: widget.validator,
      style: widget.textStyle ??
          GoogleFonts.poppins(
            color: AppColors.brightGrey,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.44,
          ),
    );
  }
}
