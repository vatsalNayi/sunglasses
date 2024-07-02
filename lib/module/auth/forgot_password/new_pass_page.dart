import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/custom_appbar.dart';
import 'package:sunglasses/custom_widgets/custom_button.dart';
import 'package:sunglasses/custom_widgets/custom_textfield.dart';
import 'package:sunglasses/custom_widgets/show_snackbar.dart';
import 'package:sunglasses/custom_widgets/svg_icon.dart';
import 'package:sunglasses/custom_widgets/textfield_decoration.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:sunglasses/routes/pages.dart';

class NewPassPage extends StatefulWidget {
  final String? resetToken;
  final String? number;
  final bool fromPasswordChange;
  NewPassPage(
      {required this.resetToken,
      required this.number,
      required this.fromPasswordChange});

  @override
  State<NewPassPage> createState() => _NewPassPageState();
}

class _NewPassPageState extends State<NewPassPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'reset_password'.tr),
      body: SafeArea(
          child: Scrollbar(
              child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: context.width > 700 ? 700 : context.width,
          padding: context.width > 700
              ? const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
              : null,
          margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          decoration: context.width > 700
              ? BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[Get.isDarkMode ? 700 : 300]!,
                        blurRadius: 5,
                        spreadRadius: 1)
                  ],
                )
              : null,
          child: Column(children: [
            Image.asset(
              ImagePath.reset,
              width: 280.w,
            ),
            SizedBox(height: 50.h),
            Text('enter_new_password'.tr,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center),
            // const SizedBox(height: 50),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 25.h),
                  customDecorationForTextfield(
                    child: GetBuilder<AuthController>(
                      builder: (authController) {
                        return CustomTextfield(
                          obscureText: authController.isShowNewPassword,
                          hintText: 'new_password'.tr,
                          controller: _newPasswordController,
                          inputType: TextInputType.visiblePassword,
                          border: InputBorder.none,
                          prefixIcon: const SvgIcon(
                            imagePath: ImagePath.passwordSvg,
                          ),
                          onTapSuffix:
                              authController.toggleNewPasswordVisibility,
                          suffixIcon: SvgIcon(
                            imagePath: authController.isShowNewPassword
                                ? ImagePath.showPasswordSvg
                                : ImagePath.hidePasswordSvg,
                          ),
                          // prefixIcon: Images.lock,
                          // isPassword: true,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  customDecorationForTextfield(
                    child: GetBuilder<AuthController>(
                      builder: (authController) {
                        return CustomTextfield(
                          obscureText: authController.isShowNewConfirmPassword,
                          hintText: 'confirm_password'.tr,
                          controller: _confirmPasswordController,
                          inputType: TextInputType.visiblePassword,
                          border: InputBorder.none,
                          prefixIcon: const SvgIcon(
                            imagePath: ImagePath.passwordSvg,
                          ),
                          onTapSuffix:
                              authController.toggleNewConfirmPasswordVisibility,
                          suffixIcon: SvgIcon(
                            imagePath: authController.isShowNewConfirmPassword
                                ? ImagePath.showPasswordSvg
                                : ImagePath.hidePasswordSvg,
                          ),
                          // prefixIcon: Images.lock,
                          // isPassword: true,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            GetBuilder<AuthController>(builder: (authBuilder) {
              return
                  // (!authBuilder.isLoading) ?
                  CustomButton(
                loading: authBuilder.isLoading,
                btnText: 'done'.tr,
                // radius: Dimensions.RADIUS_EXTRA_LARGE,
                onPress: () => _resetPassword(widget.number, widget.resetToken,
                    _newPasswordController.text),
              );
              // : const Center(child: CircularProgressIndicator());
            }),
          ]),
        ),
      ))),
    );
  }

  void _resetPassword(String? email, String? otp, String password) async {
    String _password = _newPasswordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();
    if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 4) {
      showCustomSnackBar('password_should_be'.tr);
    } else if (_password != _confirmPassword) {
      showCustomSnackBar('confirm_password_does_not_matched'.tr);
    } else {
      Response response =
          await Get.find<AuthController>().resetPassword(otp, email, password);
      if (response.body['status'] == '200') {
        Get.offAllNamed(Routes.getSignInRoute(from: Routes.resetPassword));
      } else {
        showCustomSnackBar(response.body['status']);
      }
    }
  }
}
