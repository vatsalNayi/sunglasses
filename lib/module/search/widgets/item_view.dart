import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/custom_widgets/paginated_list_view.dart';
import 'package:sunglasses/custom_widgets/product_view.dart';
import '../../../core/utils/dimensions.dart';
import '../controller/search_controller.dart' as search;

class ItemView extends StatefulWidget {
  const ItemView({super.key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<search.SearchController>(builder: (searchController) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: Center(
              child: SizedBox(
                  width: Dimensions.WEB_MAX_WIDTH,
                  child: PaginatedListView(
                    scrollController: _scrollController,
                    dataList: searchController.searchProductList,
                    perPage: 6,
                    onPaginate: (int? offset) async => searchController
                        .searchData(searchController.prodResultText, offset!),
                    itemView: ProductView(
                      isShop: false,
                      products: searchController.searchProductList,
                    ),
                  ))),
        );
      }),
    );
  }
}
