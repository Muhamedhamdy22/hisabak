import 'package:bloc/bloc.dart';
import 'package:hisabak/Features/Auth/domin/entity/SignUpRequest.dart';
import 'package:hisabak/Features/Auth/domin/usecase/login_use_case.dart';
import 'package:hisabak/Features/Auth/domin/usecase/register_use_case.dart';
import 'package:hisabak/Features/Auth/presentation/bloc/auth_event.dart';
import 'package:hisabak/Features/Auth/presentation/bloc/auth_state.dart';
import 'package:hisabak/core/Api/error_handling.dart';
import 'package:hisabak/core/enums/request_status.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc(this.loginUseCase, this.registerUseCase) : super(AuthState()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginRequestStatus: RequestStatus.loading));
    try {
      var response = await loginUseCase.call(event.phone, event.password);
      emit(state.copyWith(
        loginRequestStatus: RequestStatus.success,
        loginResponse: response,
      ));
    } on BaseException catch (e) {
      emit(state.copyWith(
        loginRequestStatus: RequestStatus.error,
        loginRequestMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        loginRequestStatus: RequestStatus.error,
        loginRequestMessage: e.toString(),
      ));
    }
  }

  Future<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(registerRequestStatus: RequestStatus.loading));
    try {
      var response = await registerUseCase.call(
        SignUpRequest(
          name: event.name,
          phone: event.phone,
          password: event.password,
        ),
      );
      emit(state.copyWith(
        registerRequestStatus: RequestStatus.success,
        loginResponse: response,
      ));
    } on BaseException catch (e) {
      emit(state.copyWith(
        registerRequestStatus: RequestStatus.error,
        registerRequestMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        registerRequestStatus: RequestStatus.error,
        registerRequestMessage: e.toString(),
      ));
    }
  }
}