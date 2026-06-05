import 'package:hisabak/Features/Auth/data/models/LoginResponse.dart';

abstract class AuthDs {
  Future<LoginResponse> login(String email, String password);
}