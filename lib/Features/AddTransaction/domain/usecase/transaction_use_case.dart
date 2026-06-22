import 'package:hisabak/Features/AddTransaction/data/models/add_transaction_request.dart';
import 'package:hisabak/Features/AddTransaction/data/models/transaction_model.dart';
import 'package:hisabak/Features/AddTransaction/domain/repo/transaction_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTransactionsUseCase {
  final TransactionRepo transactionRepo;
  GetTransactionsUseCase(this.transactionRepo);

  Future<TransactionResponse> call({required int customerId}) =>
      transactionRepo.getCustomerTransactions(customerId: customerId);
}

@injectable
class AddTransactionUseCase {
  final TransactionRepo transactionRepo;
  AddTransactionUseCase(this.transactionRepo);

  Future<SingleTransactionResponse> call({
    required AddTransactionRequest request,
  }) =>
      transactionRepo.addTransaction(request: request);
}

@injectable
class DeleteTransactionUseCase {
  final TransactionRepo transactionRepo;
  DeleteTransactionUseCase(this.transactionRepo);

  Future<bool> call({required int id}) =>
      transactionRepo.deleteTransaction(id: id);
}