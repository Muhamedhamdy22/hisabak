import 'package:hisabak/Features/Auth/data/models/LoginResponse.dart';
import 'package:hisabak/core/enums/request_status.dart';

class AuthState {
  final RequestStatus? loginRequestStatus;
  final String? loginRequestMessage;
  final LoginResponse? loginResponse;
  final RequestStatus? registerRequestStatus;
  final String? registerRequestMessage;

  AuthState({
    this.loginRequestStatus,
    this.loginRequestMessage,
    this.loginResponse,
    this.registerRequestStatus,
    this.registerRequestMessage,
  });

  AuthState copyWith({
    RequestStatus? loginRequestStatus,
    String? loginRequestMessage,
    LoginResponse? loginResponse,
    RequestStatus? registerRequestStatus,
    String? registerRequestMessage,
  }) {
    return AuthState(
      loginRequestStatus: loginRequestStatus ?? this.loginRequestStatus,
      loginRequestMessage: loginRequestMessage ?? this.loginRequestMessage,
      loginResponse: loginResponse ?? this.loginResponse,
      registerRequestStatus: registerRequestStatus ?? this.registerRequestStatus,
      registerRequestMessage: registerRequestMessage ?? this.registerRequestMessage,
    );
  }
}