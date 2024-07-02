import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/utils/styles.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/custom_image.dart';
import 'package:sunglasses/custom_widgets/no_data_page.dart';
import 'package:sunglasses/custom_widgets/paginated_list_view.dart';
import 'package:sunglasses/helper/date_converter.dart';
import 'package:sunglasses/helper/responsive_helper.dart';
import 'package:sunglasses/models/order_model.dart';
import 'package:sunglasses/routes/pages.dart';
import '../controller/order_controller.dart';
import '../order_details_screen.dart';
import 'order_shimmer.dart';

class OrderView extends StatelessWidget {
  final bool isRunning;
  OrderView({required this.isRunning});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
        body: GetBuilder<OrderController>(builder: (orderController) {
      List<OrderModel>? orderList;
      if (orderController.historyOrderModel != null &&
          orderController.historyOrderModel != null) {
        orderList = isRunning
            ? orderController.historyOrderModel
            : orderController.historyOrderModel;
      }

      return orderList != null
          ? orderList.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: () async {
                    await orderController.getHistoryOrders(1);
                  },
                  // child:
                  //
                  // Column(
                  //   children: [
                  //     OrderWidget(),
                  //   ],
                  // )) : SizedBox() : SizedBox();

                  child: Scrollbar(
                      child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      width: Dimensions.WEB_MAX_WIDTH,
                      child: PaginatedListView(
                        scrollController: scrollController,
                        dataList: orderList,
                        onPaginate: (int? offset) {
                          if (isRunning) {
                            // Get.find<OrderController>().getRunningOrders(offset);
                          } else {
                            Get.find<OrderController>()
                                .getHistoryOrders(offset!);
                          }
                        },
                        itemView: ListView.builder(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_SMALL),
                          itemCount: orderList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed(
                                  Routes.getOrderDetailsRoute(
                                      orderList![index].id),
                                  arguments: OrderDetailsScreen(
                                      orderModel: orderList[index]),
                                );
                              },
                              child: Container(
                                padding: ResponsiveHelper.isDesktop(context)
                                    ? const EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL)
                                    : null,
                                margin: ResponsiveHelper.isDesktop(context)
                                    ? const EdgeInsets.only(
                                        bottom: Dimensions.PADDING_SIZE_SMALL)
                                    : null,
                                decoration: ResponsiveHelper.isDesktop(context)
                                    ? BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.RADIUS_SMALL),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[
                                                  Get.isDarkMode ? 700 : 300]!,
                                              blurRadius: 5,
                                              spreadRadius: 1)
                                        ],
                                      )
                                    : null,
                                child: Column(children: [
                                  Row(children: [
                                    Stack(children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        alignment: Alignment.center,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.RADIUS_SMALL),
                                          child: const CustomImage(
                                            image: '',
                                            height: 60,
                                            width: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    const SizedBox(
                                        width: Dimensions.PADDING_SIZE_SMALL),
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(children: [
                                              Text(
                                                '${'order_id'.tr}:',
                                                style: poppinsRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeSmall),
                                              ),
                                              const SizedBox(
                                                  width: Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                              Text('#${orderList![index].id}',
                                                  style: poppinsMedium.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeSmall)),
                                            ]),
                                            const SizedBox(
                                                height: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                            Text(
                                              DateConverter
                                                  .isoStringToLocalDateOnly(
                                                      orderList[index]
                                                          .dateCreated!),
                                              style: poppinsRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .disabledColor,
                                                  fontSize:
                                                      Dimensions.fontSizeSmall),
                                            ),
                                          ]),
                                    ),
                                    const SizedBox(
                                        width: Dimensions.PADDING_SIZE_SMALL),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .PADDING_SIZE_SMALL,
                                                vertical: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.RADIUS_SMALL),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            child: Text(
                                                orderList[index].status!.tr,
                                                style: poppinsMedium.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeExtraSmall,
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                )),
                                          ),
                                          const SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          isRunning
                                              ? InkWell(
                                                  onTap: () => Get.toNamed(Routes
                                                      .getOrderTrackingRoute(
                                                          orderList![index])),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: Dimensions
                                                            .PADDING_SIZE_SMALL,
                                                        vertical: Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                              .RADIUS_SMALL),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                    child: Row(children: [
                                                      Image.asset(
                                                          ImagePath.tracking,
                                                          height: 15,
                                                          width: 15,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                      const SizedBox(
                                                          width: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                      Text('track_order'.tr,
                                                          style: poppinsMedium
                                                              .copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeExtraSmall,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          )),
                                                    ]),
                                                  ),
                                                )
                                              : Text(
                                                  '${orderList[index].lineItems!.length} ${orderList[index].lineItems!.length > 1 ? 'items'.tr : 'item'.tr}',
                                                  style: poppinsRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeExtraSmall),
                                                ),
                                        ]),
                                  ]),
                                  (index == orderList.length - 1 ||
                                          ResponsiveHelper.isDesktop(context))
                                      ? const SizedBox()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 70),
                                          child: Divider(
                                            color:
                                                Theme.of(context).disabledColor,
                                            height:
                                                Dimensions.PADDING_SIZE_LARGE,
                                          ),
                                        ),
                                ]),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )),
                )
              : NoDataScreen(text: 'no_order_found'.tr)
          : OrderShimmer(orderController: orderController);
    }));
  }
}






























