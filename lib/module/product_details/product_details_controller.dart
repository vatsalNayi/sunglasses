import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
// final MyRepository repository;
// ProductDetailsController(this.repository);

  final RxInt _currentPage = 0.obs;
  get getCurrentPage => _currentPage.value;
  set setCurrentPage(value) => _currentPage.value = value;

  onPageChanged(index) {
    setCurrentPage = index;
    update();
  }

  PageController pageController = PageController();
}
