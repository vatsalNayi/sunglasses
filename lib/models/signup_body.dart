class SignUpBody {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? username;

  SignUpBody(
      {this.firstName,
      this.lastName,
      this.email = '',
      this.password,
      this.username});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
