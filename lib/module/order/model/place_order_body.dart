import '../../../models/profile_model.dart';

class PlaceOrderBody {
  String? paymentMethod;
  String? paymentMethodTitle;
  bool? setPaid;
  int? customerId;
  String? status;
  String? customerNote;
  String? transactionId;
  ProfileAddressModel? billing;
  ProfileAddressModel? shipping;
  List<LineItemsBody>? lineItems;
  List<ShippingLinesBody>? shippingLines;
  List<CouponLinesBody>? couponLines;
  List<FeeLinesBody>? feeLines;

  PlaceOrderBody(
      {this.paymentMethod,
      this.paymentMethodTitle,
      this.setPaid,
      this.customerId,
      this.status,
      this.customerNote,
      this.transactionId,
      this.billing,
      this.shipping,
      this.lineItems,
      this.shippingLines,
      this.couponLines,
      this.feeLines});

  PlaceOrderBody.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    setPaid = json['set_paid'];
    customerId = json['customer_id'];
    status = json['status'];
    customerNote = json['customer_note'];
    transactionId = json['transaction_id'];
    billing = json['billing'] != null
        ? ProfileAddressModel.fromJson(json['billing'])
        : null;
    shipping = json['shipping'] != null
        ? ProfileAddressModel.fromJson(json['shipping'])
        : null;
    if (json['line_items'] != null) {
      lineItems = <LineItemsBody>[];
      json['line_items'].forEach((v) {
        lineItems!.add(LineItemsBody.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = <ShippingLinesBody>[];
      json['shipping_lines'].forEach((v) {
        shippingLines!.add(ShippingLinesBody.fromJson(v));
      });
    }
    if (json['coupon_lines'] != null) {
      couponLines = <CouponLinesBody>[];
      json['coupon_lines'].forEach((v) {
        couponLines!.add(CouponLinesBody.fromJson(v));
      });
    }
    if (json['fee_lines'] != null) {
      feeLines = <FeeLinesBody>[];
      json['fee_lines'].forEach((v) {
        feeLines!.add(FeeLinesBody.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_method'] = paymentMethod;
    data['payment_method_title'] = paymentMethodTitle;
    data['set_paid'] = setPaid;
    data['customer_id'] = customerId;
    data['status'] = status;
    data['customer_note'] = customerNote;
    data['transaction_id'] = transactionId;
    if (billing != null) {
      data['billing'] = billing!.toJson();
    }
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    if (lineItems != null) {
      data['line_items'] = lineItems!.map((v) => v.toJson()).toList();
    }
    if (shippingLines != null) {
      data['shipping_lines'] = shippingLines!.map((v) => v.toJson()).toList();
    }
    if (couponLines != null) {
      data['coupon_lines'] = couponLines!.map((v) => v.toJson()).toList();
    }
    if (feeLines != null) {
      data['fee_lines'] = feeLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineItemsBody {
  int? productId;
  int? variationId;
  int? quantity;
  String? subtotal;
  String? total;

  LineItemsBody(
      {required this.productId,
      this.variationId,
      required this.quantity,
      this.subtotal,
      this.total});

  LineItemsBody.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    variationId = json['variation_id'];
    quantity = json['quantity'];
    subtotal = json['subtotal'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    if (variationId != null) {
      data['variation_id'] = variationId;
    }
    data['quantity'] = quantity;
    if (subtotal != null) {
      data['subtotal'] = subtotal;
    }
    if (total != null) {
      data['total'] = total;
    }
    return data;
  }
}

class ShippingLinesBody {
  String? methodId;
  String? methodTitle;
  String? total;
  bool? shippingTaxStatus;

  ShippingLinesBody(
      {this.methodId, this.methodTitle, this.total, this.shippingTaxStatus});

  ShippingLinesBody.fromJson(Map<String, dynamic> json) {
    methodId = json['method_id'];
    methodTitle = json['method_title'];
    total = json['total'];
    shippingTaxStatus = json['shipping_tax_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method_id'] = methodId;
    data['method_title'] = methodTitle;
    data['total'] = total;
    data['shipping_tax_status'] = shippingTaxStatus;
    return data;
  }
}

class CouponLinesBody {
  String? code;

  CouponLinesBody({this.code});

  CouponLinesBody.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    return data;
  }
}

class FeeLinesBody {
  String? name;
  String? total;

  FeeLinesBody({this.name, this.total});

  FeeLinesBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['total'] = total;
    return data;
  }
}
