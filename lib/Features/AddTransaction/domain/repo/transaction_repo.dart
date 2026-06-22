import 'package:hisabak/Features/AddTransaction/data/models/add_transaction_request.dart';
import 'package:hisabak/Features/AddTransaction/data/models/transaction_model.dart';

abstract class TransactionRepo {
  Future<TransactionResponse> getCustomerTransactions({required int customerId});
  Future<SingleTransactionResponse> addTransaction({required AddTransactionRequest request});
  Future<bool> deleteTransaction({required int id});
}