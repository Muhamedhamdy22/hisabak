class LoginResponse {
  LoginResponse({
      this.success, 
      this.data,});

  LoginResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.merchant, 
      this.token,});

  Data.fromJson(dynamic json) {
    merchant = json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null;
    token = json['token'];
  }
  Merchant? merchant;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (merchant != null) {
      map['merchant'] = merchant?.toJson();
    }
    map['token'] = token;
    return map;
  }

}

class Merchant {
  Merchant({
      this.id, 
      this.name, 
      this.phone, 
      this.createdAt,});

  Merchant.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    createdAt = json['created_at'];
  }
  int? id;
  String? name;
  String? phone;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['created_at'] = createdAt;
    return map;
  }

}