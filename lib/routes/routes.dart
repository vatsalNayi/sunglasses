part of './pages.dart';

class Routes {
  static const String initial = '/';
  static const String welcomePage = '/welcomePage';
  static const String loginPage = '/loginPage';
  static const String signUpPage = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerifyPage = '/otpVerifyPage';
  static const String resetPassword = '/reset-password';
  static const String dashboardPage = '/dashboardPage';
  static const String homePage = '/home';
  static const String productDetails = '/productDetails';
  static const String instamojoApi = '/instamojoApi';
  static const String instamojoSdkDemo = '/instamojoSdkDemo';
  static const String instamojoPaymentPage = '/instamojoPaymentPage';
  static const String addAddressPage = '/addAddressPage';
  static const String orderSummaryPage = '/orderSummaryPage';
  static const String paymentPage = '/paymentPage';
  static const String categoryProduct = '/category-product';
  static const String writeReview = '/write_review';
  static const String cart = '/cart';
  static const String coupon = '/coupon';
  static const String addAddress = '/add_address';
  static const String savedAddress = '/saved_address';
  static const String orderDetails = '/order-details';
  static const String orderSuccess = '/order-successful';
  static const String orderTracking = '/track-order';
  static const String search = '/search';
  static const String orders = '/orders';
  static const String updateProfile = '/update_profile';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String instaMojoWebPaymentScreen = '/instaMojoWebPaymentScreen';
  static const String verification = '/verification';
  static const String tempRounded = '/temp_rounded';
  static const String notification = '/notification';
  static const String notificationView = '/notification_view';

  static String getInitialRoute() => dashboardPage;

  static String getHomeRoute(String name) => '$homePage?name=$name';
  static String getOrdersRoute(bool? fromMenu) => '$orders?fromMenu=$fromMenu';
  static String getSignInRoute({String from = ''}) => '$loginPage?from=$from';
  static String getSignUpRoute() => signUpPage;

  static String getProductDetailsRoute(
    int? productID,
    String? url,
    bool formSplash,
  ) {
    return '$productDetails?id=$productID&url=$url&formSplash=${formSplash.toString()}';
  }

  static String getCategoryProductRoute(CategoryModel category) {
    String _data = base64Encode(utf8.encode(jsonEncode(category.toJson())));
    return '$categoryProduct?data=$_data';
  }

  static String getCartRoute({CartModel? cartModel, bool fromOrder = false}) {
    String? _cartModel;
    if (cartModel != null) {
      print('-------${cartModel.toString()}');
      _cartModel = base64Encode(utf8.encode(jsonEncode(cartModel.toJson())));
    }
    debugPrint("From Order: $fromOrder");
    return '$cart?cartModel=$_cartModel&fromOrder=${fromOrder.toString()}';
  }

  static String getWriteReviewRoute(int? productId) {
    // String _item;
    // if(item != null) {
    //   _item = base64Encode(utf8.encode(jsonEncode(item.toJson())));
    // }
    return '$writeReview?product_id=$productId';
  }

  // static String getCouponRoute(bool formCart) =>
  //     '$coupon?formCart=${formCart.toString()}';

  static String getSavedAddressRoute() => savedAddress;
  static String getAddAddressRoute(AddressModel? address, int index) {
    String? _address;
    if (address != null) {
      _address = base64Encode(utf8.encode(jsonEncode(address.toJson())));
    }
    return '$addAddress?address=$_address&index=$index';
  }

  static String getProfileRoute() => profile;
  static String getEditProfileRoute() => updateProfile;
  static String getSettingsRoute() => settings;

  static String getOrderDetailsRoute(int? orderID, {bool guestMode = false}) {
    return '$orderDetails?id=$orderID&guest=$guestMode';
  }

  static String getOrderSuccessRoute(
      int? orderID, bool success, bool orderNow) {
    return '$orderSuccess?id=$orderID&success=${success ? 'true' : 'false'}&order_now=${orderNow ? 'true' : 'false'}';
  }

  static String getOrderTrackingRoute(OrderModel order) {
    String _data = base64Encode(utf8.encode(jsonEncode(order.toJson())));
    return '$orderTracking?order=$_data';
  }

  static String getSearchRoute() => search;

  static String getInstaMojoWebPaymentScreen(String url) {
    return '$instaMojoWebPaymentScreen?url=$url';
  }

  static String getForgotPassRoute() {
    return '$forgotPassword?page=';
  }

  static String getVerificationRoute(
      String? number, String token, String page, String pass) {
    return '$verification?page=$page&number=$number&token=$token&pass=$pass';
  }

  static String getResetPasswordRoute(
          String? phone, String token, String page) =>
      '$resetPassword?phone=$phone&token=$token&page=$page';

  static String getNotificationRoute() => notification;
  static String notificationViewRoute(String from,
          {bool fromNotification = false}) =>
      '$notificationView?from=$from&fromNotification=$fromNotification';
}
