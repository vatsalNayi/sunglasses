import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunglasses/controller/config_controller.dart';
import 'package:sunglasses/controller/language_controller.dart';
import 'package:sunglasses/controller/localization_controller.dart';
import 'package:sunglasses/controller/theme_controller.dart';
import 'package:sunglasses/core/utils/app_constants.dart';
import 'package:sunglasses/data/repository/config_repo.dart';
import 'package:sunglasses/data/repository/language_repo.dart';
import 'package:sunglasses/data/services/api_client.dart';
import 'package:sunglasses/data/services/instamojo_api_client.dart';
import 'package:sunglasses/models/language_model.dart';
import 'package:sunglasses/module/address/location_controller.dart';
import 'package:sunglasses/module/address/location_repo.dart';
import 'package:sunglasses/module/auth/auth_repo/auth_repo.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:sunglasses/module/cart/cart_controller.dart';
import 'package:sunglasses/module/cart/repository/cart_repo.dart';
import 'package:sunglasses/module/categories/controller/category_controller.dart';
import 'package:sunglasses/module/categories/repository/category_repository.dart';
import 'package:sunglasses/module/coupon/controller/coupon_controller.dart';
import 'package:sunglasses/module/coupon/repository/coupon_repo.dart';
import 'package:sunglasses/module/home/banner/controller/banner_controller.dart';
import 'package:sunglasses/module/home/banner/repository/banner_repo.dart';
import 'package:sunglasses/module/home/products/controller/product_controller.dart';
import 'package:sunglasses/module/home/products/repository/product_repo.dart';
import 'package:sunglasses/module/more/profile/profile_controller.dart';
import 'package:sunglasses/module/more/profile/profile_repository.dart';
import 'package:sunglasses/module/notification/controller/notification_controller.dart';
import 'package:sunglasses/module/notification/repository/notification_repo.dart';
import 'package:sunglasses/module/order/controller/order_controller.dart';
import 'package:sunglasses/module/order/repository/order_repo.dart';
import 'package:sunglasses/module/search/controller/search_controller.dart';
import 'package:sunglasses/module/search/repository/search_repo.dart';
import 'package:sunglasses/module/wishlist/controller/wish_controller.dart';
import 'package:sunglasses/module/wishlist/repository/wish_repo.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences);
  Get.put(ThemeController(sharedPreferences: sharedPreferences));
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.put(() => InstaMojoApiClient(
      appBaseUrl: AppConstants.INSTAMOJO_BASE_URL,
      sharedPreferences: Get.find()));

  /// Repository
  Get.lazyPut(
      () => ConfigRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => CartRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => CouponRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => ProfileRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => WishRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(
      () => SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => BannerRepo(apiClient: Get.find()));
  Get.lazyPut(() =>
      NotificationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ConfigController(configRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
  Get.lazyPut(() => CouponController(couponRepo: Get.find()));
  Get.lazyPut(() => ProfileController(profileRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => WishListController(
        wishRepo: Get.find(),
        sharedPreferences: Get.find(),
      ));
  Get.lazyPut(() => SearchController(searchRepo: Get.find()));

  Get.lazyPut(() => LocationController(
      locationRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => BannerController(bannerRepo: Get.find()));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for (LanguageModel? languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel!.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return _languages;
}
