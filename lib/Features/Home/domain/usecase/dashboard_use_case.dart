import 'package:hisabak/Features/Home/data/model/dashboard_model.dart';
import 'package:hisabak/Features/Home/domain/repo/dashboard_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDashboardUseCase {
   DashboardRepo dashboardRepo;
  GetDashboardUseCase(this.dashboardRepo);

  Future<DashboardResponse> call() => dashboardRepo.getDashboard();
}