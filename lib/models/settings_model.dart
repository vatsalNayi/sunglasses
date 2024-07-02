import 'package:flutter/foundation.dart';

class SettingsModel {
  GeneralSettings? generalSettings;
  TaxSettings? taxSettings;
  ProductSettings? productSettings;
  ShippingSettings? shippingSettings;
  AccountSettings? accountSettings;
  ActivityMessages? activityMessages;
  AppSettings? appSettings;
  BusinessSettings? businessSettings;
  PaymentSettings? paymentSettings;

  SettingsModel(
      {this.generalSettings,
      this.taxSettings,
      this.productSettings,
      this.shippingSettings,
      this.accountSettings,
      this.activityMessages,
      this.appSettings,
      this.businessSettings,
      this.paymentSettings});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    generalSettings = json['general_settings'] != null
        ? GeneralSettings.fromJson(json['general_settings'])
        : null;
    taxSettings = json['tax_settings'] != null
        ? TaxSettings.fromJson(json['tax_settings'])
        : null;
    productSettings = json['product_settings'] != null
        ? ProductSettings.fromJson(json['product_settings'])
        : null;
    shippingSettings = json['shipping_settings'] != null
        ? ShippingSettings.fromJson(json['shipping_settings'])
        : null;
    accountSettings = json['account_settings'] != null
        ? AccountSettings.fromJson(json['account_settings'])
        : null;
    activityMessages = activityMessages = json['activity_messages'] != null
        ? ActivityMessages.fromJson(json['activity_messages'])
        : null;
    if (json['app_settings'].toString() == '[]') {
      appSettings = null;
      debugPrint('jibon_bche_gesa');
    } else {
      appSettings = json['app_settings'] == null
          ? null
          : AppSettings.fromJson(json['app_settings']);
    }
    // appSettings = json['app_settings'] != null ? new AppSettings.fromJson(json['app_settings']) : null;
    businessSettings = json['business_settings'] != null
        ? BusinessSettings.fromJson(json['business_settings'])
        : null;
    paymentSettings = json['payment_settings'] != null
        ? PaymentSettings.fromJson(json['payment_settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (generalSettings != null) {
      data['general_settings'] = generalSettings!.toJson();
    }
    if (taxSettings != null) {
      data['tax_settings'] = taxSettings!.toJson();
    }
    if (productSettings != null) {
      data['product_settings'] = productSettings!.toJson();
    }
    if (shippingSettings != null) {
      data['shipping_settings'] = shippingSettings!.toJson();
    }
    if (accountSettings != null) {
      data['account_settings'] = accountSettings!.toJson();
    }

    return data;
  }
}

class GeneralSettings {
  String? storeAddress;
  String? storeAddress2;
  String? storeCity;
  String? storeCountry;
  String? storeState;
  String? storePostcode;
  WoocommerceCalcTaxes? woocommerceCalcTaxes;
  WoocommerceCalcTaxes? woocommerceEnableCoupons;
  DefaultCountry? defaultCountry;
  WoocommerceCurrency? woocommerceCurrency;
  WoocommerceCurrencyPos? woocommerceCurrencyPos;
  WoocommercePriceThousandSep? woocommercePriceThousandSep;
  WoocommercePriceThousandSep? woocommercePriceNumDecimals;

  GeneralSettings(
      {this.storeAddress,
      this.storeAddress2,
      this.storeCity,
      this.storeCountry,
      this.storeState,
      this.storePostcode,
      this.woocommerceCalcTaxes,
      this.woocommerceEnableCoupons,
      this.defaultCountry,
      this.woocommerceCurrency,
      this.woocommerceCurrencyPos,
      this.woocommercePriceThousandSep,
      this.woocommercePriceNumDecimals});

