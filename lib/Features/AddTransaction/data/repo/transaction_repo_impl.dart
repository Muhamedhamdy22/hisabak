import 'package:hisabak/Features/AddTransaction/data/datasource/transaction_ds.dart';
import 'package:hisabak/Features/AddTransaction/data/models/add_transaction_request.dart';
import 'package:hisabak/Features/AddTransaction/data/models/transaction_model.dart';
import 'package:hisabak/Features/AddTransaction/domain/repo/transaction_repo.dart';
import 'package:hisabak/core/Api/error_handling.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TransactionRepo)
class TransactionRepoImpl implements TransactionRepo {
  final TransactionDs transactionDs;
  TransactionRepoImpl(this.transactionDs);

  @override
  Future<TransactionResponse> getCustomerTransactions({
    required int customerId,
  }) async {
    try {
      return await transactionDs.getCustomerTransactions(
          customerId: customerId);
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<SingleTransactionResponse> addTransaction({
    required AddTransactionRequest request,
  }) async {
    try {
      return await transactionDs.addTransaction(request: request);
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<bool> deleteTransaction({required int id}) async {
    try {
      return await transactionDs.deleteTransaction(id: id);
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }
}