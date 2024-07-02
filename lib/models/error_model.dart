class ErrorModel {
  String? code;
  String? message;
  Data? data;

  ErrorModel({this.code, this.message, this.data});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  @override
  String toString() {
    return "WooCommerce Error!\ncode: $code\nmessage: $message\nstatus: ${data!.status}";
  }
}

class Data {
  int? _status;

  Data({int? status}) {
    _status = status;
  }

  int? get status => _status;

  Data.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    return data;
  }
}
