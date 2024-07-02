import 'package:flutter/foundation.dart';
import 'package:sunglasses/models/order_model.dart';

class ProductModel {
  int? id;
  String? name;
  String? slug;
  String? type;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? dateOnSaleFrom;
  String? dateOnSaleTo;
  bool? onSale;
  String? taxStatus;
  String? taxClass;
  bool? manageStock;
  int? stockQuantity;
  int? shippingClassId;
  double? averageRating;
  int? ratingCount;
  int? reviewCount;
  List<Categories>? categories;
  List<String>? tags;
  List<ImageModel>? images;
  List<Attributes>? attributes;
  List<int>? variations;
  List<int>? relatedIds;
  List<VariationProducts>? variationProducts;
  List<ProductVariation>? variation;
  String? status;

  ProductModel({
    this.id,
    this.name,
    this.slug,
    this.type,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleTo,
    this.onSale,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.shippingClassId,
    this.averageRating,
    this.ratingCount,
    this.reviewCount,
    this.categories,
    this.images,
    this.attributes,
    this.variations,
    this.relatedIds,
    this.variationProducts,
    this.variation,
    this.status,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['name'] != null) {
      name = (json['name']).replaceAll('amp;', '');
    }
    slug = json['slug'];
    type = json['type'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'].isNotEmpty
        ? json['regular_price']
        : json['price'];
    salePrice = json['sale_price'];
    dateOnSaleFrom = json['date_on_sale_from'];
    dateOnSaleTo = json['date_on_sale_to'];
    onSale = json['on_sale'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = json['manage_stock'] is String ? true : json['manage_stock'];
    stockQuantity = json['stock_quantity'];
    // lowStockAmount = int.parse(json['low_stock_amount'].toString());
    shippingClassId = json['shipping_class_id'];
    if (json['average_rating'] != null) {
      averageRating = 0;
      averageRating = double.tryParse(json['average_rating'].toString());
    }
    ratingCount = json['rating_count'];
    reviewCount = json['review_count'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images!.add(ImageModel.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    //variations = json['variations'] != null ? json['variations'].cast<int>() : null;
    relatedIds =
        json['related_ids'] != null ? json['related_ids'].cast<int>() : null;
    if (json['variation_products'] != null) {
      variationProducts = <VariationProducts>[];
      json['variation_products'].forEach((v) {
        variationProducts!.add(VariationProducts.fromJson(v));
      });
    }
    if (json['variations'] != null) {
      variation = <ProductVariation>[];
      json['variations'].forEach((v) {
        if (v.runtimeType != int) {
          variation!.add(ProductVariation.fromJson(v));
        }
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['type'] = type;
    data['description'] = description;
    data['short_description'] = shortDescription;
    data['sku'] = sku;
    data['price'] = price;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['date_on_sale_from'] = dateOnSaleFrom;
    data['date_on_sale_to'] = dateOnSaleTo;
    data['on_sale'] = onSale;
    data['tax_status'] = taxStatus;
    data['tax_class'] = taxClass;
    data['manage_stock'] = manageStock;
    data['stock_quantity'] = stockQuantity;
    //data['low_stock_amount'] = this.lowStockAmount;
    data['shipping_class_id'] = shippingClassId;
    data['average_rating'] = averageRating;
    data['rating_count'] = ratingCount;
    data['review_count'] = reviewCount;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    // data['tags'] = this.tags;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    //data['variations'] = this.variations;
    data['related_ids'] = relatedIds;
    if (variationProducts != null) {
      data['variation_products'] =
          variationProducts!.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      data['average_rating'] = attributes!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class ProductDimensions {
  String? length;
  String? width;
  String? height;

  ProductDimensions({this.length, this.width, this.height});

  ProductDimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? slug;

  Categories({this.id, this.name, this.slug});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}

class ImageModel {
  int? id;
  String? src;
  String? name;
  String? alt;

  ImageModel({this.id, this.src, this.name, this.alt});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is String ? 0 : json['id'];
    src = json['src'] != false ? json['src'] : '';
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['src'] = src;
    data['name'] = name;
    data['alt'] = alt;
    return data;
  }
}

class Attributes {
  // int id;
  String? name;
  int? position;
  bool? visible;
  bool? variation;
  List<String>? options;

  Attributes(
      {
      //this.id,
      this.name,
      this.position,
      this.visible,
      this.variation,
      this.options});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json['name'] != null) {
      String _name = json['name'];
      List<String> _splitName;
      _splitName = _name.split('_');
      name = _splitName.last;
    }
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    if (json['options'] != null && json['options'] != []) {
      options = [];
      // print('==Options==');
      // print(json['options']);
      if (kDebugMode) {
        print(json['options'].length);
      }
      for (int i = 0; i < json['options'].length; i++) {
        options!.add(json['options'][i].toString());
      }
    }
    //options = json['options'] != [] ? json['options'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = this.id;
    data['name'] = name;
    data['position'] = position;
    data['visible'] = visible;
    data['variation'] = variation;
    data['options'] = options;
    return data;
  }
}

class Links {
  List<Self>? self;
  List<Self>? collection;

  Links({this.self, this.collection});

  Links.fromJson(Map<String, dynamic> json) {
    self = <Self>[];
    json['self'].forEach((v) {
      self!.add(Self.fromJson(v));
    });
    collection = <Self>[];
    json['collection'].forEach((v) {
      collection!.add(Self.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (self != null) {
      data['self'] = self!.map((v) => v.toJson()).toList();
    }
    if (collection != null) {
      data['collection'] = collection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class Rating {
  String? rating;
  int? count;

  Rating({this.rating, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['count'] = count;
    return data;
  }
}

class ProductVariation {
  int? id;
  List<VariationAttributes>? attributes;
  VariationImage? variationImage;
  int? price;
  int? regularPrice;
  int? salePrice;
  String? sku;
  int? stockQuantity;
  String? variation;
  bool? manageStock;

  ProductVariation(
      {this.id,
      this.attributes,
      this.variationImage,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.sku,
      this.stockQuantity,
      this.variation,
      this.manageStock});

  ProductVariation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['attributes'] != null) {
      attributes = <VariationAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(VariationAttributes.fromJson(v));
      });
    }
    variationImage = json['variation_image'] != null
        ? VariationImage.fromJson(json['variation_image'])
        : null;
    price = json['price'];
    regularPrice = json['regular_price'];
    if (json['sale_price'] != '') {
      salePrice = json['sale_price'];
    } else {
      salePrice = null;
    }
    sku = json['sku'];
    if (json['stock_quantity'] != null && json['stock_quantity'] != '') {
      stockQuantity = json['stock_quantity'];
    }
    variation = json['variation'];
    if (json['manage_stock'] != null && json['manage_stock'] != '') {
      if (json['manage_stock'] == 'parent') {
        manageStock = false;
      } else {
        manageStock = json['manage_stock'];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    if (variationImage != null) {
      data['variation_image'] = variationImage!.toJson();
    }
    data['price'] = price;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['sku'] = sku;
    data['stock_quantity'] = stockQuantity;
    data['variation'] = variation;
    data['manage_stock'] = manageStock;
    return data;
  }
}

class VariationAttributes {
  int? id;
  String? name;
  String? options;

  VariationAttributes({this.id, this.name, this.options});

  VariationAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['name'] != null) {
      String _name = json['name'];
      List<String> _splitName;
      _splitName = _name.split('_');
      name = _splitName.last;
    }
    options = json['options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['options'] = options;
    return data;
  }
}

class VariationImage {
  int? id;
  String? src;

  VariationImage({this.id, this.src});

  VariationImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['src'] != false) {
      src = json['src'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['src'] = src;
    return data;
  }
}

class GroupedProduct {
  int? id;
  String? name;
  String? slug;
  String? type;
  String? status;
  List<int>? upsellIds;
  List<int>? groupedProducts;
  List<ImageModel>? images;
  int? menuOrder;
  String? priceHtml;
  List<int>? relatedIds;
  String? stockStatus;
  bool? hasOptions;

  GroupedProduct(
      {this.id,
      this.name,
      this.slug,
      this.type,
      this.status,
      this.upsellIds,
      this.images,
      this.menuOrder,
      this.priceHtml,
      this.relatedIds,
      this.stockStatus,
      this.hasOptions,
      this.groupedProducts});

  GroupedProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    type = json['type'];
    status = json['status'];
    upsellIds = json['upsell_ids'].cast<int>();
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images!.add(ImageModel.fromJson(v));
      });
    }
    menuOrder = json['menu_order'];
    priceHtml = json['price_html'];
    relatedIds = json['related_ids'].cast<int>();
    stockStatus = json['stock_status'];
    hasOptions = json['has_options'];
    if (json['grouped_products'] != null) {
      groupedProducts = json['grouped_products'].cast<int>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['type'] = type;
    data['status'] = status;
    data['upsell_ids'] = upsellIds;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['menu_order'] = menuOrder;
    data['price_html'] = priceHtml;
    data['related_ids'] = relatedIds;
    data['stock_status'] = stockStatus;
    data['has_options'] = hasOptions;
    data['grouped_products'] = groupedProducts;
    return data;
  }
}

class Imagep {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  Imagep(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.src,
      this.name,
      this.alt});

  Imagep.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_created'] = dateCreated;
    data['date_created_gmt'] = dateCreatedGmt;
    data['date_modified'] = dateModified;
    data['date_modified_gmt'] = dateModifiedGmt;
    data['src'] = src;
    data['name'] = name;
    data['alt'] = alt;
    return data;
  }
}

class WishedModel {
  int? id;
  List<ProductModel>? wishedProductList;

  WishedModel({
    this.id,
    this.wishedProductList,
  });

  WishedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product_list'] != null) {
      wishedProductList = <ProductModel>[];
      json['product_list'].forEach((v) {
        wishedProductList!.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (wishedProductList != null) {
      data['product_list'] = wishedProductList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
