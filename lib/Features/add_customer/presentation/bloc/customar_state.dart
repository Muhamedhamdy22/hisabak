import 'package:hisabak/Features/add_customer/data/models/customar_model.dart';
import 'package:hisabak/core/enums/request_status.dart';

class CustomersState {
  final RequestStatus getCustomersStatus;
  final List<CustomerModel> customers;
  final List<CustomerModel> filteredCustomers;
  final String? getCustomersMessage;
  final RequestStatus createCustomerStatus;
  final CustomerModel? createdCustomer;
  final String? createCustomerMessage;
  final RequestStatus deleteCustomerStatus;
  final String? deleteCustomerMessage;

  CustomersState({
    this.getCustomersStatus = RequestStatus.init,
    this.customers = const [],
    this.filteredCustomers = const [],
    this.getCustomersMessage,
    this.createCustomerStatus = RequestStatus.init,
    this.createdCustomer,
    this.createCustomerMessage,
    this.deleteCustomerStatus = RequestStatus.init,
    this.deleteCustomerMessage,
  });

  CustomersState copyWith({
    RequestStatus? getCustomersStatus,
    List<CustomerModel>? customers,
    List<CustomerModel>? filteredCustomers,
    String? getCustomersMessage,
    RequestStatus? createCustomerStatus,
    CustomerModel? createdCustomer,
    String? createCustomerMessage,
    RequestStatus? deleteCustomerStatus,
    String? deleteCustomerMessage,
  }) {
    return CustomersState(
      getCustomersStatus: getCustomersStatus ?? this.getCustomersStatus,
      customers: customers ?? this.customers,
      filteredCustomers: filteredCustomers ?? this.filteredCustomers,
      getCustomersMessage: getCustomersMessage ?? this.getCustomersMessage,
      createCustomerStatus: createCustomerStatus ?? this.createCustomerStatus,
      createdCustomer: createdCustomer ?? this.createdCustomer,
      createCustomerMessage: createCustomerMessage ?? this.createCustomerMessage,
      deleteCustomerStatus: deleteCustomerStatus ?? this.deleteCustomerStatus,
      deleteCustomerMessage: deleteCustomerMessage ?? this.deleteCustomerMessage,
    );
  }
}