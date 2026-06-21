import 'package:bloc/bloc.dart';
import 'package:hisabak/Features/AddTransaction/data/models/add_transaction_request.dart';
import 'package:hisabak/Features/AddTransaction/domain/usecase/transaction_use_case.dart';
import 'package:hisabak/Features/AddTransaction/presentation/bloc/transaction_event.dart';
import 'package:hisabak/Features/AddTransaction/presentation/bloc/transaction_state.dart';
import 'package:hisabak/core/enums/request_status.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionsUseCase getTransactionsUseCase;
  final AddTransactionUseCase addTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;

  TransactionBloc(
      this.getTransactionsUseCase,
      this.addTransactionUseCase,
      this.deleteTransactionUseCase,
      ) : super(TransactionState()) {
    on<GetTransactionsEvent>(_getTransactions);
    on<AddTransactionEvent>(_addTransaction);
    on<DeleteTransactionEvent>(_deleteTransaction);
    on<SelectTypeEvent>(_selectType);
  }

  Future<void> _getTransactions(
      GetTransactionsEvent event,
      Emitter<TransactionState> emit,
      ) async {
    emit(state.copyWith(getTransactionsStatus: RequestStatus.loading));
    try {
      var response = await getTransactionsUseCase.call(
        customerId: event.customerId,
      );
      emit(state.copyWith(
        getTransactionsStatus: RequestStatus.success,
        transactions: response.data ?? [],
      ));
    } catch (e) {
      emit(state.copyWith(
        getTransactionsStatus: RequestStatus.error,
        getTransactionsMessage: e.toString(),
      ));
    }
  }

  Future<void> _addTransaction(
      AddTransactionEvent event,
      Emitter<TransactionState> emit,
      ) async {
    emit(state.copyWith(addTransactionStatus: RequestStatus.loading));
    try {
      var response = await addTransactionUseCase.call(
        request: AddTransactionRequest(
          customerId: event.customerId,
          type: event.type,
          amount: event.amount,
          note: event.note,
        ),
      );

      final updatedList = [...state.transactions, response.data!];

      emit(state.copyWith(
        addTransactionStatus: RequestStatus.success,
        addedTransaction: response.data,
        waLink: response.waLink,
        transactions: updatedList,
      ));

      if (response.waLink != null) {
        await _openWhatsApp(response.waLink!);
      }
    } catch (e) {
      emit(state.copyWith(
        addTransactionStatus: RequestStatus.error,
        addTransactionMessage: e.toString(),
      ));
    }
  }

  Future<void> _deleteTransaction(
      DeleteTransactionEvent event,
      Emitter<TransactionState> emit,
      ) async {
    emit(state.copyWith(deleteTransactionStatus: RequestStatus.loading));
    try {
      await deleteTransactionUseCase.call(id: event.id);
      final updatedList =
      state.transactions.where((t) => t.id != event.id).toList();
      emit(state.copyWith(
        deleteTransactionStatus: RequestStatus.success,
        transactions: updatedList,
      ));
    } catch (e) {
      emit(state.copyWith(
        deleteTransactionStatus: RequestStatus.error,
        deleteTransactionMessage: e.toString(),
      ));
    }
  }

  void _selectType(
      SelectTypeEvent event,
      Emitter<TransactionState> emit,
      ) {
    emit(state.copyWith(selectedType: event.type));
  }

  Future<void> _openWhatsApp(String waLink) async {
    final uri = Uri.parse(waLink);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}