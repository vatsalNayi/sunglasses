class ConfigModel {
  String? businessName;
  String? logo;
  String? address;
  String? phone;
  String? email;
  String? country;
  String? currencySymbol;
  String? termsAndConditions;
  String? privacyPolicy;
  String? aboutUs;
  String? currencySymbolDirection;
  double? appMinimumVersionAndroid;
  String? appUrlAndroid;
  double? appMinimumVersionIos;
  String? appUrlIos;
  bool? maintenanceMode;
  String? timeformat;
  int? digitAfterDecimalPoint;
  double? flatRate;
  double? freeShipping;
  double? localPickup;
  bool? cashOnDelivery;
  bool? digitalPayment;

  ConfigModel({
    this.businessName,
    this.logo,
    this.address,
    this.phone,
    this.email,
    this.country,
    this.currencySymbol,
    this.termsAndConditions,
    this.privacyPolicy,
    this.aboutUs,
    this.currencySymbolDirection,
    this.appMinimumVersionAndroid,
    this.appUrlAndroid,
    this.appMinimumVersionIos,
    this.appUrlIos,
    this.maintenanceMode,
    this.timeformat,
    this.digitAfterDecimalPoint,
    this.flatRate,
    this.freeShipping,
    this.localPickup,
    this.cashOnDelivery,
    this.digitalPayment,
  });

  ConfigModel.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
    logo = json['logo'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    country = json['country'];
    currencySymbol = json['currency_symbol'];
    termsAndConditions = json['terms_and_conditions'];
    privacyPolicy = json['privacy_policy'];
    aboutUs = json['about_us'];
    currencySymbolDirection = json['currency_symbol_direction'];
    appMinimumVersionAndroid = json['app_minimum_version_android'].toDouble();
    appUrlAndroid = json['app_url_android'];
    appMinimumVersionIos = json['app_minimum_version_ios'].toDouble();
    appUrlIos = json['app_url_ios'];
    maintenanceMode = json['maintenance_mode'];
    timeformat = json['timeformat'];
    digitAfterDecimalPoint = json['digit_after_decimal_point'];
    flatRate = json['flat_rate'];
    freeShipping = json['free_shipping'];
    localPickup = json['local_pickup'];
    cashOnDelivery = json['cash_on_delivery'];
    digitalPayment = json['digital_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['business_name'] = businessName;
    data['logo'] = logo;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['country'] = country;
    data['currency_symbol'] = currencySymbol;
    data['terms_and_conditions'] = termsAndConditions;
    data['privacy_policy'] = privacyPolicy;
    data['about_us'] = aboutUs;
    data['currency_symbol_direction'] = currencySymbolDirection;
    data['app_minimum_version_android'] = appMinimumVersionAndroid;
    data['app_url_android'] = appUrlAndroid;
    data['app_minimum_version_ios'] = appMinimumVersionIos;
    data['app_url_ios'] = appUrlIos;
    data['maintenance_mode'] = maintenanceMode;
    data['timeformat'] = timeformat;
    data['digit_after_decimal_point'] = digitAfterDecimalPoint;
    data['flat_rate'] = flatRate;
    data['free_shipping'] = freeShipping;
    data['local_pickup'] = localPickup;
    data['cash_on_delivery'] = cashOnDelivery;
    data['digital_payment'] = digitalPayment;
    return data;
  }
}
