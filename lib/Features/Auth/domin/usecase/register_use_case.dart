import 'package:hisabak/Features/Auth/data/models/LoginResponse.dart';
import 'package:hisabak/Features/Auth/domin/entity/SignUpRequest.dart';
import 'package:hisabak/Features/Auth/domin/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final AuthRepo authRepo;
  RegisterUseCase(this.authRepo);

  Future<LoginResponse> call(SignUpRequest request) async {
    return await authRepo.register(request);
  }
}