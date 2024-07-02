import 'country.dart';
import 'state.dart' as st;

class AddressModel {
  int? id;
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? postcode;
  Country? country;
  st.State? state;
  String? email;
  String? phone;

  AddressModel(
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
      this.id});

  AddressModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    postcode = json['postcode'];
    if (json['country'] != null) {
      country = Country.fromJson(json['country']);
    }
    if (json['state'] != null) {
      state = st.State.fromJson(json['state']);
    }
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
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
    return data;
  }
}
