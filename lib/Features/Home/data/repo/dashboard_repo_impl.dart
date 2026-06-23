import 'package:hisabak/Features/Home/data/datasource/dashboard_ds.dart';
import 'package:hisabak/Features/Home/data/model/dashboard_model.dart';
import 'package:hisabak/Features/Home/domain/repo/dashboard_repo.dart';
import 'package:hisabak/core/Api/error_handling.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DashboardRepo)
class DashboardRepoImpl implements DashboardRepo {
  final DashboardDs dashboardDs;
  DashboardRepoImpl(this.dashboardDs);

  @override
  Future<DashboardResponse> getDashboard() async {
    try {
      return await dashboardDs.getDashboard();
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }
}