abstract class CustomersEvent {}

class GetCustomersEvent extends CustomersEvent {}

class CreateCustomerEvent extends CustomersEvent {
  final String name;
  final String phone;

  CreateCustomerEvent({required this.name, required this.phone});
}

class DeleteCustomerEvent extends CustomersEvent {
  final int id;

  DeleteCustomerEvent({required this.id});
}

class SearchCustomersEvent extends CustomersEvent {
  final String query;

  SearchCustomersEvent({required this.query});
}