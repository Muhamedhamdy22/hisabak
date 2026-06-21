class CustomerResponse {
  final bool? success;
  final List<CustomerModel>? data;

  CustomerResponse({this.success, this.data});

  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    return CustomerResponse(
      success: json['success'],
      data: json['data'] != null
          ? (json['data'] as List).map((e) => CustomerModel.fromJson(e)).toList()
          : [],
    );
  }
}

class SingleCustomerResponse {
  final bool? success;
  final CustomerModel? data;

  SingleCustomerResponse({this.success, this.data});

  factory SingleCustomerResponse.fromJson(Map<String, dynamic> json) {
    return SingleCustomerResponse(
      success: json['success'],
      data: json['data'] != null ? CustomerModel.fromJson(json['data']) : null,
    );
  }
}

class CustomerModel {
  final int? id;
  final int? merchantId;
  final String? name;
  final String? phone;
  final String? createdAt;

  CustomerModel({
    this.id,
    this.merchantId,
    this.name,
    this.phone,
    this.createdAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      merchantId: json['merchant_id'],
      name: json['name'],
      phone: json['phone'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'merchant_id': merchantId,
    'name': name,
    'phone': phone,
    'created_at': createdAt,
  };
}