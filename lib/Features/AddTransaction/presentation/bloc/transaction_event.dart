abstract class TransactionEvent {}

class GetTransactionsEvent extends TransactionEvent {
  final int customerId;
  GetTransactionsEvent({required this.customerId});
}

class AddTransactionEvent extends TransactionEvent {
  final int customerId;
  final String type;
  final double amount;
  final String? note;

  AddTransactionEvent({
    required this.customerId,
    required this.type,
    required this.amount,
    this.note,
  });
}

class DeleteTransactionEvent extends TransactionEvent {
  final int id;
  DeleteTransactionEvent({required this.id});
}

class SelectTypeEvent extends TransactionEvent {
  final String type;
  SelectTypeEvent({required this.type});
}