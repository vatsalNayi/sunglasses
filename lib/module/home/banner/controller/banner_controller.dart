import 'dart:developer';
import 'package:get/get.dart';
import 'package:sunglasses/data/services/api_checker.dart';
import 'package:sunglasses/models/banner_model.dart';
import 'package:sunglasses/module/home/banner/repository/banner_repo.dart';

class BannerController extends GetxController implements GetxService {
  final BannerRepo bannerRepo;
  BannerController({required this.bannerRepo});

  List<BannerModel> bannerList = [];
  bool _isSafeArea = false;
  bool get isSafeArea => _isSafeArea;
  // BannerModel bannerModel;

  bool _isBannerLoading = false;
  bool get getBannerLoading => _isBannerLoading;
  set setBannerLoading(val) => _isBannerLoading = val;

  Future<void> getBannerList() async {
    setBannerLoading = true;
    bannerList = [];
    Response response = await bannerRepo.getBannerList();
    log('Banner response: ${response.body}');
    if (response.statusCode == 200) {
      setBannerLoading = false;
      response.body.forEach((banner) {
        BannerModel bannerModel = BannerModel.fromJson(banner);
        if (bannerModel.bannerType == 'main') {
          bannerList.add(bannerModel);
        }
      });
    } else {
      setBannerLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  void setSafeAreaTrue() {
    _isSafeArea = true;
    update();
  }

  void setSafeAreaFalse() {
    _isSafeArea = false;
    update();
  }

  int currentIndex = 0;
  updateIndicatorIndex(index, reason) {
    currentIndex = index;
    update();
  }
}
