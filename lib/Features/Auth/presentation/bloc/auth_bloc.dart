import 'package:bloc/bloc.dart';
import 'package:hisabak/Features/Auth/domin/usecase/login_use_case.dart';
import 'package:hisabak/Features/Auth/presentation/bloc/auth_event.dart';
import 'package:hisabak/Features/Auth/presentation/bloc/auth_state.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Api/error_handling.dart';
@injectable
class AuthBloc extends Bloc<AuthEvent , AuthState>{
  LoginUseCase loginUseCase;
  AuthBloc(this.loginUseCase) : super(AuthState()){
    on<LoginEvent>(_login);
  }

  _login(LoginEvent event, Emitter<AuthState> emit) async{
    emit(state.copyWith(
        LoginRequestStatus: RequestStatus.loading
    ));
    try{
      var response= await loginUseCase.call(event.email, event.password);
      emit(state.copyWith(
          LoginRequestStatus: RequestStatus.success,
          loginResponse: response
      ));
    }on BaseException catch(e){
      emit(state.copyWith(
          LoginRequestStatus: RequestStatus.error,
          LoginRequestMessage: e.message
      ));
    }
    catch(e){
      emit(state.copyWith(
          LoginRequestStatus: RequestStatus.error,
          LoginRequestMessage: e.toString()
      ));
    }
  }
  // _signup(SignupEvent event, Emitter<AuthState> emit) async{
  //   emit(state.copyWith(
  //       LoginRequestStatus: RequestStatus.loading
  //   ));
  //   try{
  //     var response= await signupUsacase.call(event.request);
  //     emit(state.copyWith(
  //         SingUpRequestStatus: RequestStatus.success,
  //         SingUpResponse: response
  //     ));
  //   } catch(e){
  //     emit(state.copyWith(
  //         SingUpRequestStatus: RequestStatus.error,
  //         SingUpRequestMessage: e.toString()
  //     ));
  //   }
  // }
}