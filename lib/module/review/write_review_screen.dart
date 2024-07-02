import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/custom_button_comp.dart';
import 'package:sunglasses/custom_widgets/custom_textfield.dart';
import 'package:sunglasses/custom_widgets/show_snackbar.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:sunglasses/module/home/products/controller/product_controller.dart';
import 'package:sunglasses/module/home/products/models/review_model.dart';
import 'package:sunglasses/module/more/profile/profile_controller.dart';

class WriteReviewScreen extends StatefulWidget {
  final int? productId;

  const WriteReviewScreen({Key? key, this.productId}) : super(key: key);
  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  @override
  void initState() {
    super.initState();
    //Get.find<ProductController>().getProductReviews(widget.lineItems.productId, formWriteReview:  true, userMail: Get.find<ProfileController>().profileModel.email);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<ProductController>().emptyFormData();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('write_a_review_title'.tr),
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Get.find<ProductController>().emptyFormData();
              Get.back();
            },
            child: Container(
              width: 35,
              height: 35,
              margin: EdgeInsets.only(left: 10.w),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 248, 248, 248),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              ),
            ),
          ),
        ),
        body: GetBuilder<ProductController>(builder: (productController) {
          return !productController.isInitLoading
              ? Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: SizedBox(
                      width: Dimensions.WEB_MAX_WIDTH,
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('write_a_review'.tr,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                  ).copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context).primaryColor,
                                  )),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding: const EdgeInsets.all(
                                                  Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                              child: InkWell(
                                                onTap: () {
                                                  productController
                                                      .setRatingIndex(index);
                                                },
                                                child: (index <=
                                                        productController
                                                            .ratingIndex)
                                                    ? Image.asset(
                                                        ImagePath.starYellow)
                                                    : Image.asset(
                                                        ImagePath.starSilver),
                                              ));
                                        }),
                                  ),
                                  const SizedBox(
                                      width: Dimensions.PADDING_SIZE_DEFAULT),
                                  Text(
                                      '${productController.ratingIndex != -1 ? productController.ratingIndex + 1 : 0}/5',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                      ).copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Colors.grey,
                                      )),
                                  const SizedBox(
                                      height: Dimensions.PADDING_SIZE_DEFAULT),
                                ],
                              ),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                              Text('write_your_review'.tr,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                  ).copyWith(
                                      fontSize: Dimensions.fontSizeDefault)),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                              SizedBox(
                                height: 200,
                                child: CustomTextfield(
                                  controller:
                                      productController.reviewController,
                                  maxLines: 8,
                                  capitalization: TextCapitalization.sentences,
                                  isEnabled: true,
                                  hintText: 'write_your_review_here'.tr,
                                  fillColor: Theme.of(context)
                                      .disabledColor
                                      .withOpacity(0.05),
                                ),
                              ),
                              Get.find<AuthController>().isLoggedIn()
                                  ? const SizedBox()
                                  : SizedBox(
                                      child: CustomTextfield(
                                        controller: productController
                                            .reviewerNameController,
                                        maxLines: 1,
                                        inputType: TextInputType.name,
                                        isEnabled: true,
                                        hintText: 'reviewer_name'.tr,
                                        fillColor: Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.05),
                                      ),
                                    ),
                              Get.find<AuthController>().isLoggedIn()
                                  ? const SizedBox()
                                  : const SizedBox(
                                      height: Dimensions.PADDING_SIZE_DEFAULT),
                              Get.find<AuthController>().isLoggedIn()
                                  ? const SizedBox()
                                  : SizedBox(
                                      child: CustomTextfield(
                                        controller: productController
                                            .reviewerEmailController,
                                        maxLines: 1,
                                        isEnabled: true,
                                        inputType: TextInputType.emailAddress,
                                        hintText: 'reviewer_email'.tr,
                                        fillColor: Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.05),
                                      ),
                                    ),
                              Get.find<AuthController>().isLoggedIn()
                                  ? const SizedBox()
                                  : const SizedBox(
                                      height: Dimensions.PADDING_SIZE_DEFAULT),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  !productController.isLoading
                                      ? CustomButtonSec(
                                          radius: Dimensions.RADIUS_LARGE,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              30,
                                          buttonText: productController.isUpdate
                                              ? 'update_review'.tr
                                              : 'submit_review'.tr,
                                          onPressed: () {
                                            if (productController.ratingIndex ==
                                                -1) {
                                              showCustomSnackBar(
                                                  'give_a_rating'.tr);
                                            } else if (productController
                                                .reviewController
                                                .text
                                                .isEmpty) {
                                              showCustomSnackBar(
                                                  'write_a_review'.tr);
                                            } else if (!Get.find<AuthController>()
                                                    .isLoggedIn() &&
                                                productController
                                                    .reviewerNameController
                                                    .text
                                                    .isEmpty) {
                                              showCustomSnackBar(
                                                  'enter_your_name'.tr);
                                            } else if (!Get.find<AuthController>()
                                                    .isLoggedIn() &&
                                                productController
                                                    .reviewerEmailController
                                                    .text
                                                    .isEmpty) {
                                              showCustomSnackBar(
                                                  'enter_email_address'.tr);
                                            } else if (!Get.find<AuthController>()
                                                    .isLoggedIn() &&
                                                !productController
                                                    .reviewerEmailController
                                                    .text
                                                    .contains('@')) {
                                              showCustomSnackBar(
                                                  'invalid_email_address'.tr);
                                            } else if (!Get.find<AuthController>()
                                                    .isLoggedIn() &&
                                                !GetUtils.isEmail(
                                                    productController.reviewerEmailController.text)) {
                                              showCustomSnackBar(
                                                  'invalid_email_address'.tr);
                                            } else {
                                              SubmitReviewModel review =
                                                  SubmitReviewModel(
                                                productId: widget.productId,
                                                review: productController
                                                    .reviewController.text,
                                                reviewer: Get.find<
                                                            AuthController>()
                                                        .isLoggedIn()
                                                    ? Get.find<
                                                            ProfileController>()
                                                        .profileModel!
                                                        .firstName
                                                    : productController
                                                        .reviewerNameController
                                                        .text,
                                                reviewerEmail: Get.find<
                                                            AuthController>()
                                                        .isLoggedIn()
                                                    ? Get.find<
                                                            ProfileController>()
                                                        .profileModel!
                                                        .email
                                                    : productController
                                                        .reviewerEmailController
                                                        .text,
                                                rating: productController
                                                        .ratingIndex +
                                                    1,
                                                status: 'hold',
                                              );
                                              if (productController.isUpdate) {
                                                productController.updateReview(
                                                    review,
                                                    productController.reviewId);
                                              } else {
                                                productController
                                                    .submitReview(review);
                                              }
                                              // updateReview();
                                            }
                                          },
                                        )
                                      : const Center(
                                          child: CupertinoActivityIndicator(),
                                        ),
                                ],
                              )
                            ]),
                      )),
                )
              : const Center(
                  child: CupertinoActivityIndicator(),
                );
        }),
      ),
    );
  }
}
