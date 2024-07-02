import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/custom_widgets/show_snackbar.dart';
import 'package:sunglasses/models/product_model.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/wish_model.dart';
import '../repository/wish_repo.dart';

class WishListController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  final WishRepo wishRepo;
  WishListController({required this.wishRepo, required this.sharedPreferences});

  List<WishModel>? _wishList;
  List<WishedModel> _wishListAll = [];
  List<ProductModel>? _wishProductList = [];
  List<int?> _removedSelectedId = [];
  String? token;
  late List<ProductModel> _tempWishProductList;
  late List<int?> _tempRemovedSelectedId;
  int _wishIndex = -1;
  // int userId;

  bool _isWished = false;
  bool get isWished => _isWished;
  List<WishModel>? get wishList => _wishList;
  List<ProductModel>? get wishProductList => _wishProductList;
  List<WishedModel> get wishListAll => _wishListAll;
  List<int?> get removedSelectedId => _removedSelectedId;
  int? productIndex;
  List<int?> wishIdList = [];

  Future<void> addProductToWishlist(ProductModel product) async {
    int? userId = Get.find<AuthController>().isLoggedIn()
        ? Get.find<AuthController>().getSavedUserId()
        : 0;
    if (wishIdList.contains(product.id)) {
      int index = wishIdList.indexOf(product.id);
      _wishProductList!.removeAt(index);
      _wishListAll[_wishIndex].wishedProductList = _wishProductList;
      wishRepo.addToLocalWish(_wishListAll);
      showCustomSnackBar('product_removed_to_wish_list'.tr);
    } else {
      if ((_wishIndex == -1) && _wishListAll.isEmpty ||
          _wishProductList!.isEmpty) {
        debugPrint('first time');
        _wishProductList!.add(product);
        _wishListAll.add(WishedModel(
          id: userId,
          wishedProductList: _wishProductList,
        ));
      } else {
        debugPrint('exist');
        _wishProductList!.add(product);
        debugPrint(_wishProductList!.length.toString());
        _wishListAll[_wishIndex].wishedProductList = _wishProductList;
      }
      wishRepo.addToLocalWish(_wishListAll);
      // wishRepo.addToLocalWish(_wishProductList);
      showCustomSnackBar('product_added_to_wish_list'.tr, isError: false);
    }
    getWishList();
    update();
  }

  Future<void> removeProductWishlist(int? wishProductIndex,
      {bool clearList = false}) async {
    if (wishProductIndex != null && wishProductIndex != -1) {
      _wishProductList!.removeAt(wishProductIndex);
      showCustomSnackBar('removed_form_wishlist_successfully'.tr,
          isError: false);
      _isWished = false;
      _wishListAll[_wishIndex].wishedProductList = _wishProductList;
      wishRepo.addToLocalWish(_wishListAll);
      //wishRepo.addToLocalWish(_wishProductList);

      getWishList();
      update();
    } else if (clearList) {
      _tempRemovedSelectedId = [];
      _tempWishProductList = [];
      _tempRemovedSelectedId.addAll(_removedSelectedId);
      _tempWishProductList.addAll(_wishProductList!);
      for (int i = 0; i < _tempRemovedSelectedId.length; i++) {
        for (int j = 0; j < _tempWishProductList.length; j++) {
          if (_tempRemovedSelectedId[i] == _tempWishProductList[j].id) {
            debugPrint(j.toString());
            debugPrint('length->${_wishProductList!.length}');
            _wishProductList!.remove(_tempWishProductList[j]);
          }
        }
      }
      _removedSelectedId = [];
      _wishListAll[_wishIndex].wishedProductList = _wishProductList;
      wishRepo.addToLocalWish(_wishListAll);
      // wishRepo.addToLocalWish(_wishProductList);
      update();
    }
  }

  Future<void> getWishList() async {
    int? userId = Get.find<AuthController>().isLoggedIn()
        ? Get.find<AuthController>().getSavedUserId()
        : 0;
    _wishProductList = [];
    wishIdList = [];
    _wishListAll = [];
    _wishListAll = wishRepo.getLocalWishList();
    _wishIndex = -1;
    for (int i = 0; i < _wishListAll.length; i++) {
      if (_wishListAll[i].id == userId) {
        _wishProductList = _wishListAll[i].wishedProductList;
        _wishIndex = i;
        break;
      }
    }
    // _wishProductList = wishRepo.getLocalWishList();

    for (int i = 0; i < _wishProductList!.length; i++) {
      wishIdList.add(_wishProductList![i].id);
    }
  }

  void setRemoveIndex(int index) {
    _removedSelectedId.add(index);
    update();
  }

  void removeSelectedRemoveIndex(int index) {
    _removedSelectedId.remove(index);
    update();
  }

  void setRemoveProductId(int? id) {
    _removedSelectedId.add(id);
    update();
  }

  void removeSelectedRemoveId(int? id) {
    _removedSelectedId.remove(id);
    update();
  }
}
