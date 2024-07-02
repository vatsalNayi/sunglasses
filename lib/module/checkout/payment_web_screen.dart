import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class InstamojoWebPayment extends StatefulWidget {
  final String url;
  const InstamojoWebPayment({super.key, required this.url});

  @override
  State<InstamojoWebPayment> createState() => _InstamojoWebPaymentState();
}

class _InstamojoWebPaymentState extends State<InstamojoWebPayment> {
  bool isBackAllowed = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isBackAllowed,
      onPopInvoked: (didPop) {
        debugPrint('Did pop: $didPop');
        if (didPop) {
          if (Get.overlayContext != null) {
            Future.delayed(
              const Duration(milliseconds: 200),
              () {
                Navigator.of(Get.overlayContext!).pop();
              },
            );
          }
        }
      },
      child: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
            widget.url,
          ),
        ),
        initialOptions: InAppWebViewGroupOptions(
          ios: IOSInAppWebViewOptions(
            useOnNavigationResponse: true,
            isPagingEnabled: true,
            automaticallyAdjustsScrollIndicatorInsets: true,
          ),
          crossPlatform: InAppWebViewOptions(
            allowFileAccessFromFileURLs: true,
            allowUniversalAccessFromFileURLs: true,
            javaScriptCanOpenWindowsAutomatically: true,
            incognito: true,
            useOnLoadResource: true,
            useOnDownloadStart: true,
            javaScriptEnabled: true,
            useShouldInterceptAjaxRequest: true,
            useShouldOverrideUrlLoading: true,
            useShouldInterceptFetchRequest: true,
          ),
        ),
        shouldOverrideUrlLoading: (controller, navAction) async {
          log('Current URL is: ${navAction.request}');
          if (navAction.request.url!.host.contains('www.google.com')) {
            setState(() {
              isBackAllowed = true;
            });
            Get.back(
              result: {
                'payment_request_id': navAction
                    .request.url!.queryParameters['payment_request_id'],
                'payment_status':
                    navAction.request.url!.queryParameters['payment_status'],
                'payment_id':
                    navAction.request.url!.queryParameters['payment_id'],
              },
            );
          }
          return NavigationActionPolicy.ALLOW;
        },
      ),
    );
  }
}
