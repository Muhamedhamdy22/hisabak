import 'package:hisabak/Features/Home/data/model/dashboard_model.dart';
import 'package:hisabak/core/enums/request_status.dart';

class DashboardState {
  final RequestStatus getDashboardStatus;
  final DashboardModel? dashboard;
  final String? getDashboardMessage;

  DashboardState({
    this.getDashboardStatus = RequestStatus.init,
    this.dashboard,
    this.getDashboardMessage,
  });

  DashboardState copyWith({
    RequestStatus? getDashboardStatus,
    DashboardModel? dashboard,
    String? getDashboardMessage,
  }) {
    return DashboardState(
      getDashboardStatus: getDashboardStatus ?? this.getDashboardStatus,
      dashboard: dashboard ?? this.dashboard,
      getDashboardMessage: getDashboardMessage ?? this.getDashboardMessage,
    );
  }
}