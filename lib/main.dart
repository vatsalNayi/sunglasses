import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunglasses/controller/localization_controller.dart';
import 'package:sunglasses/controller/theme_controller.dart';
import 'package:sunglasses/core/utils/app_constants.dart';
import 'package:sunglasses/core/utils/messages.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/helper/di_container.dart' as di;
import 'package:sunglasses/module/splash/splash_page.dart';
import 'package:sunglasses/routes/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (GetPlatform.isIOS || GetPlatform.isAndroid) {
    HttpOverrides.global = MyHttpOverrides();
  }

  Map<String, Map<String, String>> _languages = await di.init();
  runApp(MyApp(
    languages: _languages,
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;
  const MyApp({super.key, this.languages});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) {
            return ScreenUtilInit(
              useInheritedMediaQuery: true,
              designSize: const Size(430, 932),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Sunglasses',
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: AppColors.primaryColor,
                    ),
                    useMaterial3: true,
                    primaryColor: AppColors.primaryColor,
                  ),
                  locale: localizeController.locale,
                  translations: Messages(languages: languages),
                  fallbackLocale: Locale(
                      AppConstants.languages[0]!.languageCode!,
                      AppConstants.languages[0]!.countryCode),
                  initialRoute: Routes.initial,
                  getPages: AppPages.pages,
                  // home: SplashPage(),
                );
              },
            );
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
