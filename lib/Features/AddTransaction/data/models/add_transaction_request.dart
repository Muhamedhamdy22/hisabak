class AddTransactionRequest {
  final int customerId;
  final String type;
  final double amount;
  final String? note;

  AddTransactionRequest({
    required this.customerId,
    required this.type,
    required this.amount,
    this.note,
  });

  Map<String, dynamic> toJson() => {
    'customer_id': customerId,
    'type': type,
    'amount': amount,
    if (note != null && note!.isNotEmpty) 'note': note,
  };
}