import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/custom_widgets/no_data_page.dart';
import 'package:sunglasses/custom_widgets/show_snackbar.dart';
import '../../controller/localization_controller.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';
import '../../core/values/strings.dart';
import 'controller/search_controller.dart' as search;
import 'widgets/item_view.dart';
import 'widgets/search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_SMALL,
        ),
        child: GetBuilder<search.SearchController>(builder: (searchController) {
          _searchController.text = searchController.searchText;
          return Column(children: [
            Center(
                child: SizedBox(
                    width: Dimensions.WEB_MAX_WIDTH,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: Row(children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                Get.find<LocalizationController>().isLtr
                                    ? 0
                                    : Dimensions.PADDING_SIZE_SMALL,
                                Dimensions.PADDING_SIZE_SMALL,
                                Get.find<LocalizationController>().isLtr
                                    ? Dimensions.PADDING_SIZE_SMALL
                                    : 0,
                                Dimensions.PADDING_SIZE_DEFAULT),
                            child: const SizedBox(
                                width: Dimensions.ICON_SIZE_LARGE,
                                child: Icon(Icons.arrow_back_ios)),
                            // Get.find<LocalizationController>().isLtr ? Icons.arrow_back_ios_new_rounded :
                          ),
                        ),
                        Expanded(
                            child: SearchField(
                          controller: _searchController,
                          hint: 'search_product'.tr,
                          suffixIcon: !searchController.isSearchMode
                              ? ImagePath.clearIcon
                              : ImagePath.searchIcon,
                          iconPressed: () => !searchController.isSearchMode
                              ? searchController.setSearchMode(true)
                              : _actionSearch(searchController, false),
                          onSubmit: (text) =>
                              _actionSearch(searchController, true),
                        )),
                      ]),
                    ))),
            Expanded(
                child: searchController.isSearchMode
                    ? SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_SMALL),
                        child: Center(
                            child: SizedBox(
                                width: Dimensions.WEB_MAX_WIDTH,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      searchController.historyList.isNotEmpty
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                  Text('history'.tr,
                                                      style: poppinsMedium.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeLarge)),
                                                  InkWell(
                                                    onTap: () => searchController
                                                        .clearSearchAddress(),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: Dimensions
                                                              .PADDING_SIZE_SMALL,
                                                          horizontal: 4),
                                                      child: Text(
                                                          'clear_all'.tr,
                                                          style: poppinsRegular
                                                              .copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeSmall,
                                                            color: Theme.of(
                                                                    context)
                                                                .disabledColor,
                                                          )),
                                                    ),
                                                  ),
                                                ])
                                          : SizedBox(
                                              height: Get.context!.height - 150,
                                              width: Get.context!.width,
                                              child: Center(
                                                child: NoDataScreen(
                                                    text:
                                                        'no_search_history_found'
                                                            .tr,
                                                    type: NoDataType.SEARCH),
                                              ),
                                            ),
                                      searchController.historyList.isNotEmpty
                                          ? Wrap(
                                              direction: Axis.horizontal,
                                              alignment: WrapAlignment.start,
                                              children: [
                                                for (int index = 0;
                                                    index <
                                                        searchController
                                                            .historyList.length;
                                                    index++)
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius.all(
                                                                    Radius.circular(
                                                                        50)),
                                                            color: Get
                                                                    .isDarkMode
                                                                ? Colors.grey
                                                                    .withOpacity(
                                                                        0.2)
                                                                : AppColors
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        0.3)),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL -
                                                              3,
                                                          horizontal: Dimensions
                                                              .PADDING_SIZE_SMALL,
                                                        ),
                                                        margin: const EdgeInsets.only(
                                                            right: Dimensions
                                                                .PADDING_SIZE_SMALL),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Flexible(
                                                              child: InkWell(
                                                                onTap: () => searchController
                                                                    .searchData(
                                                                        searchController
                                                                            .historyList[index],
                                                                        1),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          Dimensions
                                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                                  child: Text(
                                                                    searchController
                                                                            .historyList[
                                                                        index],
                                                                    style: poppinsRegular
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .primaryColor,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL,
                                                            ),
                                                            InkWell(
                                                              onTap: () =>
                                                                  searchController
                                                                      .removeHistory(
                                                                          index),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        Dimensions
                                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                                child: Icon(
                                                                    Icons.close,
                                                                    color: AppColors
                                                                        .primaryColor
                                                                        .withOpacity(
                                                                            .75),
                                                                    size: 10),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                  )
                                              ],
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                          height:
                                              Dimensions.PADDING_SIZE_LARGE),
                                    ]))),
                      )
                    : const ItemView()),
          ]);
        }),
      )),
    );
  }

  void _actionSearch(search.SearchController searchController, bool isSubmit) {
    if (searchController.isSearchMode || isSubmit) {
      if (_searchController.text.trim().isNotEmpty) {
        searchController.searchData(_searchController.text.trim(), 1);
      } else {
        showCustomSnackBar('please_write_something'.tr);
      }
    } else {}
  }
}
