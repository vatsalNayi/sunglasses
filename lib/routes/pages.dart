import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/models/address_model.dart';
import 'package:sunglasses/models/cart_model.dart';
import 'package:sunglasses/models/category_model.dart';
import 'package:sunglasses/models/order_model.dart';
import 'package:sunglasses/models/product_model.dart';
import 'package:sunglasses/module/address/add_address_screen.dart';
import 'package:sunglasses/module/address/saved_address_screen.dart';
import 'package:sunglasses/module/auth/forgot_password/forgot_pass_page.dart';
import 'package:sunglasses/module/auth/forgot_password/new_pass_page.dart';
import 'package:sunglasses/module/auth/forgot_password/verification_page.dart';
import 'package:sunglasses/module/auth/login/login_page.dart';
import 'package:sunglasses/module/auth/signup/sign_up_page.dart';
import 'package:sunglasses/module/cart/cart_page.dart';
import 'package:sunglasses/module/categories/categories_product_page.dart';
import 'package:sunglasses/module/checkout/order_successful_screen.dart';
import 'package:sunglasses/module/checkout/payment_web_screen.dart';
import 'package:sunglasses/module/dashboard/dashboard_page.dart';
import 'package:sunglasses/module/more/profile/widgets/update_profile_screen.dart';
import 'package:sunglasses/module/more/profile/widgets/view_profile_screen.dart';
import 'package:sunglasses/module/more/settings/settings_screen.dart';
import 'package:sunglasses/module/notification/notification_screen.dart';
import 'package:sunglasses/module/notification/notification_view_screen.dart';
import 'package:sunglasses/module/order/order_details_screen.dart';
import 'package:sunglasses/module/order/order_screen.dart';
import 'package:sunglasses/module/order/order_tracking_screen.dart';
import 'package:sunglasses/module/product_details/product_details.dart';
import 'package:sunglasses/module/review/write_review_screen.dart';
import 'package:sunglasses/module/search/search_screen.dart';
import 'package:sunglasses/module/splash/splash_page.dart';
import 'package:sunglasses/welcome/welcome_page.dart';
part './routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.initial,
      page: () => const SplashPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.loginPage,
      page: () => LoginPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.welcomePage,
      page: () => const WelcomePage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.signUpPage,
      page: () => SignUpPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.dashboardPage,
      page: () => const DashboardPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.productDetails,
      page: () => ProductDetails(
        product: ProductModel(id: int.parse(Get.parameters['id']!)),
        url: Get.parameters['url'],
        formSplash: Get.parameters['formSplash'] == 'true',
      ),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
        name: Routes.cart,
        page: () {
          //cartModel
          CartModel? _cartModel;
          if (Get.parameters['cartModel'] != 'null') {
            _cartModel = CartModel.fromJson(jsonDecode(utf8.decode(base64Decode(
                Get.parameters['cartModel']!.replaceAll(' ', '+')))));
          }

          debugPrint("From Order: ${Get.parameters['fromOrder'] == 'true'}");

          return CartPage(
              fromNav: false,
              cartModel: _cartModel,
              fromOrder: Get.parameters['fromOrder'] == 'true');
        }),
    GetPage(
      name: Routes.categoryProduct,
      page: () {
        List<int> _decode =
            base64Decode(Get.parameters['data']!.replaceAll(' ', '+'));
        CategoryModel _data =
            CategoryModel.fromJson(jsonDecode(utf8.decode(_decode)));
        return CategoryProductPage(category: _data);
      },
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
        name: Routes.writeReview,
        page: () {
          return WriteReviewScreen(
            // lineItems: Get.parameters['item'] != 'null' ? ProductModel.fromJson(jsonDecode(utf8.decode(base64Url.decode( Get.parameters['item'] )))) : null,
            productId: int.parse(Get.parameters['product_id']!),
          );
        }),
    GetPage(name: Routes.savedAddress, page: () => const SavedAddressScreen()),
    GetPage(
        name: Routes.addAddress,
        page: () {
          return AddAddressScreen(
            address: Get.parameters['address'] != 'null'
                ? AddressModel.fromJson(jsonDecode(
                    utf8.decode(base64Url.decode(Get.parameters['address']!))))
                : null,
            index: Get.parameters['index'] != 'null'
                ? int.parse(Get.parameters['index']!)
                : null,
          );
        }),
    GetPage(
        name: Routes.orderDetails,
        page: () {
          return Get.arguments ??
              OrderDetailsScreen(
                  orderModel:
                      OrderModel(id: int.parse(Get.parameters['id'] ?? '0')),
                  guestOrder: Get.parameters['guest'] != null
                      ? Get.parameters['guest'] == 'true'
                      : false);
        }),
    GetPage(
        name: Routes.orderSuccess,
        page: () => OrderSuccessfulScreen(
              orderID: Get.parameters['id'],
              success: Get.parameters['success'] == 'true',
              orderNow: Get.parameters['order_now'] == 'true',
            )),
    GetPage(
        name: Routes.orderTracking,
        page: () => OrderTrackingScreen(
              orderId: int.parse(Get.parameters['id'].toString()),
              order: OrderModel.fromJson(jsonDecode(
                  utf8.decode(base64Url.decode(Get.parameters['order']!)))),
            )),
    GetPage(name: Routes.search, page: () => const SearchScreen()),
    GetPage(
      name: Routes.orders,
      page: () => OrderScreen(
        formMenu: Get.parameters['fromMenu'] == null
            ? false
            : Get.parameters['fromMenu'] == 'true'
                ? true
                : false,
      ),
    ),
    GetPage(name: Routes.updateProfile, page: () => UpdateProfileScreen()),
    GetPage(name: Routes.profile, page: () => ViewProfileScreen()),
    GetPage(name: Routes.settings, page: () => const SettingsScreen()),
    GetPage(
        name: Routes.instaMojoWebPaymentScreen,
        page: () => InstamojoWebPayment(url: Get.parameters['url'] ?? '')),
    GetPage(name: Routes.forgotPassword, page: () => ForgotPassPage()),
    GetPage(
        name: Routes.verification,
        page: () {
          List<int> decode =
              base64Decode(Get.parameters['pass']!.replaceAll(' ', '+'));
          String data = utf8.decode(decode);
          return VerificationPage(
            number: Get.parameters['number'],
            fromSignUp: Get.parameters['page'] == Routes.signUpPage,
            token: Get.parameters['token'],
            password: data,
          );
        }),
    GetPage(
        name: Routes.resetPassword,
        page: () => NewPassPage(
              resetToken: Get.parameters['token'],
              number: Get.parameters['phone'],
              fromPasswordChange: Get.parameters['page'] == 'password-change',
            )),
    GetPage(name: Routes.notification, page: () => NotificationScreen()),
    GetPage(
        name: Routes.notificationView,
        page: () {
          log('${Get.parameters['from']}');
          debugPrint('route---------');
          return NotificationViewScreen(
              form: Get.parameters['from'],
              fromNotification: Get.parameters['fromNotification'] == 'true');
        }),
  ];
}
