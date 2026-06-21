import 'package:hisabak/Features/AddTransaction/data/datasource/transaction_ds.dart';
import 'package:hisabak/Features/AddTransaction/data/models/add_transaction_request.dart';
import 'package:hisabak/Features/AddTransaction/data/models/transaction_model.dart';
import 'package:hisabak/core/Api/api_manager.dart';
import 'package:hisabak/core/Api/end_point.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TransactionDs)
class TransactionDsImpl implements TransactionDs {
  final ApiManager apiManager;
  TransactionDsImpl(this.apiManager);

  @override
  Future<TransactionResponse> getCustomerTransactions({
    required int customerId,
  }) async {
    try {
      var response = await apiManager.get(
        endpoint: EndPoint.customerTransactions(customerId),
      );
      return TransactionResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SingleTransactionResponse> addTransaction({
    required AddTransactionRequest request,
  }) async {
    try {
      var response = await apiManager.post(
        endpoint: EndPoint.transactions,
        data: request.toJson(),
      );
      return SingleTransactionResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteTransaction({required int id}) async {
    try {
      await apiManager.delete(endpoint: EndPoint.deleteTransaction(id));
      return true;
    } catch (e) {
      rethrow;
    }
  }
}