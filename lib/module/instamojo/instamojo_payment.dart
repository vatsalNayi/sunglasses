import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/models/instamojo_model.dart';
import 'package:sunglasses/routes/pages.dart';
import 'package:instamojo/instamojo.dart';

class InstamojoPaymentScreen extends StatefulWidget {
  const InstamojoPaymentScreen({Key? key}) : super(key: key);

  @override
  _InstamojoPaymentScreenState createState() => _InstamojoPaymentScreenState();
}

class _InstamojoPaymentScreenState extends State<InstamojoPaymentScreen>
    with SingleTickerProviderStateMixin {
  String _paymentResponse = 'Unknown';
  late bool isLive, apiCalled;
  final _formKey = GlobalKey<FormState>();
  final _data = InstamojoModel();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    isLive = false;
    apiCalled = false;
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(milliseconds: 500),
    )..repeat();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  startInstamojo() async {
    dynamic result = await Get.toNamed(
      Routes.instamojoSdkDemo, // set routename of instamojo screen
      arguments: {
        'isLive': false,
        'body': CreateOrderBody(
          buyerName: "xcode Technologies",
          buyerEmail: "ceo@gmail.com",
          buyerPhone: "123456789",
          amount: "100",
          description: "Test Payment",
        ),
        'orderCreationUrl': "https://test.instamojo.com/order",
      },
    );

    setState(() {
      _paymentResponse = result.toString();
    });
  }

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
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Builder(
                  builder: (context) => Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              initialValue: "Test Payments",
                              keyboardType: TextInputType.text,
                              decoration:
                                  const InputDecoration(labelText: 'Name'),
                              // ignore: missing_return
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the name';
                                }
                                return null;
                              },
                              onSaved: (val) =>
                                  setState(() => _data.name = val!),
                            ),
                            TextFormField(
                                initialValue: "test@test.com",
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    labelText: 'Email Id'),
                                // ignore: missing_return
                                validator: validateEmail,
                                onSaved: (val) =>
                                    setState(() => _data.email = val!)),
                            TextFormField(
                                initialValue: "1234567890",
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                decoration: const InputDecoration(
                                    labelText: 'Mobile Number'),
                                // ignore: missing_return
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the phone number.';
                                  } else if (value.length < 10) {
                                    return "Please enter a valid phone number";
                                  }
                                  return null;
                                },
                                onSaved: (val) =>
                                    setState(() => _data.number = val!)),
                            TextFormField(
                                initialValue: "33",
                                keyboardType: TextInputType.number,
                                maxLength: 4,
                                decoration:
                                    const InputDecoration(labelText: 'Amount'),
                                // ignore: missing_return
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the amount.';
                                  }
                                  return null;
                                },
                                onSaved: (val) =>
                                    setState(() => _data.amount = val!)),
                            TextFormField(
                                initialValue: "test description",
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    labelText: 'Description'),
                                onSaved: (val) =>
                                    setState(() => _data.description = val!)),
                            SwitchListTile(
                                title: Text(_data.isLive != null
                                    ? _data.isLive!
                                        ? 'Live Account'
                                        : 'Test Account'
                                    : 'Test Account'),
                                value: _data.isLive ?? false,
                                onChanged: (bool val) =>
                                    setState(() => _data.isLive = val)),
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    final form = _formKey.currentState;
                                    if (form!.validate()) {
                                      form.save();
                                      startInstamojo();
                                    }
                                  },
                                  child: apiCalled
                                      ? animation()
                                      : const Text('Make Payment')),
                            ),
                          ])))),
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Response: $_paymentResponse")),
          const SizedBox(
            height: 30,
          ),
        ],
      )),
    );
  }

  Widget animation() {
    return AnimatedBuilder(
      animation:
          CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildContainer(15 * _controller.value),
            _buildContainer(20 * _controller.value),
            _buildContainer(25 * _controller.value),
            _buildContainer(30 * _controller.value),
            _buildContainer(35 * _controller.value),
          ],
        );
      },
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            Theme.of(context).primaryColor.withOpacity(1 - _controller.value),
      ),
    );
  }

  String? validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value!)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }
}
