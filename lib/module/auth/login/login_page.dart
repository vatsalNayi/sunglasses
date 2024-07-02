import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/utils/textfield_validations.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/custom_button.dart';
import 'package:sunglasses/custom_widgets/custom_textfield.dart';
import 'package:sunglasses/custom_widgets/svg_icon.dart';
import 'package:sunglasses/custom_widgets/textfield_decoration.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:sunglasses/module/auth/login/login_controller.dart';
import 'package:sunglasses/routes/pages.dart';

class LoginPage extends StatelessWidget {
  final String? from;
  LoginPage({super.key, this.from});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 14.w,
                  right: 14.w,
                  top: 80.h,
                  bottom: 38.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        width: 302.68.w,
                        height: 285.h,
                        ImagePath.signinPageImage1Svg,
                      ),
                    ),
                    SizedBox(
                      height: 23.h,
                    ),
                    Text(
                      'Sign In Account'.tr,
                      style: GoogleFonts.poppins(
                        color: AppColors.brightGrey,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'We need to verify you. We will send you a one time verification code. ',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    // CustomDecorationForTextfield(
                    //   borderRadius: Dimens.pixel_5,
                    //   child: CustomTextfield(
                    //     // keyboardType: TextInputType.phone,
                    //     inputFormatters: <TextInputFormatter>[
                    //       FilteringTextInputFormatter.digitsOnly
                    //     ],
                    //     hintText: Strings.hint_phone_number,
                    //     hintStyle: textstyle16.copyWith(
                    //       color: AppColors.brightGrey,
                    //     ),
                    //     textStyle: textstyle16.copyWith(
                    //       color: AppColors.brightGrey,
                    //     ),
                    //     controller: controller.phoneController,
                    //     validator: Validations.validatePhoneNumber,
                    //     border: InputBorder.none,
                    //     prefixIcon: Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         SizedBox(
                    //           width: Dimens.pixel_15,
                    //         ),
                    //         LoadSvg(
                    //           imagePath: ImagePath.callSvg,
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.symmetric(
                    //             horizontal: Dimens.pixel_15,
                    //           ),
                    //           child: LoadSvg(
                    //             imagePath: ImagePath.indiaFlagSvg,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    //

                    CustomTextfield(
                      controller: controller.usernameEmailController,
                      // validator: Validations.validateUser,
                      hintText: 'Username / Email',
                      hintStyle: GoogleFonts.poppins(
                        color: AppColors.brightGrey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.44,
                      ),
                      textStyle: GoogleFonts.poppins(
                        color: AppColors.brightGrey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.44,
                      ),
                      border: InputBorder.none,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(
                      () => CustomTextfield(
                        obscureText: controller.isShowPassword.value,
                        hintText: 'Password',
                        hintStyle: GoogleFonts.poppins(
                          color: AppColors.brightGrey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.44,
                        ),
                        textStyle: GoogleFonts.poppins(
                          color: AppColors.brightGrey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.44,
                        ),
                        controller: controller.passwordController,
                        validator: Validations.validatePassword,
                        border: InputBorder.none,
                        prefixIcon: const SvgIcon(
                          imagePath: ImagePath.passwordSvg,
                          fit: BoxFit.scaleDown,
                        ),
                        onTapSuffix: controller.togglePasswordVisibility,
                        suffixIcon: SvgIcon(
                          imagePath: controller.isShowPassword.value
                              ? ImagePath.showPasswordSvg
                              : ImagePath.hidePasswordSvg,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.getForgotPassRoute());
                        },
                        child: Text(
                          'Forgot password',
                          style: GoogleFonts.poppins(
                            color: AppColors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.44,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45.h,
                    ),

                    GetBuilder<AuthController>(builder: (authController) {
                      return CustomButton(
                        loading: authController.isLoading,
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            controller.loginWoo(authController);
                          } else {
                            debugPrint('form not validated');
                          }
                        },
                        btnText: 'Login',
                      );
                    }),

                    SizedBox(
                      height: 30.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.signUpPage);
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t have an Account? ',
                              style: GoogleFonts.poppins(
                                color: AppColors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.15,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign up now',
                              style: GoogleFonts.poppins(
                                color: AppColors.primaryColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
