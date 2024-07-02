import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/custom_widgets/show_snackbar.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';

class LoginController extends GetxController {
  // LoginRepository loginRepository = LoginRepository();
  TextEditingController usernameEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isShowPassword = true.obs;

  togglePasswordVisibility() {
    isShowPassword.value = !isShowPassword.value;
  }

  var loader = false.obs;
  bool get getLoader => loader.value;
  set setLoader(bool val) => loader.value = val;

  RxBool isLoadingPhoneVerify = false.obs;
  int? _resendToken;

  /// Login woo
  void loginWoo(AuthController authController) async {
    String _email = usernameEmailController.text.trim();
    String _password = passwordController.text.trim();
    if (_email.isEmpty) {
      showCustomSnackBar('enter_username_or_email'.tr);
    }
    // else if (_email.contains('@') && !GetUtils.isEmail(_email)) {
    //   showCustomSnackBar('invalid_email_address'.tr);
    // }
    else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    } else {
      authController.login(_email, _password, fromLogin: true);
    }
  }
}
