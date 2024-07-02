import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/custom_widgets/show_snackbar.dart';
import 'package:sunglasses/data/services/api_checker.dart';
import 'package:sunglasses/models/response_model.dart';
import 'package:sunglasses/models/signup_body.dart';
import 'package:sunglasses/module/auth/auth_repo/auth_repo.dart';
import 'package:sunglasses/module/cart/cart_controller.dart';
import 'package:sunglasses/module/wishlist/controller/wish_controller.dart';
import 'package:sunglasses/routes/pages.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo}) {
    _notification = authRepo.isNotificationActive();
    _biometric = authRepo.isBiometricEnabled();
    //checkBiometricSupport();
  }

  bool isShowNewPassword = true;
  bool isShowNewConfirmPassword = true;
  toggleNewPasswordVisibility() {
    isShowNewPassword = !isShowNewPassword;
    update();
  }

  toggleNewConfirmPasswordVisibility() {
    isShowNewConfirmPassword = !isShowNewConfirmPassword;
    update();
  }

  bool _isLoading = false;

  bool _notification = true;
  bool _acceptTerms = true;
  bool? _biometric = true;
  bool _isBiometricSupported = false;

  bool get isLoading => _isLoading;
  bool get notification => _notification;
  bool get acceptTerms => _acceptTerms;
  bool? get biometric => _biometric;
  bool get isBiometricSupported => _isBiometricSupported;

  Future<ResponseModel?> registration(SignUpBody signUpBody) async {
    debugPrint('registration called from auth controller');
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    ResponseModel? responseModel;
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      // showCustomSnackBar('registration_successful_you_have_to_login_now'.tr, isError: false);
      await login(signUpBody.email, signUpBody.password);
      //Get.toNamed(RouteHelper.getSignInRoute());
      showSnackbar(title: 'Message', message: 'Register success');
    } else if (response.statusCode == 400 &&
        response.body['code'] == 'registration-error-email-exists') {
      // showCustomSnackBar('an_account_is_already'.tr);
      Get.snackbar('Message', 'an_account_is_already'.tr);
    } else {
      responseModel = ResponseModel(false, response.statusText);
      // showCustomSnackBar(response.statusText);
      Get.snackbar('Message', response.statusText.toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel?> login(String? username, String? password,
      {bool fromLogin = false}) async {
    _isLoading = true;
    update();
    Response response =
        await authRepo.login(username: username, password: password);
    ResponseModel? responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true,
          '${response.body['is_phone_verified']}${response.body['token']}');
      await getUserId();
      if (fromLogin) {
        if (_isActiveRememberMe) {
          saveUserEmailAndPassword(username!, password!);
        } else {
          clearUserNumberAndPassword();
        }
      }
      // Get.find<search.SearchController>().clearSearchAddress();

      Get.find<WishListController>().getWishList();
      Get.find<CartController>().getCartList();
      Get.offAllNamed(Routes.dashboardPage);
      // authenticateWithBiometric(response.body['token'], false);
    } else if (response.statusCode == 403 &&
        response.body['code'] == '[jwt_auth] incorrect_password') {
      showCustomSnackBar('the_password_you_entered'.tr);
    } else if (response.statusCode == 403 &&
        response.body['code'] == '[jwt_auth] invalid_username') {
      showCustomSnackBar('the_username_is_not_registered'.tr);
    } else if (response.statusCode == 403 &&
        response.body['code'] == '[jwt_auth] invalid_email') {
      showCustomSnackBar('unknown_email_address'.tr);
    } else {
      showCustomSnackBar(response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getUserId() async {
    print('--Get_User_ID--');
    Response response = await authRepo.getUserId();
    if (response.statusCode == 200) {
      authRepo.saveUserId(response.body['id']);
      // Get.find<ProfileController>().getUserInfo();
      await updateToken(response.body['id']);
      // Get.find<WishListController>().getWishList();
    }
  }

  int? getSavedUserId() {
    int? _savedUserId;
    _savedUserId = authRepo.getSavedUserId();
    return _savedUserId;
  }

  Future<void> updateToken(int? id) async {
    print('--Set_User_Token--');
    Response? apiResponse = await authRepo.updateToken(id.toString());
    if (apiResponse.statusCode == 200) {
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  Future<void> deleteToken() async {
    _isLoading = true;
    update();
    Response apiResponse =
        await authRepo.deleteFcmToken(getSavedUserId().toString());
    _isLoading = false;
    update();
    if (apiResponse.statusCode == 200) {
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  void setRememberMe() {
    _isActiveRememberMe = true;
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  void saveUserEmailAndPassword(String email, String password) {
    authRepo.saveUserEmailAndPassword(email, password);
  }

  String? getUserEmail() {
    return authRepo.getUserEmail();
  }

  String? getUserPassword() {
    return authRepo.getUserPassword();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  int getUserID() {
    return authRepo.getUserID();
  }

  bool setNotificationActive(bool isActive) {
    _notification = isActive;
    authRepo.setNotificationActive(isActive);
    update();
    return _notification;
  }

  bool? setBiometric(bool isActive) {
    _biometric = isActive;
    authRepo.setBiometric(isActive);
    update();
    return _biometric;
  }

  bool? setIsWelcomed(bool setIsWelcomed) {
    // _biometric = isActive;
    authRepo.setIsWelcomed(setIsWelcomed);
    update();
    return _biometric;
  }

  getIsWelcomed() {
    return authRepo.isWelcomed();
  }

  // Future<void> authenticateWithBiometric(String token, bool autoLogin) async {
  //   final LocalAuthentication _bioAuth = LocalAuthentication();
  //   if((await _bioAuth.canCheckBiometrics || await _bioAuth.isDeviceSupported()) && authRepo.isBiometricEnabled()) {
  //     final List<BiometricType> _availableBiometrics = await _bioAuth.getAvailableBiometrics();
  //     if (_availableBiometrics.isNotEmpty && (!autoLogin || authRepo.getBiometricToken() != null)) {
  //       try {
  //         final bool _didAuthenticate = await _bioAuth.authenticate(
  //           localizedReason: autoLogin ? 'please_authenticate_to_login'.tr : 'please_authenticate_to_easy_access_for_next_time'.tr,
  //           options: AuthenticationOptions(stickyAuth: true),
  //         );
  //         if(_didAuthenticate) {
  //           if(autoLogin) {
  //             authRepo.autoLogin(authRepo.getBiometricToken());
  //           }else {
  //             authRepo.saveBiometricToken(token);
  //           }
  //         }
  //       } catch(e) {}
  //     }
  //   }
  // }

  // void checkBiometricSupport() async {
  //   final LocalAuthentication _bioAuth = LocalAuthentication();
  //   _isBiometricSupported = await _bioAuth.canCheckBiometrics || await _bioAuth.isDeviceSupported();
  // }

  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }

  Future<Response> forgetPassword(String email) async {
    _isLoading = true;
    update();
    Response response = await authRepo.forgetPassword(email);

    _isLoading = false;
    update();
    return response;
  }

  Future<Response> verifyEmail(String? email, String otp) async {
    _isLoading = true;
    update();
    Response response = await authRepo.verifyEmail(email, otp);
    print(response.body);

    _isLoading = false;
    update();
    return response;
  }

  Future<Response> resetPassword(
      String? otp, String? userName, String password) async {
    _isLoading = true;
    update();

    Response response = await authRepo.resetPassword(userName, otp, password);
    _isLoading = false;
    update();
    return response;
  }
}
