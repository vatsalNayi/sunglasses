import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/show_snackbar.dart';
import 'package:http/http.dart' as http;

class InstaMojoApi extends StatefulWidget {
  const InstaMojoApi({super.key});

  @override
  State<InstaMojoApi> createState() => _InstaMojoApiState();
}

bool isLoading = true;

class _InstaMojoApiState extends State<InstaMojoApi> {
  String selectedUrl = '';
  double progress = 0;

  // final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    createRequest(); // creating the http request
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? Text(
                  'Loading...',
                  style: TextStyle(fontSize: 25.0),
                )
              : InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.tryParse(selectedUrl),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    //
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    this.progress = progress / 100;
                  },
                  onUpdateVisitedHistory: (_, Uri? uri, __) {
                    String url = uri.toString();
                    debugPrint('on Update Visited History url: $url');
                    // uri contains newly loaded url
                    if (mounted) {
                      if (url.contains('http://www.example.com/redirect/')) {
                        String paymentRequestId =
                            uri?.queryParameters['payment_id'] ?? '';
                        debugPrint('Payment request id: $paymentRequestId');

                        // calling this method to check payment status
                        _checkPaymentStatus(paymentRequestId);
                      }
                      if (url.contains('https://www.google.com/')) {
                        // take the payment id parameter of the url
                        String paymentRequestId =
                            uri?.queryParameters['payment_id'] ?? '';
                        debugPrint('Payment request id: $paymentRequestId');

                        // calling this method to check payment status
                        _checkPaymentStatus(paymentRequestId);
                      }
                    }
                  },
                ),
          // ElevatedButton(
          //   onPressed: () {
          //     debugPrint('Make payment pressed');
          //   },
          //   child: Text('Make payment'),
          // ),
        ),
      ),
    );
  }

  Future createRequest() async {
    Map<String, String> body = {
      "amount": "40", //amount to be paid
      "purpose": "Advertising",
      "buyer_name": 'name',
      "email": 'email@gmail.com',
      "phone": '7276544474',
      "allow_repeated_payments": "true",
      "send_email": "false",
      "send_sms": "true",
      // "redirect_url": "https://www.google.com/",
      "redirect_url": "http://www.example.com/redirect/",

      /// Where to redirect after a successful payment.
      // "webhook": "https://www.google.com/",
      "webhook": "http://www.example.com/webhook/",
    };

    // firstly create payment request then take response from out request
    try {
      var resp = await http.post(
        Uri.parse('${InstamojoApiStrings.baseUrl}payment-requests/'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "X-Api-Key": "test_d4f7fbadbe275974c68649000f1", // replaced by my key
          "X-Auth-Token":
              "test_3db8d66fe866fb987c72b4a9c3a" // replaced by my key
        },
        body: body,
      );
      if (json.decode(resp.body)['success'] == true) {
//If request is successful take the longurl.
        setState(() {
          isLoading = false;
          selectedUrl =
              "${json.decode(resp.body)["payment_request"]['longurl'].toString()}?embed=form";
        });
        debugPrint(jsonDecode(resp.body)['message'].toString());
      } else {
        showSnackbar(
            title: 'Message',
            message: json.decode(resp.body)['message'].toString());
        debugPrint('${jsonDecode(resp.body)['message']}');
//If something is wrong with the data we provided to
//create the Payment_Request. For Example, the email is in incorrect format, the payment_Request creation will fail.
      }
    } catch (e) {
      debugPrint('catch error while create payment request: ${e.toString()}');
    }
  }

  // payment status method
  _checkPaymentStatus(String id) async {
    debugPrint("On Check Payment Status $id");
    try {
      var response = await http.get(
          Uri.parse("${InstamojoApiStrings.baseUrl}payments/$id/"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Api-Key": "test_d4f7fbadbe275974c68649000f1",
            "X-Auth-Token": "test_3db8d66fe866fb987c72b4a9c3a"
          });
      var realResponse = json.decode(response.body);
      log('Real response: ${realResponse}');
      if (realResponse['success'] == true) {
        if (realResponse["payment"]['status'] == 'Credit') {
          debugPrint('Payment is sucesssssssssssful');
          Get.back(result: realResponse);
          showSnackbar(
            title: 'Payment message',
            message: 'Payment success',
          );
        } else {
          debugPrint('Payment failed');
          showSnackbar(
            title: 'Payment message',
            message: 'Payment failed',
            isError: true,
          );
//payment failed or pending.
        }
      } else {
        debugPrint("PAYMENT STATUS FAILED");
      }
    } catch (e) {
      debugPrint('Catch error while check payment status: ${e.toString()}');
    }
  }
}
