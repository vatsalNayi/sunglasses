import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/show_snackbar.dart';
import 'package:sunglasses/data/repository/config_repo.dart';
import 'package:sunglasses/data/services/api_checker.dart';
import 'package:sunglasses/models/config_model.dart';
import 'package:sunglasses/models/payment_model.dart';
import 'package:sunglasses/models/settings_model.dart';
import 'package:sunglasses/models/tax_model.dart';
import 'package:intl/intl.dart';

class ConfigController extends GetxController implements GetxService {
  final ConfigRepo configRepo;
  ConfigController({required this.configRepo});

  ConfigModel? _config;
  SettingsModel? _settings;
  List<SettingsModel>? _taxSettings;
  DateTime _currentTime = DateTime.now();
  bool _firstTimeConnectionCheck = true;
  List<TaxModel>? _taxClassList;
  static List<PaymentModel> _payments = [];

  ConfigModel? get config => _config;
  SettingsModel? get settings => _settings;
  DateTime get currentTime => _currentTime;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  List<TaxModel>? get taxClassList => _taxClassList;
  List<PaymentModel> get payment => _payments;

  Future<bool> getGeneralSettings() async {
    debugPrint('General_Settings_Api_Call');
    Response _response = await configRepo.getGeneralSettings();
    debugPrint('settings_response');
    debugPrint(_response.statusCode.toString());
    log(_response.body.toString());
    bool _isSuccess = false;
    if (_response.statusCode == 200) {
      debugPrint('App_settings');
      // debugPrint(_response.body['app_settings']);
      // debugPrint(_response.body['app_settings'].runtimeType.toString());
      //_generalSettings = [];
      _settings = SettingsModel.fromJson(_response.body);
      _response = await configRepo.getConfigData();
      _config = ConfigModel.fromJson(_response.body);
      debugPrint('----config--->${_config!.toJson()}');
      debugPrint(_response.body['app_settings']);
      setPayment();
      _isSuccess = true;
    } else {
      showCustomSnackBar(_response.statusText);
    }
    update();
    return _isSuccess;
  }

  String? getDefaultCountry() {
    return _settings?.generalSettings!.defaultCountry!.value != null
        ? _settings!.generalSettings!.defaultCountry!.value
            .toString()
            .substring(0, 2)
        : null;
  }

  bool calculateTax() {
    return _settings?.generalSettings?.woocommerceCalcTaxes?.value == 'yes';
  }

  bool enabledCoupon() {
    return _settings!.generalSettings!.woocommerceEnableCoupons!.value == 'yes';
  }

  String getCurrency() {
    // if (_settings != null &&
    //     _settings!.generalSettings != null &&
    //     _settings!.generalSettings!.woocommerceCurrency != null &&
    //     _settings!.generalSettings!.woocommerceCurrency!.value != null) {}
    return _settings?.generalSettings?.woocommerceCurrency?.value.toString() ??
        '';
  }

  String getCurrencyPosition() {
    return _settings?.generalSettings?.woocommerceCurrencyPos?.value
            .toString() ??
        '';
  }

  String thousandSeparator() {
    return _settings?.generalSettings?.woocommercePriceThousandSep?.value
            .toString() ??
        '';
  }

  int digitAfterDecimal() {
    try {
      final value =
          _settings?.generalSettings?.woocommercePriceNumDecimals?.value;
      return int.tryParse(value ?? '') ?? 0;
    } catch (e) {
      debugPrint('Format exception: $e');
      return 0;
    }
    // return int.parse(
    //     _settings!.generalSettings!.woocommercePriceNumDecimals!.value!);
  }

  Future<bool> initSharedData() {
    return configRepo.initSharedData();
  }

