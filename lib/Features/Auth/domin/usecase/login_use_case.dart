import 'package:hisabak/Features/Auth/data/models/LoginResponse.dart';
import 'package:hisabak/Features/Auth/domin/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepo authRepo;
  LoginUseCase(this.authRepo);

  Future<LoginResponse> call(String phone, String password) {
    return authRepo.login(phone, password);
  }
}