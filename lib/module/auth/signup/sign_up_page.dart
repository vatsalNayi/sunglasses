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
import 'package:sunglasses/module/auth/signup/sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final apiService = ApiService(dio);
  // final ApiService apiService = ApiService(dio);

  @override
  Widget build(BuildContext context) {
    SignupController controller = Get.put(SignupController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              top: 24.h,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome you’ve been missed!',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGray,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'We need to verify you. We will send you a one time verification code.',
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      color: AppColors.darkGray,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomTextfield(
                    controller: controller.firstNameController,
                    hintText: 'First Name',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16.sp,
                    ),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 16.sp,
                    ),
                    validator: Validations.validateName,
                    border: InputBorder.none,
                    prefixIcon: SvgIcon(
                      imagePath: ImagePath.personSvg,
                      width: 17.w,
                      height: 17.h,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextfield(
                    hintText: 'Last Name',
                    controller: controller.lastNameController,
                    border: InputBorder.none,
                    validator: Validations.validateName,
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16.sp,
                    ),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 16.sp,
                    ),
                    prefixIcon: SvgIcon(
                      imagePath: ImagePath.personSvg,
                      width: 17.w,
                      height: 17.h,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextfield(
                    hintText: 'Username',
                    controller: controller.usernameController,
                    border: InputBorder.none,
                    validator: Validations.validateName,
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16.sp,
                    ),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 16.sp,
                    ),
                    prefixIcon: SvgIcon(
                      imagePath: ImagePath.personSvg,
                      width: 17.w,
                      height: 17.h,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextfield(
                    hintText: 'Email',
                    controller: controller.emailController,
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16.sp,
                    ),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 16.sp,
                    ),
                    validator: Validations.validateEmail,
                    prefixIcon: const SvgIcon(
                      imagePath: ImagePath.emailSvg,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(
                    () => CustomTextfield(
                      obscureText: controller.isShowPassword.value,
                      controller: controller.passwordController,
                      hintText: 'Password',
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                      ),
                      textStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                      ),
                      validator: Validations.validatePassword,
                      prefixIcon: const SvgIcon(
                        imagePath: ImagePath.passwordSvg,
                      ),
                      onTapSuffix: controller.togglePasswordVisibility,
                      suffixIcon: SvgIcon(
                        imagePath: controller.isShowPassword.value
                            ? ImagePath.showPasswordSvg
                            : ImagePath.hidePasswordSvg,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(
                    () => CustomTextfield(
                      obscureText: controller.isShowConfirmPassword.value,
                      controller: controller.confirmPasswordController,
                      hintText: 'Confirm Password',
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                      ),
                      textStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your confirm password';
                        } else if (val != controller.passwordController.text) {
                          return 'Passwords does not match';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: const SvgIcon(
                        imagePath: ImagePath.passwordSvg,
                      ),
                      onTapSuffix: controller.toggleConfirmPasswordVisibility,
                      suffixIcon: SvgIcon(
                        imagePath: controller.isShowConfirmPassword.value
                            ? ImagePath.showPasswordSvg
                            : ImagePath.hidePasswordSvg,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  GetBuilder<AuthController>(builder: (authController) {
                    return CustomButton(
                      loading: authController.isLoading,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          // Register woo api call
                          controller.registerWoo(authController);
                        }
                      },
                      btnText: 'Next',
                    );
                  }),
                  SizedBox(
                    height: 30.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: GoogleFonts.poppins(
                                color: AppColors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.15,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign In Now',
                              style: GoogleFonts.poppins(
                                color: AppColors.primaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
