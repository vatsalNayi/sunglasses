import 'coupon_model.dart';
import 'product_model.dart';
import 'tax_model.dart';

class CartModel {
  String? key;
  int? id;
  int? quantity;
  QuantityLimits? quantityLimits;
  String? name;
  String? shortDescription;
  String? description;
  String? sku;
  List<ImageModel>? images;
  List<Variation>? variation;
  List<ProductVariation>? productVariations;
  String? variationText;
  Prices? prices;
  Totals? totals;
  CouponModel? coupon;
  ProductModel? product;
  TaxModel? tax;
  String? variationImage;

  CartModel({
    this.key,
    this.id,
    this.quantity,
    this.quantityLimits,
    this.name,
    this.shortDescription,
    this.description,
    this.sku,
    this.images,
    this.variation,
    this.productVariations,
    this.variationText,
    this.prices,
    this.totals,
    this.coupon,
    this.product,
    this.tax,
    this.variationImage,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'];
    quantity = json['quantity'];
    quantityLimits = json['quantity_limits'] != null
        ? QuantityLimits.fromJson(json['quantity_limits'])
        : null;
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    variationText = json['variation_text'];
    sku = json['sku'];
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images!.add(ImageModel.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      variation = <Variation>[];
      json['variation'].forEach((v) {
        variation!.add(Variation.fromJson(v));
      });
    }
    if (json['variations'] != null) {
      productVariations = <ProductVariation>[];
      json['variations'].forEach((v) {
        productVariations!.add(ProductVariation.fromJson(v));
      });
    }
    prices = json['prices'] != null ? Prices.fromJson(json['prices']) : null;
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
    coupon =
        json['coupon'] != null ? CouponModel.fromJson(json['coupon']) : null;
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    tax = json['tax'] != null ? TaxModel.fromJson(json['tax']) : null;
    variationImage = json['variation_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['id'] = id;
    data['quantity'] = quantity;
    if (quantityLimits != null) {
      data['quantity_limits'] = quantityLimits!.toJson();
    }
    data['name'] = name;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['variation_text'] = variationText;
    data['sku'] = sku;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (variation != null) {
      data['variation'] = variation!.map((v) => v.toJson()).toList();
    }
    if (variation != null) {
      data['variations'] = productVariations!.map((v) => v.toJson()).toList();
    }
    if (prices != null) {
      data['prices'] = prices!.toJson();
    }
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }
    if (coupon != null) {
      data['coupon'] = coupon!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (tax != null) {
      data['tax'] = tax!.toJson();
    }
    data['variation_image'] = variationImage;
    return data;
  }
}

class QuantityLimits {
  int? minimum;
  int? maximum;

  QuantityLimits({this.minimum, this.maximum});

  QuantityLimits.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    maximum = json['maximum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minimum'] = minimum;
    data['maximum'] = maximum;
    return data;
  }
}

class Variation {
  String? attribute;
  String? value;
  String? valueSku;

  Variation({this.attribute, this.value, this.valueSku});

  Variation.fromJson(Map<String, dynamic> json) {
    attribute = json['attribute'];
    value = json['value'];
    valueSku = json['value_sku'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute'] = attribute;
    data['value'] = value;
    data['value_sku'] = valueSku;
    return data;
  }
}

class Prices {
  String? price;
  String? regularPrice;
  String? salePrice;
  String? priceRange;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyPrefix;
  String? currencySuffix;
  RawPrices? rawPrices;

  Prices(
      {this.price,
      this.regularPrice,
      this.salePrice,
      this.priceRange,
      this.currencyCode,
      this.currencySymbol,
      this.currencyMinorUnit,
      this.currencyPrefix,
      this.currencySuffix,
      this.rawPrices});

  Prices.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    priceRange = json['price_range'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
    rawPrices = json['raw_prices'] != null
        ? RawPrices.fromJson(json['raw_prices'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['price_range'] = priceRange;
    data['currency_code'] = currencyCode;
    data['currency_symbol'] = currencySymbol;
    data['currency_minor_unit'] = currencyMinorUnit;
    data['currency_prefix'] = currencyPrefix;
    data['currency_suffix'] = currencySuffix;
    if (rawPrices != null) {
      data['raw_prices'] = rawPrices!.toJson();
    }
    return data;
  }
}

class RawPrices {
  int? precision;
  String? price;
  String? regularPrice;
  String? salePrice;

  RawPrices({this.precision, this.price, this.regularPrice, this.salePrice});

  RawPrices.fromJson(Map<String, dynamic> json) {
    precision = json['precision'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['precision'] = precision;
    data['price'] = price;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    return data;
  }
}

class Totals {
  String? lineSubtotal;
  String? lineSubtotalTax;
  String? lineTotal;
  String? lineTotalTax;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyPrefix;
  String? currencySuffix;

  Totals(
      {this.lineSubtotal,
      this.lineSubtotalTax,
      this.lineTotal,
      this.lineTotalTax,
      this.currencyCode,
      this.currencySymbol,
      this.currencyMinorUnit,
      this.currencyPrefix,
      this.currencySuffix});

  Totals.fromJson(Map<String, dynamic> json) {
    lineSubtotal = json['line_subtotal'];
    lineSubtotalTax = json['line_subtotal_tax'];
    lineTotal = json['line_total'];
    lineTotalTax = json['line_total_tax'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['line_subtotal'] = lineSubtotal;
    data['line_subtotal_tax'] = lineSubtotalTax;
    data['line_total'] = lineTotal;
    data['line_total_tax'] = lineTotalTax;
    data['currency_code'] = currencyCode;
    data['currency_symbol'] = currencySymbol;
    data['currency_minor_unit'] = currencyMinorUnit;
    data['currency_prefix'] = currencyPrefix;
    data['currency_suffix'] = currencySuffix;
    return data;
  }
}

class CartModelAll {
  int? id;
  List<CartModel?>? cartList;

  CartModelAll({
    this.id,
    this.cartList,
  });

  CartModelAll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    var cartListJson = json['cart_list'];
    if (cartListJson != null) {
      cartList = <CartModel>[];
      // Ensure that cartListJson is a List<dynamic>
      if (cartListJson is List<dynamic>) {
        cartListJson.forEach((v) {
          // Ensure that each element of cartListJson is a Map<String, dynamic>
          if (v is Map<String, dynamic>) {
            cartList!.add(CartModel.fromJson(v));
          }
        });
      }
    }
  }

  // CartModelAll.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   if (json['cart_list'] != null) {
  //     cartList = <CartModel>[];
  //     json['cart_list'].forEach((v) {
  //       cartList!.add(CartModel.fromJson(v));
  //     });
  //   }
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (cartList != null && cartList!.isNotEmpty) {
      // Check if cartList is not null before accessing its properties or methods
      data['cart_list'] = cartList!.map((v) => v!.toJson()).toList();
      // data['cart_list'] = cartList?.map((v) => v?.toJson()).toList() ?? [];

    }
    return data;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   if (cartList != null && cartList!.isNotEmpty) {
  //     data['cart_list'] = cartList!.map((v) => v!.toJson()).toList();
  //   }
  //   return data;
  // }
}
