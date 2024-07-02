import 'package:sunglasses/core/utils/app_constants.dart';

import 'product_model.dart';
import 'profile_model.dart';

class OrderModel {
  int? id;
  int? parentId;
  String? status;
  String? currency;
  bool? pricesIncludeTax;
  String? dateCreated;
  String? dateModified;
  String? discountTotal;
  String? discountTax;
  String? shippingTotal;
  String? shippingTax;
  String? cartTax;
  String? total;
  String? totalTax;
  int? customerId;
  String? orderKey;
  ProfileAddressModel? billing;
  ProfileAddressModel? shipping;
  String? paymentMethod;
  String? paymentMethodTitle;
  String? transactionId;
  String? createdVia;
  String? customerNote;
  String? dateCompleted;
  String? datePaid;
  String? cartHash;
  String? number;
  List<LineItems>? lineItems;
  List<ShippingLines>? shippingLines;
  List<FeeLines>? feeLines;
  List<CouponLines>? couponLines;
  List<Stores>? stores;
  String? paymentUrl;
  bool? isEditable;
  bool? needsPayment;
  bool? needsProcessing;
  String? currencySymbol;

  OrderModel({
    this.id,
    this.parentId,
    this.status,
    this.currency,
    this.pricesIncludeTax,
    this.dateCreated,
    this.dateModified,
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.customerId,
    this.orderKey,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.createdVia,
    this.customerNote,
    this.dateCompleted,
    this.datePaid,
    this.cartHash,
    this.number,
    this.lineItems,
    this.shippingLines,
    this.feeLines,
    this.couponLines,
    this.paymentUrl,
    this.isEditable,
    this.needsPayment,
    this.needsProcessing,
    this.currencySymbol,
    this.stores,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    status = json['status'];
    currency = json['currency'];
    pricesIncludeTax = json['prices_include_tax'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    cartTax = json['cart_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    customerId = json['customer_id'];
    orderKey = json['order_key'];
    billing = json['billing'] != null
        ? ProfileAddressModel.fromJson(json['billing'])
        : null;
    shipping = json['shipping'] != null
        ? ProfileAddressModel.fromJson(json['shipping'])
        : null;
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    transactionId = json['transaction_id'];
    createdVia = json['created_via'];
    customerNote = json['customer_note'];
    dateCompleted = json['date_completed'];
    datePaid = json['date_paid'];
    cartHash = json['cart_hash'];
    number = json['number'];
    if (json['line_items'] != null) {
      lineItems = <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = <ShippingLines>[];
      json['shipping_lines'].forEach((v) {
        shippingLines!.add(ShippingLines.fromJson(v));
      });
    }
    if (json['fee_lines'] != null) {
      feeLines = <FeeLines>[];
      json['fee_lines'].forEach((v) {
        feeLines!.add(FeeLines.fromJson(v));
      });
    }
    if (json['coupon_lines'] != null) {
      couponLines = <CouponLines>[];
      json['coupon_lines'].forEach((v) {
        couponLines!.add(CouponLines.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
    paymentUrl = json['payment_url'];
    isEditable = json['is_editable'];
    needsPayment = json['needs_payment'];
    needsProcessing = json['needs_processing'];
    currencySymbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['status'] = status;
    data['currency'] = currency;
    data['prices_include_tax'] = pricesIncludeTax;
    data['date_created'] = dateCreated;
    data['date_modified'] = dateModified;
    data['discount_total'] = discountTotal;
    data['discount_tax'] = discountTax;
    data['shipping_total'] = shippingTotal;
    data['shipping_tax'] = shippingTax;
    data['cart_tax'] = cartTax;
    data['total'] = total;
    data['total_tax'] = totalTax;
    data['customer_id'] = customerId;
    data['order_key'] = orderKey;
    if (billing != null) {
      data['billing'] = billing!.toJson();
    }
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    data['payment_method'] = paymentMethod;
    data['payment_method_title'] = paymentMethodTitle;
    data['transaction_id'] = transactionId;
    data['created_via'] = createdVia;
    data['customer_note'] = customerNote;
    data['date_completed'] = dateCompleted;
    data['date_paid'] = datePaid;
    data['cart_hash'] = cartHash;
    data['number'] = number;
    if (lineItems != null) {
      data['line_items'] = lineItems!.map((v) => v.toJson()).toList();
    }
    if (shippingLines != null) {
      data['shipping_lines'] = shippingLines!.map((v) => v.toJson()).toList();
    }
    if (feeLines != null) {
      data['fee_lines'] = feeLines!.map((v) => v.toJson()).toList();
    }
    if (couponLines != null) {
      data['coupon_lines'] = couponLines!.map((v) => v.toJson()).toList();
    }
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    data['payment_url'] = paymentUrl;
    data['is_editable'] = isEditable;
    data['needs_payment'] = needsPayment;
    data['needs_processing'] = needsProcessing;
    data['currency_symbol'] = currencySymbol;
    return data;
  }
}

class LineItems {
  int? id;
  String? name;
  int? productId;
  int? variationId;
  int? quantity;
  String? taxClass;
  String? subtotal;
  String? subtotalTax;
  String? total;
  String? totalTax;
  String? sku;
  double? price;
  ImageModel? image;
  String? parentName;
  ProductModel? productData;
  VariationProducts? variationProducts;
  List<WcfmMetaData>? wcfmMetaData;
  LineItems({
    this.id,
    this.name,
    this.productId,
    this.variationId,
    this.quantity,
    this.taxClass,
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.totalTax,
    this.sku,
    this.price,
    this.image,
    this.parentName,
    this.productData,
    this.variationProducts,
    this.wcfmMetaData,
  });

  LineItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    quantity = json['quantity'];
    taxClass = json['tax_class'];
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    sku = json['sku'];
    price = json['price'].toDouble();
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    parentName = json['parent_name'];
    productData = json['product_data'] != null
        ? ProductModel.fromJson(json['product_data'])
        : null;
    if (productData != null && productData!.variationProducts != null) {
      for (VariationProducts variation in productData!.variationProducts!) {
        if (variation.id == variationId) {
          variationProducts = variation;
        }
      }
    }
    if (AppConstants.vendorType != VendorType.dokan) {
      if (json['meta_data'] != null) {
        wcfmMetaData = <WcfmMetaData>[];
        json['meta_data'].forEach((v) {
          wcfmMetaData!.add(WcfmMetaData.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['product_id'] = productId;
    data['variation_id'] = variationId;
    data['quantity'] = quantity;
    data['tax_class'] = taxClass;
    data['subtotal'] = subtotal;
    data['subtotal_tax'] = subtotalTax;
    data['total'] = total;
    data['total_tax'] = totalTax;
    data['sku'] = sku;
    data['price'] = price;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['parent_name'] = parentName;
    if (productData != null) {
      data['product_data'] = productData!.toJson();
    }
    data['variation_products'] = variationProducts;
    return data;
  }
}

class ShippingLines {
  int? id;
  String? methodTitle;
  String? methodId;
  String? instanceId;
  String? total;
  String? totalTax;

  ShippingLines(
      {this.id,
      this.methodTitle,
      this.methodId,
      this.instanceId,
      this.total,
      this.totalTax});

  ShippingLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodTitle = json['method_title'];
    methodId = json['method_id'];
    instanceId = json['instance_id'];
    total = json['total'];
    totalTax = json['total_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['method_title'] = methodTitle;
    data['method_id'] = methodId;
    data['instance_id'] = instanceId;
    data['total'] = total;
    data['total_tax'] = totalTax;
    return data;
  }
}

class FeeLines {
  int? id;
  String? name;
  String? taxClass;
  String? taxStatus;
  String? amount;
  String? total;
  String? totalTax;

  FeeLines(
      {this.id,
      this.name,
      this.taxClass,
      this.taxStatus,
      this.amount,
      this.total,
      this.totalTax});

  FeeLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    taxClass = json['tax_class'];
    taxStatus = json['tax_status'];
    amount = json['amount'];
    total = json['total'];
    totalTax = json['total_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tax_class'] = taxClass;
    data['tax_status'] = taxStatus;
    data['amount'] = amount;
    data['total'] = total;
    data['total_tax'] = totalTax;
    return data;
  }
}

class CouponLines {
  int? id;
  String? code;
  String? discount;
  String? discountTax;
  String? discountType;
  List<MetaData>? metaData;

  CouponLines(
      {this.id,
      this.code,
      this.discount,
      this.discountTax,
      this.discountType,
      this.metaData});

  CouponLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    discount = json['discount'];
    discountTax = json['discount_tax'];
    discountTax = json['discount_tax'];
    if (json['meta_data'].isNotEmpty) {
      discountType = json['meta_data'][0]['value']['discount_type'];
    }
    if (json['meta_data'].isNotEmpty) {
      metaData = <MetaData>[];
      json['meta_data'].forEach((v) {
        metaData!.add(MetaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['discount'] = discount;
    data['discount_tax'] = discountTax;
    data['discount_type'] = discountType;
    return data;
  }
}

class VariationProducts {
  int? id;
  int? productId;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? featureImage;
  List<AttributesArr>? attributesArr;

  VariationProducts(
      {this.id,
      this.productId,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.featureImage,
      this.attributesArr});

  VariationProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    featureImage = json['feature_image'];
    if (json['attributes'] != null) {
      attributesArr = <AttributesArr>[];
      json['attributes'].forEach((v) {
        attributesArr!.add(AttributesArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['price'] = price;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['feature_image'] = featureImage;
    if (attributesArr != null) {
      data['attributes'] = attributesArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributesArr {
  String? name;
  String? slug;
  String? attributeName;
  int? id;
  String? option;

  AttributesArr(
      {this.name, this.slug, this.attributeName, this.id, this.option});

  AttributesArr.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    attributeName = json['attribute_name'];
    id = json['id'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['slug'] = slug;
    data['attribute_name'] = attributeName;
    data['id'] = id;
    data['option'] = option;
    return data;
  }
}

class Stores {
  int? id;
  String? name;
  String? shopName;
  String? url;
  StoreAddress? address;

  Stores({this.id, this.name, this.shopName, this.url, this.address});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shopName = json['shop_name'];
    url = json['url'];
    address = json['address'].runtimeType != List
        ? StoreAddress.fromJson(json['address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['shop_name'] = shopName;
    data['url'] = url;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class StoreAddress {
  String? street1;
  String? street2;
  String? city;
  String? zip;
  String? state;
  String? country;

  StoreAddress(
      {this.street1,
      this.street2,
      this.city,
      this.zip,
      this.state,
      this.country});

  StoreAddress.fromJson(Map<String, dynamic> json) {
    street1 = json['street_1'];
    street2 = json['street_2'];
    city = json['city'];
    zip = json['zip'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street_1'] = street1;
    data['street_2'] = street2;
    data['city'] = city;
    data['zip'] = zip;
    data['state'] = state;
    data['country'] = country;
    return data;
  }
}

// class CouponMetaData {
//   List<MetaData> metaData;
//
//   CouponMetaData({this.metaData});
//
//   CouponMetaData.fromJson(Map<String, dynamic> json) {
//     if (json['meta_data'] != null) {
//       metaData = <MetaData>[];
//       json['meta_data'].forEach((v) { metaData.add(new MetaData.fromJson(v)); });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.metaData != null) {
//       data['meta_data'] = this.metaData.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class MetaData {
  int? id;
  String? key;
  Value? value;
  String? displayKey;

  MetaData({this.id, this.key, this.value, this.displayKey});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'] != null ? Value.fromJson(json['value']) : null;
    displayKey = json['display_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    if (value != null) {
      data['value'] = value!.toJson();
    }
    data['display_key'] = displayKey;
    return data;
  }
}

class Value {
  int? id;
  String? code;
  String? amount;
  String? status;
  String? discountType;
  String? description;
  int? usageCount;
  bool? individualUse;
  List<Null>? productIds;
  List<Null>? excludedProductIds;
  int? usageLimit;
  int? usageLimitPerUser;
  Null limitUsageToXItems;
  bool? freeShipping;
  List<Null>? productCategories;
  List<Null>? excludedProductCategories;
  bool? excludeSaleItems;
  String? minimumAmount;
  String? maximumAmount;
  List<Null>? emailRestrictions;
  bool? virtual;
  List<Null>? metaData;
  DateCreated? dateCreated;
  DateCreated? dateModified;
  DateCreated? dateExpires;

  Value(
      {this.id,
      this.code,
      this.amount,
      this.status,
      this.discountType,
      this.description,
      this.usageCount,
      this.individualUse,
      this.productIds,
      this.excludedProductIds,
      this.usageLimit,
      this.usageLimitPerUser,
      this.limitUsageToXItems,
      this.freeShipping,
      this.productCategories,
      this.excludedProductCategories,
      this.excludeSaleItems,
      this.minimumAmount,
      this.maximumAmount,
      this.emailRestrictions,
      this.virtual,
      this.metaData,
      this.dateExpires,
      this.dateCreated,
      this.dateModified});

  Value.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = json['amount'];
    status = json['status'];
    discountType = json['discount_type'];
    description = json['description'];
    usageCount = json['usage_count'];
    individualUse = json['individual_use'];
    usageLimit = json['usage_limit'];
    usageLimitPerUser = json['usage_limit_per_user'];
    limitUsageToXItems = json['limit_usage_to_x_items'];
    freeShipping = json['free_shipping'];
    excludeSaleItems = json['exclude_sale_items'];
    minimumAmount = json['minimum_amount'];
    maximumAmount = json['maximum_amount'];
    virtual = json['virtual'];
    dateCreated = json['date_created'] != null
        ? DateCreated.fromJson(json['date_created'])
        : null;
    dateModified = json['date_modified'] != null
        ? DateCreated.fromJson(json['date_modified'])
        : null;
    dateExpires = json['date_expires'] != null
        ? DateCreated.fromJson(json['date_expires'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['amount'] = amount;
    data['status'] = status;
    data['discount_type'] = discountType;
    data['description'] = description;
    data['usage_count'] = usageCount;
    data['individual_use'] = individualUse;
    data['usage_limit'] = usageLimit;
    data['usage_limit_per_user'] = usageLimitPerUser;
    data['limit_usage_to_x_items'] = limitUsageToXItems;
    data['free_shipping'] = freeShipping;
    data['exclude_sale_items'] = excludeSaleItems;
    data['minimum_amount'] = minimumAmount;
    data['maximum_amount'] = maximumAmount;
    data['virtual'] = virtual;
    if (dateCreated != null) {
      data['date_created'] = dateCreated!.toJson();
    }
    if (dateModified != null) {
      data['date_modified'] = dateModified!.toJson();
    }
    if (dateExpires != null) {
      data['date_expires'] = dateExpires!.toJson();
    }
    return data;
  }
}

class DateCreated {
  String? date;
  int? timezoneType;
  String? timezone;

  DateCreated({this.date, this.timezoneType, this.timezone});

  DateCreated.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['timezone_type'] = timezoneType;
    data['timezone'] = timezone;
    return data;
  }
}

class WcfmMetaData {
  int? id;
  String? key;
  String? value;
  String? displayKey;
  String? displayValue;

  WcfmMetaData(
      {this.id, this.key, this.value, this.displayKey, this.displayValue});

  WcfmMetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    displayKey = json['display_key'];
    displayValue = json['display_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['value'] = value;
    data['display_key'] = displayKey;
    data['display_value'] = displayValue;
    return data;
  }
}
