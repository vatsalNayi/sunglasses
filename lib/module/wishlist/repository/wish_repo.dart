import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:sunglasses/core/utils/app_constants.dart';
import 'package:sunglasses/data/services/api_client.dart';
import 'package:sunglasses/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishRepo {
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  WishRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getWishToken(int userId) async {
    return await apiClient
        .getData(AppConstants.WISH_TOKEN_URI + userId.toString());
  }

  Future<Response> getWishList(String wishToken) async {
    return await apiClient
        .getData('/wishlist/$wishToken${AppConstants.WISHLIST_URI}');
  }

  Future<Response> addWish(Map<String, String> body, String wishToken) async {
    return await apiClient.postData(
        '/wishlist/$wishToken${AppConstants.ADD_WISH_URI}', body);
  }

  Future<Response> removeWish(int itemID) async {
    return await apiClient
        .getData('/wishlist${AppConstants.REMOVE_WISH_URI}$itemID');
  }

  void addToLocalWish(List<WishedModel> wishProductList) {
    List<String> wishes = [];
    wishProductList
        .forEach((wishModel) => wishes.add(jsonEncode(wishModel.toJson())));
    sharedPreferences.setStringList(AppConstants.WISH_LIST, wishes);
  }

  List<WishedModel> getLocalWishList() {
    List<String>? wishLists = [];
    if (sharedPreferences.containsKey(AppConstants.WISH_LIST)) {
      wishLists = sharedPreferences.getStringList(AppConstants.WISH_LIST);
    }
    List<WishedModel> wishList = [];
    wishLists!.forEach(
        (wish) => wishList.add(WishedModel.fromJson(jsonDecode(wish))));
    return wishList;
  }
}
