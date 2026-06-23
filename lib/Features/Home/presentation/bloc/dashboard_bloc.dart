import 'package:bloc/bloc.dart';
import 'package:hisabak/Features/Home/domain/usecase/dashboard_use_case.dart';
import 'package:hisabak/Features/Home/presentation/bloc/dashboard_event.dart';
import 'package:hisabak/Features/Home/presentation/bloc/dashboard_state.dart';
import 'package:hisabak/core/enums/request_status.dart';
import 'package:injectable/injectable.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardUseCase getDashboardUseCase;

  DashboardBloc(this.getDashboardUseCase) : super(DashboardState()) {
    on<GetDashboardEvent>(_getDashboard);
  }

  Future<void> _getDashboard(
      GetDashboardEvent event,
      Emitter<DashboardState> emit,
      ) async {
    emit(state.copyWith(getDashboardStatus: RequestStatus.loading));
    try {
      var response = await getDashboardUseCase.call();
      emit(state.copyWith(
        getDashboardStatus: RequestStatus.success,
        dashboard: response.data,
      ));
    } catch (e) {
      emit(state.copyWith(
        getDashboardStatus: RequestStatus.error,
        getDashboardMessage: e.toString(),
      ));
    }
  }
}