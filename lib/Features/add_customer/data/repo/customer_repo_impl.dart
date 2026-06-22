import 'package:hisabak/Features/add_customer/data/datasource/customer_ds.dart';
import 'package:hisabak/Features/add_customer/data/models/customar_model.dart';
import 'package:hisabak/Features/add_customer/domain/repo/customar_repo.dart';
import 'package:hisabak/core/Api/error_handling.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CustomerRepo)
class CustomerRepoImpl implements CustomerRepo {
  final CustomerDs customerDs;
  CustomerRepoImpl(this.customerDs);

  @override
  Future<CustomerResponse> getCustomers() async {
    try {
      return await customerDs.getCustomers();
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<SingleCustomerResponse> createCustomer({
    required String name,
    required String phone,
  }) async {
    try {
      return await customerDs.createCustomer(name: name, phone: phone);
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<SingleCustomerResponse> updateCustomer({
    required int id,
    required String name,
    required String phone,
  }) async {
    try {
      return await customerDs.updateCustomer(id: id, name: name, phone: phone);
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<bool> deleteCustomer({required int id}) async {
    try {
      return await customerDs.deleteCustomer(id: id);
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }
}