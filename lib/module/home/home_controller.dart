import 'package:get/get.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:sunglasses/module/categories/controller/category_controller.dart';
import 'package:sunglasses/module/home/banner/controller/banner_controller.dart';
import 'package:sunglasses/module/home/products/controller/product_controller.dart';
import 'package:sunglasses/module/more/profile/profile_controller.dart';
import 'package:sunglasses/module/wishlist/controller/wish_controller.dart';

class HomeController extends GetxController {
  var paymentStatusRes = {}.obs;
  Map<dynamic, dynamic> get getPaymentStatusRes => paymentStatusRes;
  set setPaymemtStatusRes(Map<dynamic, dynamic> val) =>
      paymentStatusRes.value = val;

  @override
  void onInit() {
    loadData(false);
    super.onInit();
  }

  final RxInt _currentPage = 0.obs;
  get getCurrentPage => _currentPage.value;
  set setCurrentPage(value) => _currentPage.value = value;

  onPageChanged(index) {
    setCurrentPage = index;
    update();
  }

  void loadData(bool reload) {
    Get.find<WishListController>().getWishList();
    Get.find<CategoryController>().getCategoryList(reload, 1);
    Get.find<ProductController>().getProductList(1, reload);
    Get.find<ProductController>().getPopularProductList(reload, false, 1);
    Get.find<ProductController>().getSaleProductList(reload, false, 1);
    Get.find<ProductController>().getReviewedProductList(reload, false);
    Get.find<ProductController>().getGroupedProductList(reload, false, 1);
    Get.find<BannerController>().getBannerList();
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getUserInfo();
    }
    // Get categories list
    //
  }
}
