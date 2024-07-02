import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/app_constants.dart';
import '../../models/address_model.dart';

class LocationRepo {
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.sharedPreferences});

  // Future<bool> saveUserAddress(String address, List<int> zoneIDs) async {
  //   apiClient!.updateHeader(
  //     sharedPreferences!.getString(AppConstants.LANGUAGE_CODE),
  //   );
  //   return await sharedPreferences!.setString(AppConstants.USER_ADDRESS, address);
  // }
  //
  //
  // String? getUserAddress() {
  //   return sharedPreferences!.getString(AppConstants.USER_ADDRESS);
  // }

  List<AddressModel> getAddressList() {
    List<String>? address = [];
    if (sharedPreferences.containsKey(AppConstants.ADDRESS_LIST)) {
      address = sharedPreferences.getStringList(AppConstants.ADDRESS_LIST);
    }
    List<AddressModel> addressList = [];
    address!.forEach((address) =>
        addressList.add(AddressModel.fromJson(jsonDecode(address))));
    return addressList;
  }

  Future<void> addAddress(List<AddressModel> allAddressList) async {
    List<String> address = [];
    allAddressList
        .forEach((addressModel) => address.add(jsonEncode(addressModel)));
    sharedPreferences.setStringList(AppConstants.ADDRESS_LIST, address);
  }
}
