import 'package:hisabak/Features/add_customer/data/datasource/customer_ds.dart';
import 'package:hisabak/Features/add_customer/data/models/customar_model.dart';
import 'package:hisabak/core/Api/api_manager.dart';
import 'package:hisabak/core/Api/end_point.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CustomerDs)
class CustomerDsImpl implements CustomerDs {
  final ApiManager apiManager;
  CustomerDsImpl(this.apiManager);

  @override
  Future<CustomerResponse> getCustomers() async {
    try {
      var response = await apiManager.get(endpoint: EndPoint.customers);
      return CustomerResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SingleCustomerResponse> createCustomer({
    required String name,
    required String phone,
  }) async {
    try {
      var response = await apiManager.post(
        endpoint: EndPoint.customers,
        data: {'name': name, 'phone': phone},
      );
      return SingleCustomerResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SingleCustomerResponse> updateCustomer({
    required int id,
    required String name,
    required String phone,
  }) async {
    try {
      var response = await apiManager.put(
        endpoint: EndPoint.updateCustomer(id),
        data: {'name': name, 'phone': phone},
      );
      return SingleCustomerResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteCustomer({required int id}) async {
    try {
      await apiManager.delete(endpoint: EndPoint.deleteCustomer(id));
      return true;
    } catch (e) {
      rethrow;
    }
  }
}