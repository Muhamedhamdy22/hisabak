import 'package:hisabak/Features/add_customer/data/models/customar_model.dart';
import 'package:hisabak/Features/add_customer/domain/repo/customar_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCustomersUseCase {
  final CustomerRepo customerRepo;
  GetCustomersUseCase(this.customerRepo);

  Future<CustomerResponse> call() => customerRepo.getCustomers();
}

@injectable
class CreateCustomerUseCase {
  final CustomerRepo customerRepo;
  CreateCustomerUseCase(this.customerRepo);

  Future<SingleCustomerResponse> call({
    required String name,
    required String phone,
  }) =>
      customerRepo.createCustomer(name: name, phone: phone);
}

@injectable
class DeleteCustomerUseCase {
  final CustomerRepo customerRepo;
  DeleteCustomerUseCase(this.customerRepo);

  Future<bool> call({required int id}) => customerRepo.deleteCustomer(id: id);
}