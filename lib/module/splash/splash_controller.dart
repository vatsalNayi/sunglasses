import 'dart:async';
import 'package:get/get.dart';
import 'package:sunglasses/controller/config_controller.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:sunglasses/routes/pages.dart';

class SplashController extends GetxController {
  void redirectToDestination() async {
    Future.delayed(const Duration(seconds: 3), () async {
      await Get.find<ConfigController>().getGeneralSettings();
      await Get.find<ConfigController>().getTaxSettings();
      Get.find<ConfigController>().getTaxClasses();

      if (Get.find<AuthController>().getIsWelcomed() != null &&
          Get.find<AuthController>().getIsWelcomed()) {
        Get.offAllNamed(Routes.dashboardPage);
      } else {
        Get.offAllNamed(Routes.welcomePage);
      }
    });
  }
}
