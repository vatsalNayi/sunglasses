class ShippingMethodModel {
  int? id;
  String? title;
  int? order;
  bool? enabled;
  String? methodId;
  String? methodTitle;
  String? methodDescription;
  Settings? settings;
  double? total;
  Map<String, dynamic>? data;

  ShippingMethodModel({
    this.id,
    this.title,
    this.order,
    this.enabled,
    this.methodId,
    this.methodTitle,
    this.methodDescription,
    this.settings,
    this.total,
    this.data,
  });

  ShippingMethodModel.fromJson(Map<String, dynamic> json,
      {bool fromRoute = false}) {
    id = json['id'];
    title = json['title'];
    order = json['order'];
    enabled = json['enabled'];
    methodId = json['method_id'];
    methodTitle = json['method_title'];
    methodDescription = json['method_description'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    if (fromRoute) {
      total = json['total'].toDouble();
    } else {
      data = Map();
      data!.addAll(json);
      total = 0;
      try {
        total = settings!.cost!.value!.isNotEmpty
            ? double.parse(settings!.cost!.value!)
            : 0;
      } catch (e) {
        total = 0;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['order'] = order;
    data['enabled'] = enabled;
    data['method_id'] = methodId;
    data['method_title'] = methodTitle;
    data['method_description'] = methodDescription;
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    data['total'] = total;
    return data;
  }
}

class Settings {
  Cost? cost;

  Settings({this.cost});

  Settings.fromJson(Map<String, dynamic> json) {
    cost = json['cost'] != null ? new Cost.fromJson(json['cost']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (cost != null) {
      data['cost'] = cost!.toJson();
    }
    return data;
  }
}

class Cost {
  String? id;
  String? value;

  Cost({this.id, this.value});

  Cost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['value'] = value;
    return data;
  }
}