  bool isRestaurantClosed() {
    DateTime _open = DateFormat('hh:mm').parse('');
    DateTime _close = DateFormat('hh:mm').parse('');
    DateTime _openTime = DateTime(_currentTime.year, _currentTime.month,
        _currentTime.day, _open.hour, _open.minute);
    DateTime _closeTime = DateTime(_currentTime.year, _currentTime.month,
        _currentTime.day, _close.hour, _close.minute);
    if (_closeTime.isBefore(_openTime)) {
      _closeTime = _closeTime.add(const Duration(days: 1));
    }
    if (_currentTime.isAfter(_openTime) && _currentTime.isBefore(_closeTime)) {
      return false;
    } else {
      return true;
    }
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  Future<void> getTaxSettings() async {
    if (_taxSettings == null) {
      Response response = await configRepo.getTaxSettings();
      if (response.statusCode == 200) {
        _taxSettings = [];
        response.body.forEach(
            (settings) => _taxSettings!.add(SettingsModel.fromJson(settings)));
      } else {
        showCustomSnackBar(response.statusText);
      }
      update();
    }
  }

  //Tax Settings
  bool priceIncludeTax() {
    return _settings!.taxSettings!.woocommercePricesIncludeTax == 'yes';
  }

  String? taxBasedOn() {
    return _settings!.taxSettings!.woocommerceTaxBasedOn;
  }

  String? shippingTaxClass() {
    return _settings!.taxSettings!.woocommerceShippingTaxClass;
  }

  bool taxRoundAtSubtotal() {
    return _settings!.taxSettings!.woocommerceTaxRoundAtSubtotal == 'yes';
  }

  bool displayPriceExcludeTax() {
    return _settings!.taxSettings!.woocommerceTaxDisplayShop == 'excl';
  }

  bool displayCartPriceExcludeTax() {
    return _settings!.taxSettings!.woocommerceTaxDisplayCart == 'excl';
  }

  //Account Settings

  bool enabledGuestCheckout() {
    return _settings!.accountSettings!.woocommerceEnableGuestCheckout == 'yes';
  }

  bool checkoutLoginReminder() {
    return _settings!.accountSettings!.woocommerceEnableCheckoutLoginReminder ==
        'yes';
  }

  bool signUpFromCheckout() {
    return _settings!
            .accountSettings!.woocommerceEnableSignupAndLoginFromCheckout ==
        'yes';
  }

  //Product Settings
  bool isReviewEnabled() {
    return _settings!.productSettings!.woocommerceEnableReviews == 'yes';
  }

  bool canReviewProduct() {
    return _settings!.productSettings!.woocommerceEnableReviewRating == 'yes';
  }

  bool stockManagement() {
    return _settings!.productSettings!.woocommerceManageStock == 'yes';
  }

  bool hideNoStockItems() {
    return _settings!.productSettings!.woocommerceHideOutOfStockItems == 'yes';
  }

  // Shipping Settings
  bool enabledShipping() {
    return _settings!.shippingSettings!.woocommerceEnableShippingCalc == 'yes';
  }

  bool requireAddress() {
    return _settings!
            .shippingSettings!.woocommerceShippingCostRequiresAddress ==
        'yes';
  }

  String? shippingDestination() {
    return _settings!.shippingSettings!.woocommerceShipToDestination;
  }

  void getTaxClasses() async {
    if (_taxClassList == null) {
      Response _response = await configRepo.getTaxClass();
      if (_response.statusCode == 200) {
        _taxClassList = [];
        _response.body
            .forEach((tax) => _taxClassList!.add(TaxModel.fromJson(tax)));
      } else {
        ApiChecker.checkApi(_response);
      }
      update();
    }
  }

  void setPayment() {
    _payments = [];
    if (_settings!.paymentSettings!.codStatus == 1) {
      _payments.add(
        PaymentModel(
          paymentType: PaymentType.cod,
          icon: ImagePath.cod,
          title: 'cod',
          description: 'cash_on_delivery',
        ),
      );
    }

    if (_settings!.paymentSettings!.digitalPaymentStatus == 1) {
      if (_settings!.paymentSettings!.paypal!.status == 1) {
        _payments.add(
          PaymentModel(
            paymentType: PaymentType.paypal,
            icon: ImagePath.paypal,
            title: 'PayPal',
            description: 'pay_via_paypal',
            clientId: _settings!.paymentSettings!.paypal!.clientId,
            secretKey: _settings!.paymentSettings!.paypal!.secretKey,
          ),
        );
      }

      if (_settings!.paymentSettings!.stripe!.status == 1) {
        _payments.add(
          PaymentModel(
            paymentType: PaymentType.stripe,
            icon: ImagePath.stripe,
            title: 'Stripe',
            description: 'pay_via_stripe',
            publishableKey: _settings!.paymentSettings!.stripe!.publishableKey,
            secretKey: _settings!.paymentSettings!.stripe!.secretKey,
          ),
        );
      }

      if (_settings!.paymentSettings!.razorPay!.status == 1) {
        _payments.add(
          PaymentModel(
            paymentType: PaymentType.razorpay,
            icon: ImagePath.razorpay,
            title: 'Razorpay',
            description: 'pay_via_razorpay',
            keyId: _settings!.paymentSettings!.razorPay!.keyId,
            secretKey: _settings!.paymentSettings!.razorPay!.secretKey,
          ),
        );
      }

      if (_settings!.paymentSettings!.paystack!.status == 1) {
        _payments.add(
          PaymentModel(
            paymentType: PaymentType.paystack,
            icon: ImagePath.paystack,
            title: 'Paystack',
            description: 'pay_via_paystack',
            publicKey: _settings!.paymentSettings!.paystack!.publicKey,
            secretKey: _settings!.paymentSettings!.paystack!.secretKey,
          ),
        );
      }

      if (_settings!.paymentSettings!.flutterwave!.status == 1) {
        _payments.add(
          PaymentModel(
            paymentType: PaymentType.flutterwave,
            icon: ImagePath.flutterwave,
            title: 'Flutterwave',
            description: 'pay_via_flutterwave',
            publicKey: _settings!.paymentSettings!.flutterwave!.publicKey,
            secretKey: _settings!.paymentSettings!.flutterwave!.secretKey,
            encryptionKey:
                _settings!.paymentSettings!.flutterwave!.encryptionKey,
          ),
        );
      }
      if (_settings!.paymentSettings!.instamojo!.status == 1) {
        _payments.add(
          PaymentModel(
            paymentType: PaymentType.instamojo,
            icon: ImagePath.cod,
            title: 'Digital Payment',
            description: 'instamojo',
            apiKey: _settings!.paymentSettings!.instamojo!.apiKey,
            authToken: _settings!.paymentSettings!.instamojo!.authToken,
            clientId: _settings!.paymentSettings!.instamojo!.clientId,
            secretKey: _settings!.paymentSettings!.instamojo!.secretKey,
          ),
        );
      }
    }
  }
}
