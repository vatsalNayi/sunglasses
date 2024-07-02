import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/custom_widgets/confirm_dialog.dart';
import 'package:sunglasses/custom_widgets/custom_appbar.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:sunglasses/module/cart/cart_controller.dart';
import 'package:sunglasses/module/search/controller/search_controller.dart'
    as search;
import 'package:sunglasses/module/wishlist/controller/wish_controller.dart';
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import '../../routes/pages.dart';
import 'profile/profile_controller.dart';
import 'widgets/more_tile.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  late bool _isLoggedIn;
  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getUserInfo();
    }
    Get.find<ProfileController>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'profile'.tr,
        trailingIcon: ImagePath.profileSvg,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<ProfileController>(builder: (profileController) {
          // if(profileController.profileModel != null && _emailController.text.isEmpty) {
          // _firstNameController.text = profileController.profileModel!.firstName ?? '';
          // _lastNameController.text = profileController.profileModel!.lastName ?? '';
          // _emailController.text = profileController.profileModel!.email ?? '';
          // }
          return Column(
            children: [
              MoreTile(
                onPress: () {
                  Get.toNamed(Routes.getProfileRoute());
                },
                title: 'View Profile'.tr,
                leadingIcon: ImagePath.profileSvg,
                iconColor: AppColors.brightGrey,
              ),
              MoreTile(
                onPress: () {
                  Get.toNamed(Routes.getSavedAddressRoute());
                },
                title: 'My Address'.tr,
                leadingIcon: ImagePath.location,
              ),
              MoreTile(
                onPress: () {
                  // Get.toNamed(Routes.getCouponRoute(false));
                },
                title: 'Coupons'.tr,
                leadingIcon: ImagePath.coupon,
              ),
              MoreTile(
                onPress: () {
                  Get.toNamed(Routes.getOrdersRoute(false));
                },
                title: 'my_orders'.tr,
                leadingIcon: ImagePath.orders,
              ),
              MoreTile(
                title: 'Settings'.tr,
                leadingIcon: ImagePath.settings,
                onPress: () {
                  Get.toNamed(Routes.getSettingsRoute());
                },
              ),
              _isLoggedIn
                  ? MoreTile(
                      onPress: () {
                        if (Get.find<AuthController>().isLoggedIn()) {
                          Get.dialog(
                              ConfirmationDialog(
                                  icon: ImagePath.deleteAccountDialogPng,
                                  description:
                                      'are_you_sure_to_delete_account'.tr,
                                  isLogOut: true,
                                  onYesPressed: () async {
                                    await Get.find<AuthController>()
                                        .deleteToken();
                                    await Get.find<ProfileController>()
                                        .removeUser();
                                    Get.find<ProfileController>()
                                        .clearProfileData();
                                    Get.find<AuthController>()
                                        .clearSharedData();
                                    Get.find<AuthController>().isLoggedIn();

                                    Get.find<search.SearchController>()
                                        .clearSearchAddress();
                                    Get.find<WishListController>()
                                        .getWishList();
                                    _isLoggedIn = false;
                                    Get.back();
                                    Get.toNamed(Routes.getSignInRoute());
                                  }),
                              useSafeArea: false);
                        } else {
                          Get.toNamed(Routes.getSignInRoute());
                        }
                      },
                      title: 'delete_account'.tr,
                      leadingIcon: ImagePath.delete,
                    )
                  : const SizedBox(),
              MoreTile(
                onPress: () async {
                  if (Get.find<AuthController>().isLoggedIn()) {
                    Get.dialog(
                        ConfirmationDialog(
                            icon: ImagePath.logOutDialog,
                            description: 'are_you_sure_to_logout'.tr,
                            isLogOut: true,
                            onYesPressed: () async {
                              await Get.find<AuthController>().deleteToken();
                              Get.find<ProfileController>().clearProfileData();
                              Get.find<AuthController>().clearSharedData();
                              Get.find<AuthController>().isLoggedIn();

                              Get.find<search.SearchController>()
                                  .clearSearchAddress();
                              Get.find<WishListController>().getWishList();
                              _isLoggedIn = false;
                              Get.find<CartController>()
                                  .getCartList(notify: true);
                              Get.back();
                              Get.toNamed(Routes.getSignInRoute());
                            }),
                        useSafeArea: false);
                  } else {
                    Get.toNamed(Routes.getSignInRoute());
                  }
                },
                title: _isLoggedIn ? 'logout'.tr : 'sign_in'.tr,
                leadingIcon: ImagePath.logOut,
              ),
              const SizedBox(
                height: 200,
              )
            ],
          );
        }),
      ),
    );
  }
}
