class ProfileModel {
  int? id;
  String? dateCreated;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? username;
  ProfileAddressModel? billing;
  ProfileAddressModel? shipping;
  bool? isPayingCustomer;
  String? avatarUrl;
  List<MetaData>? metaData;

  ProfileModel(
      {this.id,
      this.dateCreated,
      this.email,
      this.firstName,
      this.lastName,
      this.role,
      this.username,
      this.billing,
      this.shipping,
      this.isPayingCustomer,
      this.avatarUrl,
      this.metaData});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    role = json['role'];
    username = json['username'];

    billing = json['billing'] != null
        ? ProfileAddressModel.fromJson(json['billing'])
        : null;
    shipping = json['shipping'] != null
        ? ProfileAddressModel.fromJson(json['shipping'])
        : null;

    isPayingCustomer = json['is_paying_customer'];
    avatarUrl = json['avatar_url'];
    if (json['meta_data'] != null) {
      metaData = <MetaData>[];
      json['meta_data'].forEach((v) {
        metaData!.add(MetaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (email != null) {
      data['email'] = email;
    }
    if (firstName != null) {
      data['first_name'] = firstName;
    }
    if (lastName != null) {
      data['last_name'] = lastName;
    }
    if (billing != null) {
      data['billing'] = billing!.toJson();
    }
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MetaData {
  int? id;
  String? key;
  String? value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    if (json['value'].runtimeType == String) {
      value = json['value'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class ProfileAddressModel {
  int? id;
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? postcode;
  String? country;
  String? state;
  String? email;
  String? phone;
  String? stateIso;

  ProfileAddressModel(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.postcode,
      this.country,
      this.state,
      this.email,
      this.phone,
      this.id,
      this.stateIso});

  ProfileAddressModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    postcode = json['postcode'];
    if (json['country'] != null) {
      country = json['country'];
    }
    if (json['state'] != null) {
      state = json['state'];
    }
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    stateIso = json['state_iso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (firstName != null) {
      data['first_name'] = firstName;
    }
    if (lastName != null) {
      data['last_name'] = lastName;
    }
    if (company != null) {
      data['company'] = company;
    }
    if (address1 != null) {
      data['address_1'] = address1;
    }
    if (address2 != null) {
      data['address_2'] = address2;
    }
    if (city != null) {
      data['city'] = city;
    }
    if (postcode != null) {
      data['postcode'] = postcode;
    }
    if (country != null) {
      data['country'] = country;
    }
    if (state != null) {
      data['state'] = state;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    if (id != null) {
      data['id'] = id;
    }
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }
}
