import 'package:get/get.dart';
import 'package:sunglasses/custom_widgets/show_snackbar.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      // Get.offAllNamed(RouteHelper.getSignInRoute());
    } else {
      // showCustomSnackBar(response.statusText);
      showSnackbar(title: 'Message', message: response.statusText.toString());
    }
  }
}
