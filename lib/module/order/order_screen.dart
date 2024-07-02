import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/styles.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/custom_widgets/custom_appbar.dart';
import 'package:sunglasses/custom_widgets/custom_button_comp.dart';
import 'package:sunglasses/custom_widgets/custom_textfield.dart';
import 'package:sunglasses/custom_widgets/no_data_page.dart';
import 'package:sunglasses/custom_widgets/paginated_list_view.dart';
import 'package:sunglasses/custom_widgets/show_snackbar.dart';
import '../../controller/theme_controller.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/dimensions.dart';
import '../../routes/pages.dart';
import '../auth/controller/auth_controller.dart';
import 'controller/order_controller.dart';
import 'order_details_screen.dart';
import 'widget/order_widget.dart';

class OrderScreen extends StatefulWidget {
  final bool? formMenu;

  const OrderScreen({Key? key, this.formMenu}) : super(key: key);
  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late bool _isLoggedIn;
  TextEditingController _idController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final scrollController = ScrollController();
  TabController? _tabController;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn) {
      Get.find<OrderController>().getHistoryOrders(1, all: true);
    }
    _tabController = TabController(
        length: Get.find<OrderController>().orderStatus.length,
        initialIndex: 0,
        vsync: this);
    _tabController?.addListener(() async {
      if (!_tabController!.indexIsChanging) {
        if (kDebugMode) {
          debugPrint('my index is${_tabController!.index}');
        }
        Get.find<OrderController>().setSelectedIndex(_tabController!.index);
        await Get.find<OrderController>().getHistoryOrders(1,
            all: _tabController!.index == 0 ? true : false,
            ongoing: _tabController!.index == 1 ? true : false,
            isUpdate: !isFirst);
        isFirst = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _isLoggedIn ? 'my_orders'.tr : 'track_order'.tr,
        // isBackButtonExist: widget.formMenu! ? true : false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Get.find<OrderController>().getHistoryOrders(1,
              all: _tabController!.index == 0 ? true : false,
              ongoing: _tabController!.index == 1 ? true : false);
        },
        child: GetBuilder<OrderController>(
          // initState: (context) {
          //   scrollController.animateTo(6 * Get.width / 3,
          //       duration: const Duration(seconds: 1), curve: Curves.easeIn);
          // },
          builder: (orderController) {
            return _isLoggedIn
                ? Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          indicatorColor: AppColors.primaryColor,
                          indicatorWeight: 0,
                          indicator: BoxDecoration(
                              color: Get.isDarkMode
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                  : AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(50)),
                          labelColor: Colors.white,
                          labelPadding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          unselectedLabelColor:
                              Theme.of(context).textTheme.bodyLarge!.color,
                          unselectedLabelStyle: poppinsRegular.copyWith(
                              color: Theme.of(context).disabledColor,
                              fontSize: Dimensions.fontSizeSmall),
                          labelStyle: poppinsRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: AppColors.primaryColor,
                          ),
                          tabs: _generateTabChildren(),
                        ),
                      ),
                    ),
                    //OrderWidget(),

                    !orderController.loadingOrder
                        ? orderController.historyOrderModel!.isNotEmpty
                            ? Expanded(
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  child: PaginatedListView(
                                    perPage: int.parse(
                                        AppConstants.PAGINATION_LIMIT),
                                    scrollController: _scrollController,
                                    dataList: orderController.historyOrderModel,
                                    onPaginate: (int? offset) async =>
                                        Get.find<OrderController>()
                                            .getHistoryOrders(offset!,
                                                all: _tabController!.index == 0
                                                    ? true
                                                    : false,
                                                ongoing:
                                                    _tabController!.index == 1
                                                        ? true
                                                        : false),
                                    itemView: ListView.builder(
                                        key: UniqueKey(),
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: orderController
                                            .historyOrderModel!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                              child: OrderWidget(
                                                  order: orderController
                                                          .historyOrderModel![
                                                      index]),
                                              onTap: () {
                                                Get.toNamed(
                                                  Routes.getOrderDetailsRoute(
                                                      orderController
                                                          .historyOrderModel![
                                                              index]
                                                          .id),
                                                  arguments: OrderDetailsScreen(
                                                      orderModel: orderController
                                                              .historyOrderModel![
                                                          index]),
                                                );
                                              });
                                        }),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: NoDataScreen(
                                    text: 'no_order_found'.tr,
                                    type: NoDataType.ORDER))
                        : Expanded(child: _orderShimmer()),
                  ])
                : Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'put_your_order_id_to_get_details_of_your_order'
                                    .tr,
                                style: poppinsMedium),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_SMALL),
                            CustomTextfield(
                              hintText: 'order_id'.tr,
                              controller: _idController,
                              textInputAction: TextInputAction.next,
                              inputType: TextInputType.number,
                            ),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_SMALL),
                            CustomTextfield(
                              hintText: 'email'.tr,
                              controller: _emailController,
                              textInputAction: TextInputAction.done,
                              inputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_LARGE),
                            !orderController.isLoading
                                ? CustomButtonSec(
                                    radius: 50,
                                    width: 250,
                                    buttonText: 'order_details'.tr,
                                    onPressed: () async {
                                      orderController.emptyOrder();
                                      if (_idController.text.trim().isEmpty) {
                                        showCustomSnackBar('enter_order_id'.tr);
                                      } else if (_emailController.text
                                          .trim()
                                          .isEmpty) {
                                        showCustomSnackBar(
                                            'please_enter_your_email'.tr);
                                      } else {
                                        debugPrint(orderController.isLoading
                                            .toString());
                                        await orderController.getOrderDetails(
                                            int.parse(
                                                _idController.text.trim()),
                                            notify: true);
                                        debugPrint(orderController.isLoading
                                            .toString());
                                        if (orderController.orderBillingEmail ==
                                            _emailController.text.trim()) {
                                          _emailController.text = '';
                                          Get.toNamed(
                                              Routes.getOrderDetailsRoute(
                                                  int.parse(_idController.text
                                                      .trim()),
                                                  guestMode: true));
                                          _idController.text = '';
                                        } else {
                                          showCustomSnackBar(
                                              'email_does_match_with_order'.tr);
                                        }
                                      }
                                    },
                                  )
                                : const Center(
                                    child: CircularProgressIndicator()),
                          ]),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

