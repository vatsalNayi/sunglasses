import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/utils/styles.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/custom_widgets/confirm_dialog.dart';
import 'package:sunglasses/custom_widgets/custom_appbar.dart';
import 'package:sunglasses/custom_widgets/custom_image.dart';
import 'package:sunglasses/custom_widgets/not_logged_in_screen.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:sunglasses/module/cart/cart_controller.dart';
import '../../../../controller/localization_controller.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/values/strings.dart';
import '../../../../routes/pages.dart';
import '../profile_controller.dart';
import 'profile_button.dart';

class ViewProfileScreen extends StatefulWidget {
  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
        // isBackButtonExist: true,
        // onBackPressed: () => Get.back(),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<ProfileController>(builder: (profileController) {
        if (profileController.profileModel != null &&
            _emailController.text.isEmpty) {
          _firstNameController.text =
              profileController.profileModel!.firstName ?? '';
          _lastNameController.text =
              profileController.profileModel!.lastName ?? '';
          _emailController.text = profileController.profileModel!.email ?? '';
        }

        return _isLoggedIn
            ? profileController.profileModel != null
                ? Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 85,
                                width: Dimensions.WEB_MAX_WIDTH,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorLight,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              Container(
                                height: 85,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(.5),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.PADDING_SIZE_SMALL),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CustomImage(
                                            image: profileController
                                                .profileImageUrl,
                                            height: 72,
                                            width: 72,
                                          )),
                                    ),
                                    const SizedBox(
                                        width: Dimensions.PADDING_SIZE_SMALL),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            '${profileController.profileModel!.firstName!} ${profileController.profileModel!.lastName!}',
                                            style: poppinsBold.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeDefault,
                                              color: AppColors.primaryColor,
                                              // color: Theme.of(context)
                                              //     .primaryColor,
                                            )),
                                        const SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                        Text(
                                            profileController
                                                    .profileModel?.username ??
                                                '',
                                            style: poppinsBold.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeDefault,
                                                color: Theme.of(context)
                                                    .hintColor)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                child: Align(
                                    alignment:
                                        Get.find<LocalizationController>().isLtr
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                    child: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30, left: 35, right: 35),
                                        child: Image.asset(
                                            ImagePath.editAddress,
                                            height: 20,
                                            width: 20),
                                      ),
                                      onTap: () {
                                        Get.toNamed(
                                            Routes.getEditProfileRoute());
                                      },
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          ProfileButton(
                            title: 'email'.tr,
                            image: ImagePath.emailIconPng,
                            subTitle: profileController.profileModel!.email,
                          ),
                          ProfileButton(
                            title: 'phone_number'.tr,
                            image: ImagePath.phoneIcon,
                            subTitle: profileController.profileModel!.billing !=
                                    null
                                ? profileController.profileModel!.billing!.phone
                                : '',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: Dimensions.PADDING_SIZE_SMALL),
                            child: Container(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_SMALL),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                            ImagePath.profileAddressIconPng,
                                            height: 25,
                                            width: 25),
                                        const SizedBox(
                                            width: Dimensions
                                                .PADDING_SIZE_DEFAULT),
                                        Text('my_address'.tr,
                                            style: poppinsBold.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeDefault,
                                              color: AppColors.primaryColor,
                                              // color: Theme.of(context)
                                              //     .primaryColor,
                                            ),
                                            textAlign: TextAlign.justify),
                                        const SizedBox(
                                            width: Dimensions
                                                .PADDING_SIZE_DEFAULT),
                                      ],
                                    ),
                                    Expanded(
                                        child: Text(
                                      profileController.profileModel!.billing !=
                                              null
                                          ? '${profileController.profileModel!.billing!.address1} ${profileController.profileModel!.billing!.address2} '
                                              '${profileController.profileModel!.billing!.city} ${profileController.profileModel!.billing!.state}, ${profileController.profileModel!.billing!.country}'
                                          : '',
                                      style: poppinsBold.copyWith(
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: Theme.of(context).hintColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                    )),
                                  ],
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              if (Get.find<AuthController>().isLoggedIn()) {
                                Get.dialog(
                                    ConfirmationDialog(
                                        icon: ImagePath.deleteAccountDialogPng,
                                        description:
                                            'are_you_sure_to_delete_account'.tr,
                                        isLogOut: true,
                                        onYesPressed: () {
                                          Get.find<ProfileController>()
                                              .removeUser();

                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>()
                                              .clearCartList();
                                        }),
                                    useSafeArea: false);
                              } else {
                                Get.toNamed(Routes.getSignInRoute());
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                                  vertical: Dimensions.PADDING_SIZE_SMALL),
                              child: Container(
                                  padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(ImagePath.wishlistDeletePng,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          height: 25,
                                          width: 25),
                                      const SizedBox(
                                          width:
                                              Dimensions.PADDING_SIZE_DEFAULT),
                                      Text(
                                        'delete_account'.tr,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          color: AppColors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              Dimensions.PADDING_SIZE_DEFAULT),
                                    ],
                                  )),
                            ),
                          ),
                        ]),
                  )
                : const Center(child: CircularProgressIndicator())
            : NotLoggedInScreen();
      }),
    );
  }
}
