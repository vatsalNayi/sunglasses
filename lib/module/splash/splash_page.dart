import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/controller/config_controller.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/module/address/location_controller.dart';
import 'package:sunglasses/module/cart/cart_controller.dart';
import 'package:sunglasses/module/home/products/controller/product_controller.dart';
import 'package:sunglasses/module/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    int count = 0;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      count += 1;
      if (count >= 2) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;

        isNotConnected
            ? const SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   backgroundColor: isNotConnected
        //       ? Colors.red
        //       : const Color.fromARGB(255, 69, 134, 71),
        //   duration: Duration(seconds: isNotConnected ? 6000 : 3),
        //   content: Text(
        //     isNotConnected ? 'no_connection'.tr : 'connected'.tr,
        //     textAlign: TextAlign.center,
        //   ),
        // ));
        if (!isNotConnected) {
          Get.find<ConfigController>().getGeneralSettings();
          Get.find<ConfigController>().getTaxClasses();
        }
      }
    });
    Get.find<ConfigController>().initSharedData();
    Get.find<CartController>().getCartList();
    Get.find<ConfigController>().getTaxSettings();
    Get.find<ConfigController>().getTaxClasses();
    Get.find<CartController>().initList();
    Get.find<LocationController>().initList();
    Get.find<ProductController>().initDynamicLinks();

    SplashController().redirectToDestination();
    super.initState();
  }

  @override
  void dispose() {
    _onConnectivityChanged.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImagePath.splashBg,
            height: Get.height,
            width: Get.width,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   ImagePath.groceryLogo,
                //   width: 201.91.w,
                //   height: 134.71.h,
                // ),
                // SizedBox(
                //   height: 40.h,
                // ),
                // Text(
                //   'VEGANMARKET',
                //   style: GoogleFonts.montserrat(
                //     fontSize: 36,
                //     fontWeight: FontWeight.w700,
                //     fontStyle: FontStyle.italic,
                //   ),
                // ),
                // Text(
                //   'SUPERMARKET TAGLINE',
                //   style: GoogleFonts.montserrat(
                //     fontSize: 18.sp,
                //     fontStyle: FontStyle.italic,
                //     fontWeight: FontWeight.w700,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
