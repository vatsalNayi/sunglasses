import 'package:sunglasses/models/product_model.dart';

class CategoryModel {
  int? id;
  String? name;
  String? slug;
  int? parent;
  String? description;
  String? display;
  ImageModel? image;
  int? menuOrder;
  int? count;

  CategoryModel(
      {this.id,
      this.name,
      this.slug,
      this.parent,
      this.description,
      this.display,
      this.image,
      this.menuOrder,
      this.count});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['name'] != null) {
      name = (json['name']).replaceAll('amp;', '');
    }
    slug = json['slug'];
    parent = json['parent'];
    description = json['description'];
    display = json['display'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    menuOrder = json['menu_order'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['parent'] = parent;
    data['description'] = description;
    data['display'] = display;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['menu_order'] = menuOrder;
    data['count'] = count;
    return data;
  }
}
