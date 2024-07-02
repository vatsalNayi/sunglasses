import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/custom_widgets/paginated_list_view.dart';
import 'package:sunglasses/custom_widgets/product_view.dart';
import 'package:sunglasses/models/category_model.dart';
import 'package:sunglasses/models/product_model.dart';
import 'controller/category_controller.dart';

class CategoryProductPage extends StatefulWidget {
  final CategoryModel category;
  const CategoryProductPage({super.key, required this.category});

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  final ScrollController scrollController = ScrollController();
  final ScrollController restaurantScrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    log("Category Product Page");
    log(widget.category.id.toString());

    Get.find<CategoryController>()
        .getCategoryProductList(widget.category.id.toString(), 1, false);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (catController) {
        List<ProductModel>? _products;
        if (catController.categoryProductList != null &&
            catController.searchProductList != null) {
          _products = [];
          if (catController.isSearching) {
            _products.addAll(catController.searchProductList!);
          } else {
            _products.addAll(catController.categoryProductList!);
          }
        }
        return PopScope(
          canPop: catController.isSearching ? false : true,
          onPopInvoked: (_) {
            if (catController.isSearching) {
              catController.toggleSearch();
            } else {}
          },
          child: Scaffold(
            appBar: AppBar(
              title: catController.isSearching
                  ? TextField(
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: 'Search...'.tr,
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.poppins(
                        color: AppColors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.26,
                      ),
                      onSubmitted: (String query) => catController.searchData(
                        query,
                        catController.subCategoryIndex == 0
                            ? widget.category.id.toString()
                            : catController
                                .subCategoryList![
                                    catController.subCategoryIndex]
                                .id
                                .toString(),
                        1,
                      ),
                    )
                  : widget.category.name != null
                      ? Text(
                          widget.category.name!,
                          style: GoogleFonts.poppins(
                            color: AppColors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            // height: 0.04,
                          ),
                        )
                      : const SizedBox(),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Theme.of(context).textTheme.bodyLarge!.color,
                onPressed: () {
                  if (catController.isSearching) {
                    catController.toggleSearch();
                  } else {
                    Get.back();
                  }
                },
              ),
              backgroundColor: Theme.of(context).cardColor,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () => catController.toggleSearch(),
                  icon: Icon(
                      catController.isSearching
                          ? Icons.close_sharp
                          : Icons.search,
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ],
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: PaginatedListView(
                scrollController: _scrollController,
                onPaginate: (int? offset) async {
                  log('Page Offset is: $offset');
                  catController.isSearching
                      ? catController.searchData(catController.prodResultText,
                          widget.category.id.toString(), offset!)
                      : catController.getCategoryProductList(
                          widget.category.id.toString(), offset!, false);
                },
                dataList: _products,
                itemView: ProductView(
                    products: _products,
                    isShop: false,
                    noDataText: 'no_category_food_found'.tr),
                perPage: 10,
              ),
            ),
          ),
        );
      },
    );
  }
}
