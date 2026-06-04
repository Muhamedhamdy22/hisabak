import 'package:hisabak/Features/Auth/data/models/LoginResponse.dart';
import 'package:hisabak/Features/Auth/domin/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class LoginUseCase {
  AuthRepo authRepo;
  LoginUseCase(this.authRepo);
 Future<LoginResponse> call(String email, String password) {
    return authRepo.login(email, password);
  }
}