//Scrollbar(child: SingleChildScrollView(
//     controller: scrollController,
//     physics: AlwaysScrollableScrollPhysics(),
//     child: SizedBox(
//       width: Dimensions.WEB_MAX_WIDTH,
//       child: PaginatedListView(
//         scrollController: scrollController,
//         dataList: orderList,
//         onPaginate: (int offset) {
//           if(isRunning) {
//             Get.find<OrderController>().getRunningOrders(offset);
//           }else {
//             Get.find<OrderController>().getHistoryOrders(offset);
//           }
//         },
//         itemView: ListView.builder(
//           padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//           itemCount: orderList.length,
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () {
//                 Get.toNamed(
//                   RouteHelper.getOrderDetailsRoute(orderList[index].id),
//                   arguments: OrderDetailsScreen(orderModel: orderList[index]),
//                 );
//               },
//               child: Container(
//                 padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL) : null,
//                 margin: ResponsiveHelper.isDesktop(context) ? EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL) : null,
//                 decoration: ResponsiveHelper.isDesktop(context) ? BoxDecoration(
//                   color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                   boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300], blurRadius: 5, spreadRadius: 1)],
//                 ) : null,
//                 child: Column(children: [
//
//                   Row(children: [
//
//                     Stack(children: [
//                       Container(
//                         height: 60, width: 60, alignment: Alignment.center,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                           child: CustomImage(
//                             image: '',
//                             height: 60, width: 60, fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ]),
//                     SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//
//                     Expanded(
//                       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                         Row(children: [
//                           Text(
//                             '${'order_id'.tr}:',
//                             style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
//                           ),
//                           SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                           Text('#${orderList[index].id}', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
//                         ]),
//                         SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                         Text(
//                           DateConverter.isoStringToLocalDateOnly(orderList[index].dateCreated),
//                           style: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
//                         ),
//                       ]),
//                     ),
//                     SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//
//                     Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         child: Text(orderList[index].status.tr, style: robotoMedium.copyWith(
//                           fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor,
//                         )),
//                       ),
//                       SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                       isRunning ? InkWell(
//                         onTap: () => Get.toNamed(RouteHelper.getOrderTrackingRoute(orderList[index])),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                             border: Border.all(width: 1, color: Theme.of(context).primaryColor),
//                           ),
//                           child: Row(children: [
//                             Image.asset(Images.tracking, height: 15, width: 15, color: Theme.of(context).primaryColor),
//                             SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                             Text('track_order'.tr, style: robotoMedium.copyWith(
//                               fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor,
//                             )),
//                           ]),
//                         ),
//                       ) : Text(
//                         '${orderList[index].lineItems.length} ${orderList[index].lineItems.length > 1 ? 'items'.tr : 'item'.tr}',
//                         style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
//                       ),
//                     ]),
//
//                   ]),
//
//                   (index == orderList.length-1 || ResponsiveHelper.isDesktop(context)) ? SizedBox() : Padding(
//                     padding: EdgeInsets.only(left: 70),
//                     child: Divider(
//                       color: Theme.of(context).disabledColor, height: Dimensions.PADDING_SIZE_LARGE,
//                     ),
//                   ),
//
//                 ]),
//               ),
//             );
//           },
//         ),
//       ),
//     ),
//   )),
// ) : NoDataScreen(text: 'no_order_found'.tr) : OrderShimmer(orderController: orderController);