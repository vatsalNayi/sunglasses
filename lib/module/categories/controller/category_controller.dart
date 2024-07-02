import 'dart:developer';
import 'package:get/get.dart';
import 'package:sunglasses/custom_widgets/custom_loader.dart';
import 'package:sunglasses/data/services/api_checker.dart';
import 'package:sunglasses/models/category_model.dart';
import 'package:sunglasses/models/product_model.dart';
import '../../../../routes/pages.dart';
import '../repository/category_repository.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;
  CategoryController({required this.categoryRepo});

  List<CategoryModel>? _categoryList;
  List<CategoryModel>? _subCategoryList = [];
  List<ProductModel>? _categoryProductList;
  List<ProductModel>? _searchProductList = [];
  List<int> _noSubCategoriesIDsList = [];
  bool _isLoading = false;
  bool _isSearching = false;
  int _subCategoryIndex = 0;
  String _searchText = '';
  String _prodResultText = '';
  int _offset = 1;
  final RxInt _selectedMainCategory = 0.obs;
  final RxInt _selectedMainCategoryId = 0.obs;
  CategoryModel _selectedMainCategoryData = CategoryModel();

  List<CategoryModel>? get categoryList => _categoryList;
  List<CategoryModel>? get subCategoryList => _subCategoryList;
  List<int> get noSubCategoriesIDsList => _noSubCategoriesIDsList;
  List<ProductModel>? get categoryProductList => _categoryProductList;
  List<ProductModel>? get searchProductList => _searchProductList;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  int get subCategoryIndex => _subCategoryIndex;
  String get searchText => _searchText;
  String get prodResultText => _prodResultText;
  int get offset => _offset;
  int get selectedMainCategory => _selectedMainCategory.value;
  int get selectedMainCategoryId => _selectedMainCategoryId.value;
  CategoryModel get selectedMainCategoryData => _selectedMainCategoryData;
  set setSelectedMainCategory(int val) => _selectedMainCategory.value = val;
  set setSelectedMainCategoryId(int val) => _selectedMainCategoryId.value = val;
  int selectedParentCategory = -1;

  bool _isCatLoading = false;
  bool get getCatLoading => _isCatLoading;
  set setCatLoading(val) => _isCatLoading = val;

  Future<void> getCategoryList(bool reload, int offset) async {
    if (reload) {
      _categoryList = null;
      update();
    }
    // Get.dialog(const CustomLoader(), barrierDismissible: false);
    Response response = await categoryRepo.getCategoryList(offset);
    setCatLoading = true;
    if (response.statusCode == 200) {
      setCatLoading = false;
      if (offset == 1) {
        _categoryList = [];
      }
      response.body.forEach(
          (category) => _categoryList!.add(CategoryModel.fromJson(category)));
      categoryList!.sort((a, b) => a.menuOrder!.compareTo(b.menuOrder!));
      setSelectedMainCategoryId = categoryList!.first.id!;
      _selectedMainCategoryData = categoryList!.first;

      // Get.back();
    } else {
      // Get.back();
      setCatLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getSubCategoryList(CategoryModel categoryID,
      {bool isRecursion = false}) async {
    _subCategoryIndex = 0;
    _categoryProductList = null;
    Response response =
        await categoryRepo.getSubCategoryList(categoryID.id!.toString());
    if (response.statusCode == 200) {
      List<CategoryModel> loadedSubCategories = [];
      if (response.body.isEmpty) {
        log("Empty id is: $categoryID");
        _noSubCategoriesIDsList.add(categoryID.id!);
      }
      for (var item in response.body) {
        loadedSubCategories.add(CategoryModel.fromJson(item));
      }

      // if (!isRecursion && loadedSubCategories.isNotEmpty) {
      //   _subCategoryList!.add(CategoryModel(
      //       id: categoryID.id!,
      //       name: 'All'.tr,
      //       parent: categoryID.id!,
      //       menuOrder: 1000));
      // }
      _subCategoryList!.addAll(loadedSubCategories);
      for (var subCategories in loadedSubCategories) {
        // log('Getting Sub Categories of : ${subCategories.id.toString()}');
        await getSubCategoryList(subCategories, isRecursion: true);
      }
      if (loadedSubCategories.isNotEmpty) {
        _subCategoryList!.add(
          CategoryModel(
              id: categoryID.id!,
              name: '${categoryID.name!} / All'.tr,
              parent: categoryID.id!,
              menuOrder: 1000),
        );
      }
      List<CategoryModel> tempSubCategory = [];
      tempSubCategory.addAll(subCategoryList!);
      tempSubCategory = tempSubCategory
          .where((element) =>
              element.parent! == selectedMainCategoryId &&
              !noSubCategoriesIDsList.contains(element.id!))
          .toList();
      tempSubCategory.sort((a, b) => a.menuOrder!.compareTo(b.menuOrder!));
      if (tempSubCategory.isNotEmpty) {
        selectedParentCategory = tempSubCategory.first.id!;
        log('Id is: $selectedParentCategory');
      }
      if (!isRecursion) {
        Get.back();
      }
      if (subCategoryList != null && subCategoryList!.isEmpty) {
        Get.toNamed(
          Routes.getCategoryProductRoute(categoryID),
        );
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void getSubCategoriesAndProducts(
      {required int index, required CategoryModel data}) {
    Get.dialog(const CustomLoader(), barrierDismissible: false);
    _selectedMainCategoryData = data;
    subCategoryList?.clear();
    noSubCategoriesIDsList.clear();
    setSelectedMainCategory = index;
    setSelectedMainCategoryId = data.id!;
    getSubCategoryList(data);
  }

  // void getSubCategoryList(String categoryID) async {
  //   _subCategoryIndex = 0;
  //   _subCategoryList = null;
  //   _categoryProductList = null;
  //   Response response = await categoryRepo.getSubCategoryList(categoryID);
  //   if (response.statusCode == 200) {
  //     _subCategoryList = [];
  //     // _subCategoryList!.add(
  //     //     CategoryModel(id: int.parse(categoryID), name: 'all_category'.tr));
  //     response.body.forEach((category) =>
  //         _subCategoryList!.add(CategoryModel.fromJson(category)));
  //     getCategoryProductList(categoryID, 1, false);
  //     log('Sub Category are: ${subCategoryList?.length}');
  //     update();
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  // }

  void setSubCategoryIndex(int index, String categoryID) {
    _subCategoryIndex = index;
    getCategoryProductList(
        _subCategoryIndex == 0
            ? categoryID
            : _subCategoryList![index].id.toString(),
        1,
        true);
  }

  void getCategoryProductList(
      String categoryID, int offset, bool notify) async {
    _offset = offset;
    if (offset == 1) {
      if (notify) {
        update();
      }
      _categoryProductList = null;
    }
    Response response =
        await categoryRepo.getCategoryProductList(categoryID, offset);
    if (response.statusCode == 200) {
      if (offset == 1) {
        _categoryProductList = [];
      }
      response.body.forEach((product) {
        ProductModel _product = ProductModel.fromJson(product);
        if (_product.type != 'grouped') {
          _categoryProductList!.add(_product);
        }
      });
      log("Products List is: ${_categoryProductList}");

      _isLoading = false;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void searchData(String query, String categoryID, int offset) async {
    if (query.isNotEmpty && query != _prodResultText) {
      _searchText = query;
      if (offset == 1) {
        _searchProductList = null;
        _isSearching = true;
      }
      update();

      Response response =
          await categoryRepo.getSearchData(query, categoryID, offset);
      if (response.statusCode == 200) {
        if (query.isEmpty) {
          _searchProductList = [];
        } else {
          if (offset == 1) {
            _prodResultText = query;
            _searchProductList = [];
          }
          response.body.forEach((product) {
            ProductModel _product = ProductModel.fromJson(product);
            if (_product.type != 'grouped') {
              _searchProductList!.add(_product);
            }
          });
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void toggleSearch() {
    _isSearching = !_isSearching;
    _searchProductList = [];
    if (_categoryProductList != null) {
      _searchProductList!.addAll(_categoryProductList!);
    }
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }
}
