class CouponModel {
  int? id;
  String? code;
  String? amount;
  String? status;
  String? dateCreated;
  String? discountType;
  String? description;
  String? dateExpires;
  int? usageCount;
  bool? individualUse;
  List<int>? productIds;
  List<int>? excludedProductIds;
  int? usageLimit;
  int? usageLimitPerUser;
  int? limitUsageToXItems;
  bool? freeShipping;
  List<int>? productCategories;
  List<int>? excludedProductCategories;
  bool? excludeSaleItems;
  String? minimumAmount;
  String? maximumAmount;
  List<String>? emailRestrictions;
  List<String>? usedBy;

  CouponModel(
      {this.id,
      this.code,
      this.amount,
      this.status,
      this.dateCreated,
      this.discountType,
      this.description,
      this.dateExpires,
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
      this.usedBy});

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = json['amount'];
    status = json['status'];
    dateCreated = json['date_created'];
    discountType = json['discount_type'];
    description = json['description'];
    dateExpires = json['date_expires'];
    usageCount = json['usage_count'];
    individualUse = json['individual_use'];
    productIds = json['product_ids'].cast<int>();
    excludedProductIds = json['excluded_product_ids'].cast<int>();
    usageLimit = json['usage_limit'];
    usageLimitPerUser = json['usage_limit_per_user'];
    limitUsageToXItems = json['limit_usage_to_x_items'];
    freeShipping = json['free_shipping'];
    productCategories = json['product_categories'].cast<int>();
    excludedProductCategories = json['excluded_product_categories'].cast<int>();
    excludeSaleItems = json['exclude_sale_items'];
    minimumAmount = json['minimum_amount'];
    maximumAmount = json['maximum_amount'];
    emailRestrictions = json['email_restrictions'].cast<String>();
    usedBy = json['used_by'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['amount'] = amount;
    data['status'] = status;
    data['date_created'] = dateCreated;
    data['discount_type'] = discountType;
    data['description'] = description;
    data['date_expires'] = dateExpires;
    data['usage_count'] = usageCount;
    data['individual_use'] = individualUse;
    data['product_ids'] = productIds;
    data['excluded_product_ids'] = excludedProductIds;
    data['usage_limit'] = usageLimit;
    data['usage_limit_per_user'] = usageLimitPerUser;
    data['limit_usage_to_x_items'] = limitUsageToXItems;
    data['free_shipping'] = freeShipping;
    data['product_categories'] = productCategories;
    data['excluded_product_categories'] = excludedProductCategories;
    data['exclude_sale_items'] = excludeSaleItems;
    data['minimum_amount'] = minimumAmount;
    data['maximum_amount'] = maximumAmount;
    data['email_restrictions'] = emailRestrictions;
    data['used_by'] = usedBy;
    return data;
  }
}
