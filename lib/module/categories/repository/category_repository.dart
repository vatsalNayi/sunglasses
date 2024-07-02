import 'package:get/get_connect/http/src/response/response.dart';
import 'package:sunglasses/core/utils/app_constants.dart';
import 'package:sunglasses/data/services/api_client.dart';

class CategoryRepo {
  final ApiClient apiClient;
  CategoryRepo({required this.apiClient});

  Future<Response> getCategoryList(int offset) async {
    return await apiClient
        .getData(AppConstants.CATEGORY_URI + offset.toString());
  }

  Future<Response> getSubCategoryList(String parentID) async {
    return await apiClient.getData('${AppConstants.SUB_CATEGORY_URI}$parentID');
  }

  Future<Response> getCategoryProductList(String categoryID, int offset) async {
    return await apiClient.getData(
        '${AppConstants.CATEGORY_PRODUCT_URI}$categoryID&per_page=${AppConstants.PAGINATION_LIMIT}&page=$offset');
  }

  Future<Response> getSearchData(
      String query, String categoryID, int offset) async {
    return await apiClient.getData(
      '${AppConstants.CATEGORY_PRODUCT_URI}$categoryID&search=$query&page=$offset&per_page=${AppConstants.PAGINATION_LIMIT}',
    );
  }
}
