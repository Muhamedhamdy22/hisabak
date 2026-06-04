import 'package:hisabak/Features/Auth/data/models/LoginResponse.dart';

abstract class AuthRepo {
 Future<LoginResponse> login(String email, String password);
}