List<Widget> _generateTabChildren() {
  List<Widget> _tabs = [];
  for (int index = 0;
      index < Get.find<OrderController>().orderStatus.length;
      index++) {
    //debugPrint('sss--------------> ${Get.find<OrderController>().selectedTypeIndex } ||  $index');
    _tabs.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
        border: Border.all(
          color: Get.isDarkMode
              ? Theme.of(Get.context!).colorScheme.primaryContainer
              : AppColors.primaryColor,
        ),
      ),
      child: Text(Get.find<OrderController>().orderStatus[index].tr,
          style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeSmall)),
    ));
  }
  return _tabs;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

Widget _orderShimmer() {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    itemCount: 12,
    itemBuilder: (context, index) {
      return Container(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 130,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              //     color: Colors.grey[Get.find<ThemeController>().darkTheme ? 300 : 120]
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 15,
                      width: 120,
                      color: Colors.grey[
                          Get.find<ThemeController>().darkTheme ? 700 : 300]),
                  Container(
                      height: 17,
                      width: 80,
                      color: Colors.grey[
                          Get.find<ThemeController>().darkTheme ? 700 : 300]),
                  Container(
                      height: 27,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                          color: Colors.grey[
                              Get.find<ThemeController>().darkTheme
                                  ? 700
                                  : 300])),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Row(
                    children: [
                      Container(
                        height: 49,
                        width: 49,
                        decoration: BoxDecoration(
                          color: Colors.grey[
                              Get.find<ThemeController>().darkTheme
                                  ? 700
                                  : 300],
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        ),
                      ),
                      const SizedBox(
                          width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Container(
                        height: 49,
                        width: 49,
                        decoration: BoxDecoration(
                          color: Colors.grey[
                              Get.find<ThemeController>().darkTheme
                                  ? 700
                                  : 300],
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Row(
                    children: [
                      Container(
                        height: 49,
                        width: 49,
                        decoration: BoxDecoration(
                          color: Colors.grey[
                              Get.find<ThemeController>().darkTheme
                                  ? 700
                                  : 300],
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        ),
                      ),
                      const SizedBox(
                          width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Container(
                        height: 49,
                        width: 49,
                        decoration: BoxDecoration(
                          color: Colors.grey[
                              Get.find<ThemeController>().darkTheme
                                  ? 700
                                  : 300],
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )
          .animate(
            onComplete: (controller) => controller.repeat(),
          )
          .shimmer(duration: 1500.ms);
    },
  );
}
