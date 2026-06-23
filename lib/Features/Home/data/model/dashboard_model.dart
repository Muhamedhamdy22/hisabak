class DashboardResponse {
  final bool? success;
  final DashboardModel? data;

  DashboardResponse({this.success, this.data});

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      success: json['success'],
      data: json['data'] != null ? DashboardModel.fromJson(json['data']) : null,
    );
  }
}

class DashboardModel {
  final int? customersCount;
  final double? totalDebt;
  final double? totalPayment;
  final double? balance;

  DashboardModel({
    this.customersCount,
    this.totalDebt,
    this.totalPayment,
    this.balance,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      customersCount: json['customers_count'],
      totalDebt: json['total_debt'] != null
          ? double.tryParse(json['total_debt'].toString())
          : 0,
      totalPayment: json['total_payment'] != null
          ? double.tryParse(json['total_payment'].toString())
          : 0,
      balance: json['balance'] != null
          ? double.tryParse(json['balance'].toString())
          : 0,
    );
  }
}