  GeneralSettings.fromJson(Map<String, dynamic> json) {
    storeAddress = json['store_address'];
    storeAddress2 = json['store_address_2'];
    storeCity = json['store_city'];
    storeCountry = json['store_country'];
    storeState = json['store_state'];
    storePostcode = json['store_postcode'];
    woocommerceCalcTaxes = json['woocommerce_calc_taxes'] != null
        ? WoocommerceCalcTaxes.fromJson(json['woocommerce_calc_taxes'])
        : null;
    woocommerceEnableCoupons = json['woocommerce_enable_coupons'] != null
        ? WoocommerceCalcTaxes.fromJson(json['woocommerce_enable_coupons'])
        : null;
    defaultCountry = json['default_country'] != null
        ? DefaultCountry.fromJson(json['default_country'])
        : null;
    woocommerceCurrency = json['woocommerce_currency'] != null
        ? WoocommerceCurrency.fromJson(json['woocommerce_currency'])
        : null;
    woocommerceCurrencyPos = json['woocommerce_currency_pos'] != null
        ? WoocommerceCurrencyPos.fromJson(json['woocommerce_currency_pos'])
        : null;
    woocommercePriceThousandSep = json['woocommerce_price_thousand_sep'] != null
        ? WoocommercePriceThousandSep.fromJson(
            json['woocommerce_price_thousand_sep'])
        : null;
    woocommercePriceNumDecimals = json['woocommerce_price_num_decimals'] != null
        ? WoocommercePriceThousandSep.fromJson(
            json['woocommerce_price_num_decimals'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_address'] = storeAddress;
    data['store_address_2'] = storeAddress2;
    data['store_city'] = storeCity;
    data['store_country'] = storeCountry;
    data['store_state'] = storeState;
    data['store_postcode'] = storePostcode;
    if (woocommerceCalcTaxes != null) {
      data['woocommerce_calc_taxes'] = woocommerceCalcTaxes!.toJson();
    }
    if (woocommerceEnableCoupons != null) {
      data['woocommerce_enable_coupons'] = woocommerceEnableCoupons!.toJson();
    }
    if (defaultCountry != null) {
      data['default_country'] = defaultCountry!.toJson();
    }
    if (woocommerceCurrency != null) {
      data['woocommerce_currency'] = woocommerceCurrency!.toJson();
    }
    if (woocommerceCurrencyPos != null) {
      data['woocommerce_currency_pos'] = woocommerceCurrencyPos!.toJson();
    }
    if (woocommercePriceThousandSep != null) {
      data['woocommerce_price_thousand_sep'] =
          woocommercePriceThousandSep!.toJson();
    }
    if (woocommercePriceNumDecimals != null) {
      data['woocommerce_price_num_decimals'] =
          woocommercePriceNumDecimals!.toJson();
    }
    return data;
  }
}

class WoocommerceCalcTaxes {
  String? id;
  String? label;
  String? value;

  WoocommerceCalcTaxes({this.id, this.label, this.value});

  WoocommerceCalcTaxes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class DefaultCountry {
  String? id;
  String? label;
  String? value;

  DefaultCountry({this.id, this.label, this.value});

  DefaultCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class WoocommerceCurrency {
  String? id;
  String? label;
  String? defaultC;
  String? value;

  WoocommerceCurrency({
    this.id,
    this.label,
    this.defaultC,
    this.value,
  });

  WoocommerceCurrency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    defaultC = json['default'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['default'] = defaultC;
    data['value'] = value;
    return data;
  }
}

class WoocommerceCurrencyPos {
  String? id;
  String? label;
  String? defaultPos;
  String? value;
  CurrencyPositionOptions? options;

  WoocommerceCurrencyPos(
      {this.id, this.label, this.defaultPos, this.value, this.options});

  WoocommerceCurrencyPos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    defaultPos = json['default'];
    value = json['value'];
    options = json['options'] != null
        ? CurrencyPositionOptions.fromJson(json['options'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['default'] = defaultPos;
    data['value'] = value;
    if (options != null) {
      data['options'] = options!.toJson();
    }
    return data;
  }
}

class CurrencyPositionOptions {
  String? left;
  String? right;
  String? leftSpace;
  String? rightSpace;

  CurrencyPositionOptions(
      {this.left, this.right, this.leftSpace, this.rightSpace});

  CurrencyPositionOptions.fromJson(Map<String, dynamic> json) {
    left = json['left'];
    right = json['right'];
    leftSpace = json['left_space'];
    rightSpace = json['right_space'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['left'] = left;
    data['right'] = right;
    data['left_space'] = leftSpace;
    data['right_space'] = rightSpace;
    return data;
  }
}

class WoocommercePriceThousandSep {
  String? id;
  String? label;
  String? defaultValue;
  String? value;

  WoocommercePriceThousandSep(
      {this.id, this.label, this.defaultValue, this.value});

  WoocommercePriceThousandSep.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    defaultValue = json['default'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['default'] = defaultValue;
    data['value'] = value;
    return data;
  }
}

class TaxSettings {
  List<String>? woocommerceTaxClasses;
  String? woocommerceTaxBasedOn;
  String? woocommercePricesIncludeTax;
  String? woocommerceTaxRoundAtSubtotal;
  String? woocommerceTaxDisplayCart;
  String? woocommerceTaxTotalDisplay;
  String? woocommerceShippingTaxClass;
  String? woocommerceTaxDisplayShop;
  List<Null>? taxRates;

  TaxSettings(
      {this.woocommerceTaxClasses,
      this.woocommerceTaxBasedOn,
      this.woocommercePricesIncludeTax,
      this.woocommerceTaxRoundAtSubtotal,
      this.woocommerceTaxDisplayCart,
      this.woocommerceTaxTotalDisplay,
      this.woocommerceShippingTaxClass,
      this.woocommerceTaxDisplayShop,
      this.taxRates});

  TaxSettings.fromJson(Map<String, dynamic> json) {
    woocommerceTaxClasses = json['woocommerce_tax_classes'].cast<String>();
    woocommerceTaxBasedOn = json['woocommerce_tax_based_on'];
    woocommercePricesIncludeTax = json['woocommerce_prices_include_tax'];
    woocommerceTaxRoundAtSubtotal = json['woocommerce_tax_round_at_subtotal'];
    woocommerceTaxDisplayCart = json['woocommerce_tax_display_cart'];
    woocommerceTaxTotalDisplay = json['woocommerce_tax_total_display'];
    woocommerceShippingTaxClass = json['woocommerce_shipping_tax_class'];
    woocommerceTaxDisplayShop = json['woocommerce_tax_display_shop'];
    if (json['tax_rates'] != null) {
      taxRates = <Null>[];
      // json['tax_rates'].forEach((v) { taxRates.add(new Null); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['woocommerce_tax_classes'] = woocommerceTaxClasses;
    data['woocommerce_tax_based_on'] = woocommerceTaxBasedOn;
    data['woocommerce_prices_include_tax'] = woocommercePricesIncludeTax;
    data['woocommerce_tax_round_at_subtotal'] = woocommerceTaxRoundAtSubtotal;
    data['woocommerce_tax_display_cart'] = woocommerceTaxDisplayCart;
    data['woocommerce_tax_total_display'] = woocommerceTaxTotalDisplay;
    data['woocommerce_shipping_tax_class'] = woocommerceShippingTaxClass;
    data['woocommerce_tax_display_shop'] = woocommerceTaxDisplayShop;
    if (taxRates != null) {
      //data['tax_rates'] = this.taxRates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductSettings {
  String? woocommerceEnableReviews;
  String? woocommerceEnableReviewRating;
  String? woocommerceManageStock;
  String? woocommerceHideOutOfStockItems;

  ProductSettings(
      {this.woocommerceEnableReviews,
      this.woocommerceEnableReviewRating,
      this.woocommerceManageStock,
      this.woocommerceHideOutOfStockItems});

  ProductSettings.fromJson(Map<String, dynamic> json) {
    woocommerceEnableReviews = json['Woocommerce_enable_reviews'];
    woocommerceEnableReviewRating = json['Woocommerce_enable_review_rating'];
    woocommerceManageStock = json['Woocommerce_manage_stock'];
    woocommerceHideOutOfStockItems =
        json['Woocommerce_hide_out_of_stock_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Woocommerce_enable_reviews'] = woocommerceEnableReviews;
    data['Woocommerce_enable_review_rating'] = woocommerceEnableReviewRating;
    data['Woocommerce_manage_stock'] = woocommerceManageStock;
    data['Woocommerce_hide_out_of_stock_items'] =
        woocommerceHideOutOfStockItems;
    return data;
  }
}

class ShippingSettings {
  String? woocommerceEnableShippingCalc;
  String? woocommerceShippingCostRequiresAddress;
  String? woocommerceShipToDestination;

  ShippingSettings(
      {this.woocommerceEnableShippingCalc,
      this.woocommerceShippingCostRequiresAddress,
      this.woocommerceShipToDestination});

  ShippingSettings.fromJson(Map<String, dynamic> json) {
    woocommerceEnableShippingCalc = json['woocommerce_enable_shipping_calc'];
    woocommerceShippingCostRequiresAddress =
        json['woocommerce_shipping_cost_requires_address'];
    woocommerceShipToDestination = json['woocommerce_ship_to_destination'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['woocommerce_enable_shipping_calc'] = woocommerceEnableShippingCalc;
    data['woocommerce_shipping_cost_requires_address'] =
        woocommerceShippingCostRequiresAddress;
    data['woocommerce_ship_to_destination'] = woocommerceShipToDestination;
    return data;
  }
}

class AccountSettings {
  String? woocommerceEnableGuestCheckout;
  String? woocommerceEnableCheckoutLoginReminder;
  String? woocommerceEnableSignupAndLoginFromCheckout;
  String? woocommerceEnableMyaccountRegistration;
  String? woocommerceRegistrationGenerateUsername;
  String? woocommerceRegistrationGeneratePassword;
  String? woocommerceErasureRequestRemovesOrderData;
  String? woocommerceAllowBulkRemovePersonalData;
  String? woocommerceRegistrationPrivacyPolicyText;
  String? woocommerceCheckoutPrivacyPolicyText;

  AccountSettings(
      {this.woocommerceEnableGuestCheckout,
      this.woocommerceEnableCheckoutLoginReminder,
      this.woocommerceEnableSignupAndLoginFromCheckout,
      this.woocommerceEnableMyaccountRegistration,
      this.woocommerceRegistrationGenerateUsername,
      this.woocommerceRegistrationGeneratePassword,
      this.woocommerceErasureRequestRemovesOrderData,
      this.woocommerceAllowBulkRemovePersonalData,
      this.woocommerceRegistrationPrivacyPolicyText,
      this.woocommerceCheckoutPrivacyPolicyText});

  AccountSettings.fromJson(Map<String, dynamic> json) {
    woocommerceEnableGuestCheckout = json['woocommerce_enable_guest_checkout'];
    woocommerceEnableCheckoutLoginReminder =
        json['woocommerce_enable_checkout_login_reminder'];
    woocommerceEnableSignupAndLoginFromCheckout =
        json['woocommerce_enable_signup_and_login_from_checkout'];
    woocommerceEnableMyaccountRegistration =
        json['woocommerce_enable_myaccount_registration'];
    woocommerceRegistrationGenerateUsername =
        json['woocommerce_registration_generate_username'];
    woocommerceRegistrationGeneratePassword =
        json['woocommerce_registration_generate_password'];
    woocommerceErasureRequestRemovesOrderData =
        json['woocommerce_erasure_request_removes_order_data'];
    woocommerceAllowBulkRemovePersonalData =
        json['woocommerce_allow_bulk_remove_personal_data'];
    woocommerceRegistrationPrivacyPolicyText =
        json['woocommerce_registration_privacy_policy_text'];
    woocommerceCheckoutPrivacyPolicyText =
        json['woocommerce_checkout_privacy_policy_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['woocommerce_enable_guest_checkout'] = woocommerceEnableGuestCheckout;
    data['woocommerce_enable_checkout_login_reminder'] =
        woocommerceEnableCheckoutLoginReminder;
    data['woocommerce_enable_signup_and_login_from_checkout'] =
        woocommerceEnableSignupAndLoginFromCheckout;
    data['woocommerce_enable_myaccount_registration'] =
        woocommerceEnableMyaccountRegistration;
    data['woocommerce_registration_generate_username'] =
        woocommerceRegistrationGenerateUsername;
    data['woocommerce_registration_generate_password'] =
        woocommerceRegistrationGeneratePassword;
    data['woocommerce_erasure_request_removes_order_data'] =
        woocommerceErasureRequestRemovesOrderData;
    data['woocommerce_allow_bulk_remove_personal_data'] =
        woocommerceAllowBulkRemovePersonalData;
    data['woocommerce_registration_privacy_policy_text'] =
        woocommerceRegistrationPrivacyPolicyText;
    data['woocommerce_checkout_privacy_policy_text'] =
        woocommerceCheckoutPrivacyPolicyText;
    return data;
  }
}

class ActivityMessages {
  Completed? completed;
  Completed? failed;
  Completed? onHold;
  Completed? processing;
  Completed? refunded;
  Completed? cancelled;
  Completed? pending;
  String? lastUpdated;

  ActivityMessages(
      {this.completed,
      this.failed,
      this.onHold,
      this.processing,
      this.refunded,
      this.cancelled,
      this.pending,
      this.lastUpdated});

  ActivityMessages.fromJson(Map<String, dynamic> json) {
    completed = json['completed'] != null
        ? Completed.fromJson(json['completed'])
        : null;
    failed = json['failed'] != null ? Completed.fromJson(json['failed']) : null;
    onHold =
        json['on_hold'] != null ? Completed.fromJson(json['on_hold']) : null;
    processing = json['processing'] != null
        ? Completed.fromJson(json['processing'])
        : null;
    refunded =
        json['refunded'] != null ? Completed.fromJson(json['refunded']) : null;
    cancelled = json['cancelled'] != null
        ? Completed.fromJson(json['cancelled'])
        : null;
    pending =
        json['pending'] != null ? Completed.fromJson(json['pending']) : null;
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (completed != null) {
      data['completed'] = completed!.toJson();
    }
    if (failed != null) {
      data['failed'] = failed!.toJson();
    }
    if (onHold != null) {
      data['on_hold'] = onHold!.toJson();
    }
    if (processing != null) {
      data['processing'] = processing!.toJson();
    }
    if (refunded != null) {
      data['refunded'] = refunded!.toJson();
    }
    if (cancelled != null) {
      data['cancelled'] = cancelled!.toJson();
    }
    if (pending != null) {
      data['pending'] = pending!.toJson();
    }
    data['last_updated'] = lastUpdated;
    return data;
  }
}

class Completed {
  String? title;
  String? message;

  Completed({this.title, this.message});

  Completed.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['message'] = message;
    return data;
  }
}

class AppSettings {
  AppleStore? appleStore;
  AppleStore? googleStore;

  AppSettings({this.appleStore, this.googleStore});

  AppSettings.fromJson(Map<String, dynamic> json) {
    appleStore = json['apple-store'] != null
        ? AppleStore.fromJson(json['apple-store'])
        : null;
    googleStore = json['google-store'] != null
        ? AppleStore.fromJson(json['google-store'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appleStore != null) {
      data['apple-store'] = appleStore!.toJson();
    }
    if (googleStore != null) {
      data['google-store'] = googleStore!.toJson();
    }
    return data;
  }
}

class AppleStore {
  String? name;
  String? link;
  int? minimumVersion;
  int? status;
  String? lastUpdated;

  AppleStore(
      {this.name,
      this.link,
      this.minimumVersion,
      this.status,
      this.lastUpdated});

  AppleStore.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link'];
    minimumVersion = json['minimum_version'];
    status = json['status'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['link'] = link;
    data['minimum_version'] = minimumVersion;
    data['status'] = status;
    data['last_updated'] = lastUpdated;
    return data;
  }
}

class BusinessSettings {
  String? name;
  String? phone;
  String? email;
  String? address;
  int? maintenanceMode;
  String? lastUpdated;

  BusinessSettings(
      {this.name,
      this.phone,
      this.email,
      this.address,
      this.maintenanceMode,
      this.lastUpdated});

  BusinessSettings.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    maintenanceMode = json['maintenance_mode'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['maintenance_mode'] = maintenanceMode;
    data['last_updated'] = lastUpdated;
    return data;
  }
}

class PaymentSettings {
  int? codStatus;
  int? digitalPaymentStatus;
  Paypal? paypal;
  Stripe? stripe;
  RazorPay? razorPay;
  Paystack? paystack;
  Flutterwave? flutterwave;
  Instamojo? instamojo;

  PaymentSettings(
      {this.codStatus,
      this.digitalPaymentStatus,
      this.paypal,
      this.stripe,
      this.razorPay,
      this.paystack,
      this.flutterwave,
      this.instamojo});

  PaymentSettings.fromJson(Map<String, dynamic> json) {
    codStatus = json['cod_status'];
    digitalPaymentStatus = json['digital_payment_status'];
    paypal = json['paypal'] != null ? Paypal.fromJson(json['paypal']) : null;
    stripe = json['stripe'] != null ? Stripe.fromJson(json['stripe']) : null;
    razorPay =
        json['razor_pay'] != null ? RazorPay.fromJson(json['razor_pay']) : null;
    paystack =
        json['paystack'] != null ? Paystack.fromJson(json['paystack']) : null;
    flutterwave = json['flutterwave'] != null
        ? Flutterwave.fromJson(json['flutterwave'])
        : null;
    instamojo = json['instamojo'] != null
        ? Instamojo.fromJson(json['instamojo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cod_status'] = codStatus;
    data['digital_payment_status'] = digitalPaymentStatus;
    if (paypal != null) {
      data['paypal'] = paypal!.toJson();
    }
    if (stripe != null) {
      data['stripe'] = stripe!.toJson();
    }
    if (razorPay != null) {
      data['razor_pay'] = razorPay!.toJson();
    }
    if (paystack != null) {
      data['paystack'] = paystack!.toJson();
    }
    if (flutterwave != null) {
      data['flutterwave'] = flutterwave!.toJson();
    }
    if (instamojo != null) {
      data['instamojo'] = instamojo!.toJson();
    }
    return data;
  }
}

class Paypal {
  String? title;
  int? status;
  String? clientId;
  String? secretKey;

  Paypal({this.title, this.status, this.clientId, this.secretKey});

  Paypal.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    clientId = json['clientId'];
    secretKey = json['secretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['status'] = status;
    data['clientId'] = clientId;
    data['secretKey'] = secretKey;
    return data;
  }
}

class Instamojo {
  String? title;
  int? status;
  String? clientId;
  String? secretKey;
  String? apiKey;
  String? authToken;

  Instamojo(
      {this.title,
      this.status,
      this.clientId,
      this.secretKey,
      this.apiKey,
      this.authToken});

  Instamojo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    clientId = json['clientId'];
    secretKey = json['secretKey'];
    apiKey = json['apikey'];
    authToken = json['authtoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['status'] = status;
    data['clientId'] = clientId;
    data['secretKey'] = secretKey;
    data['apikey'] = apiKey;
    data['authtoken'] = authToken;
    return data;
  }
}

class Stripe {
  String? title;
  int? status;
  String? secretKey;
  String? publishableKey;

  Stripe({this.title, this.status, this.secretKey, this.publishableKey});

  Stripe.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    secretKey = json['secretKey'];
    publishableKey = json['publishableKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['status'] = status;
    data['secretKey'] = secretKey;
    data['publishableKey'] = publishableKey;
    return data;
  }
}

class RazorPay {
  String? title;
  int? status;
  String? keyId;
  String? secretKey;

  RazorPay({this.title, this.status, this.keyId, this.secretKey});

  RazorPay.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    keyId = json['keyId'];
    secretKey = json['secretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['status'] = status;
    data['keyId'] = keyId;
    data['secretKey'] = secretKey;
    return data;
  }
}

class Paystack {
  String? title;
  int? status;
  String? publicKey;
  String? secretKey;

  Paystack({this.title, this.status, this.publicKey, this.secretKey});

  Paystack.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    // status = json['status'] != null ? json['status'] : null;
    if (json['status'].toString() == '') {
      status = null;
    } else {
      status = json['status'];
    }
    publicKey = json['publicKey'];
    secretKey = json['secretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['status'] = status;
    data['publicKey'] = publicKey;
    data['secretKey'] = secretKey;
    return data;
  }
}

class Flutterwave {
  String? title;
  int? status;
  String? publicKey;
  String? secretKey;
  String? encryptionKey;

  Flutterwave(
      {this.title,
      this.status,
      this.publicKey,
      this.secretKey,
      this.encryptionKey});

  Flutterwave.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    publicKey = json['publicKey'];
    secretKey = json['secretKey'];
    encryptionKey = json['encryptionKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['status'] = status;
    data['publicKey'] = publicKey;
    data['secretKey'] = secretKey;
    data['encryptionKey'] = encryptionKey;
    return data;
  }
}




// class SettingsModel {
//   String id;
//   String label;
//   String description;
//   String type;
//   String tip;
//   dynamic value;
//   Map<String, dynamic> options;
//
//   SettingsModel({this.id, this.label, this.description, this.type, this.tip, this.value, this.options});
//
//   SettingsModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     label = json['label'];
//     description = json['description'];
//     type = json['type'];
//     tip = json['tip'];
//     value = json['value'];
//     options = json['options'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['label'] = this.label;
//     data['description'] = this.description;
//     data['type'] = this.type;
//     data['tip'] = this.tip;
//     data['value'] = this.value;
//     data['options'] = this.options;
//     return data;
//   }
// }
