import 'package:hisabak/Features/Auth/data/models/LoginResponse.dart';
import 'package:hisabak/Features/Auth/domin/entity/SignUpRequest.dart';

abstract class AuthDs {
  Future<LoginResponse> login(String phone, String password);
  Future<LoginResponse> register(SignUpRequest request);
}