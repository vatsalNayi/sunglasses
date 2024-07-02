import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instamojo/instamojo.dart';

class InstamojoSdkDemo extends StatefulWidget {
  final CreateOrderBody? body;
  final String? orderCreationUrl;
  final bool? isLive;

  const InstamojoSdkDemo(
      {Key? key, this.body, this.orderCreationUrl, this.isLive = false})
      : super(key: key);

  @override
  _InstamojoSdkDemoState createState() => _InstamojoSdkDemoState();
}

class _InstamojoSdkDemoState extends State<InstamojoSdkDemo>
    implements InstamojoPaymentStatusListener {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instamojo Flutter'),
      ),
      body: SafeArea(
        child: Instamojo(
          isConvenienceFeesApplied: false,
          listener: this,
          environment: Get.arguments['isLive']
              ? Environment.PRODUCTION
              : Environment.TEST,
          apiCallType: ApiCallType.createOrder(
              createOrderBody: Get.arguments['body'],
              orderCreationUrl: Get.arguments['orderCreationUrl']),
          stylingDetails: StylingDetails(
              buttonStyle: ButtonStyling(
                  buttonColor: Colors.amber,
                  buttonTextStyle: const TextStyle(
                    color: Colors.black,
                  )),
              listItemStyle: ListItemStyle(
                  borderColor: Colors.grey,
                  textStyle: const TextStyle(color: Colors.black, fontSize: 18),
                  subTextStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14)),
              loaderColor: Colors.amber,
              inputFieldTextStyle: InputFieldTextStyle(
                  textStyle: const TextStyle(color: Colors.black, fontSize: 18),
                  hintTextStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14),
                  labelTextStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14)),
              alertStyle: AlertStyle(
                headingTextStyle:
                    const TextStyle(color: Colors.black, fontSize: 14),
                messageTextStyle:
                    const TextStyle(color: Colors.black, fontSize: 12),
                positiveButtonTextStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 10),
                negativeButtonTextStyle:
                    const TextStyle(color: Colors.amber, fontSize: 10),
              )),
        ),
      ),
    );
  }

  @override
  void paymentStatus({Map<String, String>? status}) {
    Navigator.pop(context, status);
  }
}

print(String message) {
  debugPrint('print: ${message}');
}
