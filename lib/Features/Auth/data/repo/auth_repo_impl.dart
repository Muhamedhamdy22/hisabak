import 'package:hisabak/Features/Auth/data/dataSource/auth_ds.dart';
import 'package:hisabak/Features/Auth/data/models/LoginResponse.dart';
import 'package:hisabak/Features/Auth/domin/entity/SignUpRequest.dart';
import 'package:hisabak/Features/Auth/domin/repo/auth_repo.dart';
import 'package:hisabak/core/Api/error_handling.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDs authDs;
  AuthRepoImpl(this.authDs);

  @override
  Future<LoginResponse> login(String phone, String password) async {
    try {
      var response = await authDs.login(phone, password);
      return response;
    } catch (e) {
      throw AuthFailedException("Phone or Password is incorrect");
    }
  }

  @override
  Future<LoginResponse> register(SignUpRequest request) async {
    try {
      var response = await authDs.register(request);
      return response;
    } catch (e) {
      throw AuthFailedException("Registration failed");
    }
  }
}