import 'package:hisabak/Features/add_customer/data/models/customar_model.dart';

abstract class CustomerRepo {
  Future<CustomerResponse> getCustomers();
  Future<SingleCustomerResponse> createCustomer({required String name, required String phone});
  Future<SingleCustomerResponse> updateCustomer({required int id, required String name, required String phone});
  Future<bool> deleteCustomer({required int id});
}