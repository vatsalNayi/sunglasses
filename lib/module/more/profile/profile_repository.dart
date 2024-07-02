import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/app_constants.dart';
import '../../../data/services/api_client.dart';
import '../../../models/address_model.dart';
import '../../../models/profile_model.dart';

class ProfileRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ProfileRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.PROFILE_URI +
        sharedPreferences.getInt(AppConstants.USER_ID).toString());
  }

  Future<Response> updateProfile(ProfileModel profile) async {
    return await apiClient.putData(
        AppConstants.UPDATE_PROFILE_URI +
            sharedPreferences.getInt(AppConstants.USER_ID).toString(),
        profile.toJson());
  }

  Future<Response> updateAvatar(XFile? avatar) async {
    final token = sharedPreferences.getString(AppConstants.TOKEN);
    return await apiClient.postMultipartData(AppConstants.UPDATE_AVATAR_URI,
        {'_method': 'put'}, [MultipartBody('image', avatar)],
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        apiVersion: WooApiVersion.noWooApi);
  }

  Future<Response> deleteUser() async {
    return await apiClient.deleteData(
      '${AppConstants.DELETE_PROFILE_URI}${sharedPreferences.getInt(AppConstants.USER_ID)}?force=true',
    );
  }

  void setBillingAddress(AddressModel? billingAddress) {
    if (billingAddress == null &&
        sharedPreferences.containsKey(AppConstants.BILLING_ADDRESS)) {
      sharedPreferences.remove(AppConstants.BILLING_ADDRESS);
    } else {
      sharedPreferences.setString(
          AppConstants.BILLING_ADDRESS, jsonEncode(billingAddress!.toJson()));
    }
  }

  void setShippingAddress(AddressModel? shippingAddress) {
    if (shippingAddress == null &&
        sharedPreferences.containsKey(AppConstants.SHIPPING_ADDRESS)) {
      sharedPreferences.remove(AppConstants.SHIPPING_ADDRESS);
    } else {
      sharedPreferences.setString(
          AppConstants.SHIPPING_ADDRESS, jsonEncode(shippingAddress!.toJson()));
    }
  }

  AddressModel? getBillingAddress() {
    if (sharedPreferences.containsKey(AppConstants.BILLING_ADDRESS)) {
      return AddressModel.fromJson(jsonDecode(
          sharedPreferences.getString(AppConstants.BILLING_ADDRESS)!));
    } else {
      return null;
    }
  }

  AddressModel? getShippingAddress() {
    if (sharedPreferences.containsKey(AppConstants.SHIPPING_ADDRESS)) {
      return AddressModel.fromJson(jsonDecode(
          sharedPreferences.getString(AppConstants.SHIPPING_ADDRESS)!));
    } else {
      return null;
    }
  }

  Future<Response> updateAddress(
      ProfileAddressModel address, bool isShipping) async {
    return await apiClient.putData(
      AppConstants.UPDATE_PROFILE_URI +
          sharedPreferences.getInt(AppConstants.USER_ID).toString(),
      {isShipping ? 'shipping' : 'billing': address},
    );
  }
}
