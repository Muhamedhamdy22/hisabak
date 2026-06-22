import 'package:hisabak/Features/AddTransaction/data/models/transaction_model.dart';
import 'package:hisabak/core/enums/request_status.dart';

class TransactionState {
  final RequestStatus getTransactionsStatus;
  final List<TransactionModel> transactions;
  final String? getTransactionsMessage;

  final RequestStatus addTransactionStatus;
  final TransactionModel? addedTransaction;
  final String? waLink;
  final String? addTransactionMessage;

  final RequestStatus deleteTransactionStatus;
  final String? deleteTransactionMessage;

  final String selectedType;

  TransactionState({
    this.getTransactionsStatus = RequestStatus.init,
    this.transactions = const [],
    this.getTransactionsMessage,
    this.addTransactionStatus = RequestStatus.init,
    this.addedTransaction,
    this.waLink,
    this.addTransactionMessage,
    this.deleteTransactionStatus = RequestStatus.init,
    this.deleteTransactionMessage,
    this.selectedType = 'debt',
  });

  TransactionState copyWith({
    RequestStatus? getTransactionsStatus,
    List<TransactionModel>? transactions,
    String? getTransactionsMessage,
    RequestStatus? addTransactionStatus,
    TransactionModel? addedTransaction,
    String? waLink,
    String? addTransactionMessage,
    RequestStatus? deleteTransactionStatus,
    String? deleteTransactionMessage,
    String? selectedType,
  }) {
    return TransactionState(
      getTransactionsStatus: getTransactionsStatus ?? this.getTransactionsStatus,
      transactions: transactions ?? this.transactions,
      getTransactionsMessage: getTransactionsMessage ?? this.getTransactionsMessage,
      addTransactionStatus: addTransactionStatus ?? this.addTransactionStatus,
      addedTransaction: addedTransaction ?? this.addedTransaction,
      waLink: waLink ?? this.waLink,
      addTransactionMessage: addTransactionMessage ?? this.addTransactionMessage,
      deleteTransactionStatus: deleteTransactionStatus ?? this.deleteTransactionStatus,
      deleteTransactionMessage: deleteTransactionMessage ?? this.deleteTransactionMessage,
      selectedType: selectedType ?? this.selectedType,
    );
  }
}