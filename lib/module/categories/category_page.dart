import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/custom_widgets/custom_appbar.dart';
import 'package:sunglasses/custom_widgets/custom_image.dart';
import 'package:sunglasses/custom_widgets/custom_loader.dart';
import 'package:sunglasses/models/category_model.dart';
import 'package:sunglasses/module/categories/controller/category_controller.dart';
import 'package:sunglasses/module/categories/widgets/main_categories_shimmer.dart';
import 'package:sunglasses/routes/pages.dart';
import '../../custom_widgets/custom_button.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  void loadCategories() async {
    CategoryController controller = Get.find();
    controller.noSubCategoriesIDsList.clear();
    controller.subCategoryList?.clear();
    await controller.getCategoryList(false, 1);
    Get.dialog(const CustomLoader(), barrierDismissible: false);
    controller.getSubCategoryList(controller.selectedMainCategoryData);
  }

  @override
  void initState() {
    loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'categories'.tr,
      ),
      body: SafeArea(
        child: GetBuilder<CategoryController>(builder: (categoryController) {
          return (categoryController.categoryList != null &&
                  categoryController.categoryList!.isEmpty)
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: categoryController.categoryList != null
                          ? SizedBox(
                              height: 35.h,
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount:
                                    categoryController.categoryList!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  CategoryModel data = categoryController
                                      .categoryList!
                                      .elementAt(index);
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          categoryController
                                              .getSubCategoriesAndProducts(
                                                  index: index, data: data);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          width: 100,
                                          child: Center(
                                            child: FittedBox(
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                              child: Text(
                                                data.name ?? '',
                                                style: GoogleFonts.poppins(
                                                  color: AppColors.black,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Obx(() => AnimatedSwitcher(
                                            duration: 400.ms,
                                            transitionBuilder: (child, val) {
                                              return ScaleTransition(
                                                scale: val,
                                                child: child,
                                              );
                                            },
                                            child: categoryController
                                                        .selectedMainCategory ==
                                                    index
                                                ? Container(
                                                    width: 80,
                                                    height: 4,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20.r,
                                                      ),
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          )),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const VerticalDivider(
                                    color: Color(0xFF37474F),
                                  );
                                },
                              ),
                            )
                          : const MaincategoriesShimmerWidget(),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GetBuilder<CategoryController>(
                        builder: (categoryController) {
                      return categoryController.subCategoryList != null
                          ? categoryController.subCategoryList != null &&
                                  categoryController.subCategoryList!.isEmpty
                              ? Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'There are no any categories available',
                                          style: GoogleFonts.poppins(
                                            color: AppColors.black,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 100),
                                          child: CustomButton(
                                            loading: false,
                                            onPress: () {
                                              Get.toNamed(
                                                Routes.getCategoryProductRoute(
                                                    categoryController
                                                        .selectedMainCategoryData),
                                              );
                                            },
                                            btnText: 'See Products',
                                            style: GoogleFonts.poppins(
                                              color: AppColors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.44,
                                            ),
                                            bgColor: AppColors.lightRose,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: Get.width * 0.3,
                                          height: double.maxFinite,
                                          color: AppColors.primaryColor
                                              .withOpacity(.2),
                                          child: ListView.builder(
                                            physics:
                                                const ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: getSubCategoryFromParentCategory(
                                                    categoryController,
                                                    parentId: categoryController
                                                        .selectedMainCategoryId)
                                                .length,
                                            itemBuilder: (context, index) {
                                              CategoryModel subCateogryData =
                                                  getSubCategoryFromParentCategory(
                                                          categoryController,
                                                          parentId:
                                                              categoryController
                                                                  .selectedMainCategoryId)
                                                      .elementAt(index);
                                              return GestureDetector(
                                                onTap: () {
                                                  if (categoryController
                                                          .noSubCategoriesIDsList
                                                          .contains(
                                                              subCateogryData
                                                                  .id!) ||
                                                      categoryController
                                                              .selectedMainCategoryId ==
                                                          subCateogryData.id!) {
                                                    Get.toNamed(
                                                      Routes
                                                          .getCategoryProductRoute(
                                                              subCateogryData),
                                                    );
                                                  } else {
                                                    categoryController
                                                            .selectedParentCategory =
                                                        subCateogryData.id!;
                                                    categoryController.update();
                                                  }
                                                },
                                                child: AnimatedContainer(
                                                  duration: 400.ms,
                                                  height: 30,
                                                  color: categoryController
                                                              .selectedParentCategory ==
                                                          subCateogryData.id!
                                                      ? AppColors.primaryColor
                                                      : AppColors.white,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  margin: const EdgeInsets.only(
                                                      bottom: 20),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: SizedBox(
                                                      width: 130,
                                                      child: Text(
                                                        subCateogryData.name ??
                                                            '',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: categoryController
                                                      .selectedParentCategory !=
                                                  -1
                                              ? SizedBox(
                                                  child: GridView.builder(
                                                    physics:
                                                        const ClampingScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      childAspectRatio: 1.2,
                                                      mainAxisSpacing: 20,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    itemCount: getSubCategoryFromParentCategory(
                                                            categoryController,
                                                            parentId:
                                                                categoryController
                                                                    .selectedParentCategory)
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      CategoryModel data =
                                                          getSubCategoryFromParentCategory(
                                                                  categoryController,
                                                                  parentId:
                                                                      categoryController
                                                                          .selectedParentCategory)
                                                              .elementAt(index);
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Get.toNamed(
                                                            Routes
                                                                .getCategoryProductRoute(
                                                              data,
                                                            ),
                                                          );
                                                        },
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              width: 80,
                                                              height: 80,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color((Random().nextDouble() *
                                                                            0xFFFFFF)
                                                                        .toInt())
                                                                    .withOpacity(
                                                                        0.2),
                                                                shape: BoxShape
                                                                    .circle,
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black12,
                                                                    blurStyle:
                                                                        BlurStyle
                                                                            .outer,
                                                                    blurRadius:
                                                                        10,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: ClipOval(
                                                                child: Center(
                                                                  child:
                                                                      CustomImage(
                                                                    image: data.image !=
                                                                            null
                                                                        ? data
                                                                            .image!
                                                                            .src!
                                                                        : '',
                                                                    width: 50,
                                                                    height: 50,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              data.name ?? '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: AppColors
                                                                    .brightGrey,
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                // height: 0.12,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              : Container(
                                                  color: Colors.red,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                          : Container();
                    })
                  ],
                );
        }),
      ),
    );
  }

  Iterable<CategoryModel> getSubCategoryFromParentCategory(
      CategoryController categoryController,
      {required int parentId}) {
    return categoryController.subCategoryList!
        .where((element) => element.parent! == parentId)
        .toList()
      ..sort((a, b) => a.menuOrder!.compareTo(b.menuOrder!));
  }
}
