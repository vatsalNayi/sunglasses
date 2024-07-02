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
import 'package:sunglasses/custom_widgets/textfield_decoration.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:sunglasses/routes/pages.dart';

class ForgotPassPage extends StatefulWidget {
  ForgotPassPage();

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Forgot Password'.tr,
        leadingIcon: ImagePath.backLeftSvg,
        onTapLeading: () {
          Get.back();
        },
      ),
      body: SafeArea(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Image.asset(ImagePath.forgot, height: 220),

              Padding(
                padding: const EdgeInsets.all(30),
                child: Text('Please enter Email or Username'.tr,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center),
              ),
              customDecorationForTextfield(
                child: CustomTextfield(
                  hintText: 'Email / Username',
                  controller: _emailController,
                  inputType: TextInputType.text,
                  border: InputBorder.none,
                  // divider: false,
                ),
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              GetBuilder<AuthController>(
                builder: (authController) {
                  return CustomButton(
                    // radius: Dimensions.RADIUS_EXTRA_LARGE,
                    loading: authController.isLoading,
                    btnText: 'Next'.tr,
                    onPress: () {
                      // Get.toNamed(Routes.getVerificationRoute('_email', '', '', ''));
                      _forgetPass(_emailController.text);
                    },
                  );
                },
              ),

              // }),
            ],
          ),
        ),
      )),
    );
  }

  void _forgetPass(String userName) async {
    if (userName.isEmpty) {
      showCustomSnackBar('enter_email_or_username'.tr);
    } else {
      Response response =
          await Get.find<AuthController>().forgetPassword(userName);
      if (response.body['status'] == '200') {
        String? _email = response.body['email'];
        Get.toNamed(Routes.getVerificationRoute(_email, '', '', ''));
      } else {
        showCustomSnackBar('${'no_user_found_with'.tr} $userName');
      }
    }
  }
}
