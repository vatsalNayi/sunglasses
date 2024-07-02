import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/app_constants.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/utils/styles.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/custom_appbar.dart';
import 'package:sunglasses/custom_widgets/no_data_page.dart';
import 'package:sunglasses/custom_widgets/paginated_list_view.dart';
import 'package:sunglasses/custom_widgets/show_snackbar.dart';
import 'package:sunglasses/helper/date_converter.dart';
import 'package:sunglasses/helper/price_converter.dart';
import 'package:sunglasses/helper/responsive_helper.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import '../../controller/localization_controller.dart';
import '../../controller/theme_controller.dart';
import 'controller/coupon_controller.dart';

class CouponScreen extends StatefulWidget {
  final bool formCart;
  const CouponScreen({super.key, this.formCart = false});
  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Get.find<CouponController>().getCouponList(1, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'coupon'.tr),
      body: GetBuilder<CouponController>(builder: (couponController) {
        return couponController.couponList != null
            ? couponController.couponList!.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      await couponController.getCouponList(1, true);
                    },
                    child: Scrollbar(
                        child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Center(
                          child: SizedBox(
                              width: Dimensions.WEB_MAX_WIDTH,
                              child: PaginatedListView(
                                scrollController: _scrollController,
                                dataList: couponController.couponList,
                                perPage:
                                    int.parse(AppConstants.PAGINATION_LIMIT),
                                onPaginate: (int? offset) async =>
                                    await couponController.getCouponList(
                                        offset!, false),
                                itemView: ListView.builder(
                                  itemCount:
                                      couponController.couponList!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    int usesCount = 0;
                                    if (Get.find<AuthController>()
                                            .isLoggedIn() &&
                                        couponController
                                                .couponList![index].usedBy !=
                                            null) {
                                      for (int i = 0;
                                          i <
                                              couponController
                                                  .couponList![index]
                                                  .usedBy!
                                                  .length;
                                          i++) {
                                        if (Get.find<AuthController>()
                                                .getSavedUserId()
                                                .toString() ==
                                            couponController.couponList![index]
                                                .usedBy![i]) {
                                          usesCount += 1;
                                        }
                                      }
                                    }

                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: index == 0
                                              ? Dimensions.PADDING_SIZE_SMALL
                                              : 0),
                                      child: Stack(children: [
                                        RotatedBox(
                                          quarterTurns:
                                              Get.find<LocalizationController>()
                                                      .isLtr
                                                  ? 180
                                                  : 90,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_SMALL),
                                            child: Image.asset(
                                              ImagePath.couponBg,
                                              height: ResponsiveHelper
                                                      .isMobilePhone()
                                                  ? 130
                                                  : 140,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              //color: Theme.of(context).primaryColor,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height:
                                              ResponsiveHelper.isMobilePhone()
                                                  ? 120
                                                  : 140,
                                          alignment: Alignment.center,
                                          child: Row(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 54, right: 45),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    CupertinoIcons.tag,
                                                    size: 25,
                                                    color: AppColors.softPink,
                                                  ),
                                                  const SizedBox(
                                                      height: Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL),
                                                  (Get.find<AuthController>()
                                                              .isLoggedIn() &&
                                                          couponController
                                                                  .couponList![
                                                                      index]
                                                                  .usageLimitPerUser !=
                                                              null &&
                                                          couponController
                                                                  .couponList![
                                                                      index]
                                                                  .usageLimitPerUser !=
                                                              0)
                                                      ? Row(children: [
                                                          couponController
                                                                      .couponList![
                                                                          index]
                                                                      .usageLimitPerUser !=
                                                                  null
                                                              ? Text(
                                                                  '${couponController.couponList![index].usageLimitPerUser.toString()}/',
                                                                  style: poppinsRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              Dimensions.fontSizeSmall),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                )
                                                              : const SizedBox(),
                                                          Text(
                                                              usesCount
                                                                  .toString(),
                                                              style: poppinsRegular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeSmall)),
                                                        ])
                                                      : const SizedBox(),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                          height: Get.find<
                                                                      LocalizationController>()
                                                                  .isLtr
                                                              ? 0
                                                              : Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                      Text(
                                                        couponController
                                                                    .couponList![
                                                                        index]
                                                                    .discountType ==
                                                                'percent'
                                                            ? '${Get.find<LocalizationController>().isLtr ? '' : '%'} ${couponController.couponList![index].amount} ${Get.find<LocalizationController>().isLtr ? '%' : ''} ${'off'.tr}'
                                                            : PriceConverter.convertPrice(
                                                                    couponController
                                                                        .couponList![
                                                                            index]
                                                                        .amount!) +
                                                                'off'.tr,
                                                        style: poppinsMedium.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headlineSmall!
                                                                .color,
                                                            fontSize: Dimensions
                                                                .fontSizeLarge),
                                                      ),
                                                      //SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                                      couponController
                                                                  .couponList![
                                                                      index]
                                                                  .code !=
                                                              ''
                                                          ? Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: Get.find<
                                                                              LocalizationController>()
                                                                          .isLtr
                                                                      ? 30
                                                                      : 0,
                                                                  left: Get.find<
                                                                              LocalizationController>()
                                                                          .isLtr
                                                                      ? 0
                                                                      : 30),
                                                              child: Text(
                                                                couponController
                                                                    .couponList![
                                                                        index]
                                                                    .code!,
                                                                style: poppinsRegular.copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headlineSmall!
                                                                        .color,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeDefault),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      const SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),

                                                      // (couponController.couponList[index].usageLimitPerUser != null && couponController.couponList[index].usageLimitPerUser > 0) ?
                                                      // Row(children: [
                                                      //   Text(
                                                      //     '${'usage_limit_per_user'.tr}:',
                                                      //     style: robotoRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall),
                                                      //     maxLines: 1, overflow: TextOverflow.ellipsis,
                                                      //   ),
                                                      //   SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                      //   Text(
                                                      //     couponController.couponList[index].usageLimitPerUser.toString(),
                                                      //     style: robotoRegular.copyWith( fontSize: Dimensions.fontSizeSmall ),
                                                      //     maxLines: 1, overflow: TextOverflow.ellipsis,
                                                      //   ),
                                                      // ]) : SizedBox(),

                                                      // (couponController.couponList[index].usageLimitPerUser != null && couponController.couponList[index].usageLimitPerUser > 0) ?
                                                      // (couponController.couponList[index].usageLimit != null && couponController.couponList[index].usageLimit > 0) ?
                                                      // Row(children: [
                                                      //   Text(
                                                      //     '${'usage_limit'.tr}:',
                                                      //     style: robotoRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall),
                                                      //     maxLines: 1, overflow: TextOverflow.ellipsis,
                                                      //   ),
                                                      //   SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                      //   Text(
                                                      //     couponController.couponList[index].usageLimit.toString(),
                                                      //     style: robotoRegular.copyWith( fontSize: Dimensions.fontSizeSmall ),
                                                      //     maxLines: 1, overflow: TextOverflow.ellipsis,
                                                      //   ),
                                                      // ]) : SizedBox() : SizedBox(),

                                                      Row(children: [
                                                        Text(
                                                          '${'min_purchase'.tr}:',
                                                          style: poppinsRegular
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .softPink,
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const SizedBox(
                                                            width: Dimensions
                                                                .PADDING_SIZE_EXTRA_SMALL),
                                                        Text(
                                                          PriceConverter.convertPrice(
                                                              couponController
                                                                  .couponList![
                                                                      index]
                                                                  .minimumAmount!),
                                                          style: poppinsMedium.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ]),
                                                      const SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),

                                                      Row(children: [
                                                        couponController
                                                                    .couponList![
                                                                        index]
                                                                    .dateExpires !=
                                                                null
                                                            ? Text(
                                                                'valid_until'
                                                                    .tr,
                                                                style: poppinsRegular.copyWith(
                                                                    color: AppColors
                                                                        .softPink,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeSmall),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )
                                                            : const SizedBox(),
                                                        const SizedBox(
                                                            width: Dimensions
                                                                .PADDING_SIZE_EXTRA_SMALL),
                                                        Text(
                                                          couponController
                                                                      .couponList![
                                                                          index]
                                                                      .dateExpires !=
                                                                  null
                                                              ? DateConverter.estimatedDate(DateTime.parse(
                                                                  couponController
                                                                      .couponList![
                                                                          index]
                                                                      .dateExpires!))
                                                              : 'no_expiry_date'
                                                                  .tr,
                                                          style: poppinsMedium.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ]),
                                                    ]),
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Positioned(
                                          bottom:
                                              Get.find<LocalizationController>()
                                                      .isLtr
                                                  ? 10
                                                  : 0,
                                          right:
                                              Get.find<LocalizationController>()
                                                      .isLtr
                                                  ? 0
                                                  : null,
                                          left:
                                              Get.find<LocalizationController>()
                                                      .isLtr
                                                  ? null
                                                  : 0,
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 20),
                                              child: InkWell(
                                                onTap: () {
                                                  if (widget.formCart) {
                                                    couponController
                                                        .setSelectedCoupon(
                                                            couponController
                                                                .couponList![
                                                                    index]
                                                                .code);
                                                    Get.back();
                                                  } else {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text:
                                                                couponController
                                                                    .couponList![
                                                                        index]
                                                                    .code!));
                                                    showCustomSnackBar(
                                                        'coupon_code_copied'.tr,
                                                        isError: false);
                                                  }
                                                },
                                                child: Image.asset(
                                                  ImagePath.copyCoupon,
                                                  height: 20,
                                                  width: 25,
                                                  color: AppColors.softPink,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                    );
                                  },
                                ),
                              ))),
                    )),
                  )
                : NoDataScreen(
                    text: 'no_coupon_found'.tr, type: NoDataType.COUPON)
            : _notificationWidget();
      }),
    );
  }
}

Widget _notificationWidget() {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    itemCount: 12,
    itemBuilder: (context, index) {
      return SizedBox(
        height: ResponsiveHelper.isMobilePhone() ? 130 : 140,
        width: MediaQuery.of(context).size.width,
        //color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
        child: Image.asset(ImagePath.couponBg,
            color:
                Colors.grey[Get.find<ThemeController>().darkTheme ? 300 : 700]),
      )
          .animate(
              onComplete: (controller) => controller.repeat(reverse: false))
          .shimmer(duration: 1000.ms);
    },
  );
}
