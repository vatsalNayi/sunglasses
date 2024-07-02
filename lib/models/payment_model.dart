enum PaymentType {
  cod,
  paypal,
  stripe,
  razorpay,
  paystack,
  paytm,
  flutterwave,
  instamojo,
}

class PaymentModel {
  PaymentType paymentType;
  String icon;
  String title;
  String description;
  String? clientId;
  String? secretKey;
  String? publishableKey;
  String? keyId;
  String? publicKey;
  String? merchantKey;
  String? merchantMid;
  String? merchantWebsite;
  String? encryptionKey;
  String? apiKey;
  String? authToken;

  PaymentModel({
    required this.paymentType,
    required this.icon,
    required this.title,
    required this.description,
    this.clientId,
    this.secretKey,
    this.publishableKey,
    this.keyId,
    this.publicKey,
    this.merchantKey,
    this.merchantMid,
    this.merchantWebsite,
    this.encryptionKey,
    this.apiKey,
    this.authToken,
  });
}
