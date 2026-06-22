class TransactionResponse {
  final bool? success;
  final List<TransactionModel>? data;

  TransactionResponse({this.success, this.data});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      success: json['success'],
      data: json['data'] != null
          ? (json['data'] as List)
          .map((e) => TransactionModel.fromJson(e))
          .toList()
          : [],
    );
  }
}

class SingleTransactionResponse {
  final bool? success;
  final TransactionModel? data;
  final String? waLink;

  SingleTransactionResponse({this.success, this.data, this.waLink});

  factory SingleTransactionResponse.fromJson(Map<String, dynamic> json) {
    return SingleTransactionResponse(
      success: json['success'],
      data: json['data'] != null
          ? TransactionModel.fromJson(json['data'])
          : null,
      waLink: json['wa_link'],
    );
  }
}

class TransactionModel {
  final int? id;
  final int? customerId;
  final String? type;
  final double? amount;
  final String? note;
  final String? createdAt;

  TransactionModel({
    this.id,
    this.customerId,
    this.type,
    this.amount,
    this.note,
    this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      customerId: json['customer_id'],
      type: json['type'],
      amount: json['amount'] != null
          ? double.tryParse(json['amount'].toString())
          : null,
      note: json['note'],
      createdAt: json['created_at'],
    );
  }
}