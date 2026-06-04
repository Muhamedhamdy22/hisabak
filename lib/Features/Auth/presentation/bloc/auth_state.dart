import 'package:hisabak/Features/Auth/data/models/LoginResponse.dart';

enum RequestStatus { init,loading, success, error }
class AuthState {
  RequestStatus? LoginRequestStatus;
  String? LoginRequestMessage;
  LoginResponse ? loginResponse;
  AuthState({
    this.LoginRequestStatus,
    this.LoginRequestMessage,
    this.loginResponse
  });
  AuthState copyWith({
    RequestStatus? LoginRequestStatus,
    String? LoginRequestMessage,
    LoginResponse ? loginResponse
  }) {
    return AuthState(
      LoginRequestStatus: LoginRequestStatus ?? this.LoginRequestStatus,
      LoginRequestMessage: LoginRequestMessage ?? this.LoginRequestMessage,
      loginResponse: loginResponse ?? this.loginResponse
    );
   }

}