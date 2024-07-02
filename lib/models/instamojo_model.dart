class InstamojoModel {
  String? name;
  String? email;
  String? number;
  String? amount;
  String? description;
  String? orderCreationUrl;
  bool? isLive;

  InstamojoModel({
    this.name,
    this.email,
    this.number,
    this.amount,
    this.description,
    this.orderCreationUrl,
    this.isLive,
  });

  // Method to convert the InstamojoOrder object into a Map for API requests
  Map<String, dynamic> toJson() {
    return {
      'buyerName': name,
      'buyerEmail': email,
      'buyerPhone': number,
      'amount': amount,
      'description': description,
      'orderCreationUrl': orderCreationUrl,
      'isLive': isLive,
    };
  }

  // Method to create an InstamojoOrder object from a Map
  factory InstamojoModel.fromJson(Map<String, dynamic> json) {
    return InstamojoModel(
      name: json['buyerName'],
      email: json['buyerEmail'],
      number: json['buyerPhone'],
      amount: json['amount'],
      description: json['description'],
      orderCreationUrl: json['orderCreationUrl'],
      isLive: json['isLive'],
    );
  }
}
