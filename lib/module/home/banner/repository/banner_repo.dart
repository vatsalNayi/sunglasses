import 'package:get/get_connect/http/src/response/response.dart';
import 'package:sunglasses/core/utils/app_constants.dart';
import 'package:sunglasses/data/services/api_client.dart';

class BannerRepo {
  final ApiClient apiClient;
  BannerRepo({required this.apiClient});

  Future<Response> getBannerList() async {
    return await apiClient.getData(AppConstants.BANNER,
        apiVersion: WooApiVersion.noWooApi);
  }
}
