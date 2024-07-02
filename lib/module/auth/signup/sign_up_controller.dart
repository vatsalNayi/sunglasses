import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/custom_widgets/show_snackbar.dart';
import 'package:sunglasses/models/signup_body.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';

class SignupController extends GetxController {
  // SignupRepository signupRepository = SignupRepository();
  RxBool isShowPassword = true.obs;
  RxBool isShowConfirmPassword = true.obs;
  RxBool isLoadingPhoneVerify = false.obs;

  togglePasswordVisibility() {
    isShowPassword.value = !isShowPassword.value;
  }

  toggleConfirmPasswordVisibility() {
    isShowConfirmPassword.value = !isShowConfirmPassword.value;
    debugPrint('toggle pass value: ${isShowConfirmPassword.value.toString()}');
  }

  var loader = false.obs;
  bool get getLoader => loader.value;
  set setLoader(bool val) => loader.value = val;
  RxString? selectedDate = ''.obs;

  RxBool isVisibleDateError = false.obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Woo register
  void registerWoo(
    AuthController authController,
  ) async {
    String _firstName = firstNameController.text.trim();
    String _lastName = lastNameController.text.trim();
    String _username = usernameController.text.trim();
    String _email = emailController.text.trim();
    String _password = passwordController.text.trim();
    String _confirmPassword = confirmPasswordController.text.trim();

    // if (authController.acceptTerms == false) {
    //   showSnackbar(title: 'Message', message: 'please_agree_with'.tr);
    // } else
    if (_firstName.isEmpty) {
      // showCustomSnackBar('enter_your_first_name'.tr);
      showSnackbar(title: 'Message', message: 'enter_your_first_name'.tr);
    } else if (_lastName.isEmpty) {
      // showCustomSnackBar('enter_your_last_name'.tr);
      showSnackbar(title: 'Message', message: 'enter_your_last_name'.tr);
    } else if (_username.isEmpty) {
      // showCustomSnackBar('enter_your_username'.tr);
      showSnackbar(title: 'Message', message: 'enter_your_username'.tr);
    } else if (_email.isEmpty) {
      // showCustomSnackBar('enter_email_address'.tr);
      showSnackbar(title: 'Message', message: 'enter_email_address'.tr);
    } else if (!GetUtils.isEmail(_email)) {
      // showCustomSnackBar('enter_a_valid_email_address'.tr);
      showSnackbar(title: 'Message', message: 'enter_a_valid_email_address'.tr);
    } else if (_password.isEmpty) {
      // showCustomSnackBar('enter_password'.tr);
      showSnackbar(title: 'Message', message: 'enter_password'.tr);
    } else if (_password.length < 6) {
      // showCustomSnackBar('password_should_be'.tr);
      showSnackbar(title: 'Message', message: 'password_should_be'.tr);
    } else if (_password != _confirmPassword) {
      // showCustomSnackBar('confirm_password_does_not_matched'.tr);
      showSnackbar(
          title: 'Message', message: 'confirm_password_does_not_matched'.tr);
    } else {
      debugPrint('authController.registration called');
      authController.registration(SignUpBody(
        firstName: _firstName,
        lastName: _lastName,
        email: _email,
        password: _password,
        username: _username,
      ));
    }
  }
}
