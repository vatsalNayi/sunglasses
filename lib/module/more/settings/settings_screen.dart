import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/controller/localization_controller.dart';
import 'package:sunglasses/core/utils/app_constants.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/custom_appbar.dart';
import 'package:sunglasses/models/language_model.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:sunglasses/module/more/profile/profile_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
  WidgetBuilder builder = buildProgressIndicator;

  @override
  void initState() {
    super.initState();

    if (_isLoggedIn && Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'settings'.tr,
          // isBackButtonExist: true,
        ),
        body:
            // RateMyAppBuilder(
            //     builder: builder,
            //     onInitialized: (context, rateMyApp) {
            //       setState(() => builder = (context) =>
            SingleChildScrollView(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<ProfileController>(builder: (profileController) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  // InkWell(
                  //   onTap: () {
                  //     Get.find<ThemeController>().toggleTheme();
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: Dimensions.PADDING_SIZE_DEFAULT),
                  //     child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               Image.asset(ImagePath.theme,
                  //                   height: 25, width: 25),
                  //               const SizedBox(
                  //                   width: Dimensions.PADDING_SIZE_LARGE),
                  //               Text("theme".tr,
                  //                   style: robotoRegular.copyWith(
                  //                       fontSize: Dimensions.fontSizeLarge)),
                  //             ],
                  //           ),
                  //           GetBuilder<ThemeController>(
                  //               builder: (themeController) {
                  //             return SizedBox(
                  //               height: 20,
                  //               child: CupertinoSwitch(
                  //                   //trackColor: Colors.red,
                  //                   //thumbColor: Colors.red,
                  //                   activeColor:
                  //                       Theme.of(context).primaryColorDark,
                  //                   value: themeController.darkTheme,
                  //                   onChanged: (value) {
                  //                     themeController.toggleTheme();
                  //                   }),
                  //             );
                  //           }),
                  //         ]),
                  //   ),
                  // ),
                  const SizedBox(height: 5),
                  GetBuilder<LocalizationController>(
                      builder: (localizationController) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(ImagePath.languageSettings,
                                  height: 25, width: 25),
                              const SizedBox(
                                  width: Dimensions.PADDING_SIZE_LARGE),
                              Text("language".tr,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                  ).copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                            width: 120,
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    isExpanded: true,
                                    value: AppConstants.languages[
                                        localizationController.selectedIndex],
                                    icon: const Icon(Icons.arrow_drop_down),
                                    items: AppConstants.languages
                                        .map<DropdownMenuItem<LanguageModel>>(
                                            (LanguageModel? value) {
                                      return DropdownMenuItem<LanguageModel>(
                                        value: value,
                                        child: Text(
                                          value!.languageName!,
                                          style: TextStyle(
                                            color: AppConstants
                                                        .languages[
                                                            localizationController
                                                                .selectedIndex]!
                                                        .languageName ==
                                                    value.languageName
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!
                                                    .color,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (dynamic newValue) {
                                      localizationController.setSelectIndex(
                                          AppConstants.languages
                                              .indexOf(newValue));
                                      localizationController.setLanguage(Locale(
                                        AppConstants
                                            .languages[localizationController
                                                .selectedIndex]!
                                            .languageCode!,
                                        AppConstants
                                            .languages[localizationController
                                                .selectedIndex]!
                                            .countryCode,
                                      ));
                                    })),
                          )
                        ]);
                  }),
                ]);
          }),
        ));
    //     }
    // ),
    //);
  }
}

Widget buildProgressIndicator(BuildContext context) =>
    const Center(child: CircularProgressIndicator());
