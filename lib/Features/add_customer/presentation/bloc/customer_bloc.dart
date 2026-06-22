import 'package:bloc/bloc.dart';
import 'package:hisabak/Features/add_customer/domain/usecase/customar_use_case.dart';
import 'package:hisabak/Features/add_customer/presentation/bloc/customar_events.dart';
import 'package:hisabak/Features/add_customer/presentation/bloc/customar_state.dart';
import 'package:hisabak/core/enums/request_status.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  final GetCustomersUseCase getCustomersUseCase;
  final CreateCustomerUseCase createCustomerUseCase;
  final DeleteCustomerUseCase deleteCustomerUseCase;

  CustomersBloc(
      this.getCustomersUseCase,
      this.createCustomerUseCase,
      this.deleteCustomerUseCase,
      ) : super(CustomersState()) {
    on<GetCustomersEvent>(_getCustomers);
    on<CreateCustomerEvent>(_createCustomer);
    on<DeleteCustomerEvent>(_deleteCustomer);
    on<SearchCustomersEvent>(_searchCustomers);
  }

  Future<void> _getCustomers(
      GetCustomersEvent event,
      Emitter<CustomersState> emit,
      ) async {
    emit(state.copyWith(getCustomersStatus: RequestStatus.loading));
    try {
      var response = await getCustomersUseCase.call();
      emit(state.copyWith(
        getCustomersStatus: RequestStatus.success,
        customers: response.data ?? [],
        filteredCustomers: response.data ?? [],
      ));
    } catch (e) {
      emit(state.copyWith(
        getCustomersStatus: RequestStatus.error,
        getCustomersMessage: e.toString(),
      ));
    }
  }

  Future<void> _createCustomer(
      CreateCustomerEvent event,
      Emitter<CustomersState> emit,
      ) async {
    emit(state.copyWith(createCustomerStatus: RequestStatus.loading));
    try {
      var response = await createCustomerUseCase.call(
        name: event.name,
        phone: event.phone,
      );
      final updatedList = [...state.customers, response.data!];
      emit(state.copyWith(
        createCustomerStatus: RequestStatus.success,
        createdCustomer: response.data,
        customers: updatedList,
        filteredCustomers: updatedList,
      ));
    } catch (e) {
      emit(state.copyWith(
        createCustomerStatus: RequestStatus.error,
        createCustomerMessage: e.toString(),
      ));
    }
  }

  Future<void> _deleteCustomer(
      DeleteCustomerEvent event,
      Emitter<CustomersState> emit,
      ) async {
    emit(state.copyWith(deleteCustomerStatus: RequestStatus.loading));
    try {
      await deleteCustomerUseCase.call(id: event.id);
      final updatedList =
      state.customers.where((c) => c.id != event.id).toList();
      emit(state.copyWith(
        deleteCustomerStatus: RequestStatus.success,
        customers: updatedList,
        filteredCustomers: updatedList,
      ));
    } catch (e) {
      emit(state.copyWith(
        deleteCustomerStatus: RequestStatus.error,
        deleteCustomerMessage: e.toString(),
      ));
    }
  }

  void _searchCustomers(
      SearchCustomersEvent event,
      Emitter<CustomersState> emit,
      ) {
    final query = event.query.toLowerCase();
    final filtered = state.customers
        .where((c) =>
    c.name!.toLowerCase().contains(query) ||
        c.phone!.toLowerCase().contains(query))
        .toList();
    emit(state.copyWith(filteredCustomers: filtered));
  }
}