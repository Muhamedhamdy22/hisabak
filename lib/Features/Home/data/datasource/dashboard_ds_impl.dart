import 'package:hisabak/Features/Home/data/datasource/dashboard_ds.dart';
import 'package:hisabak/Features/Home/data/model/dashboard_model.dart';
import 'package:hisabak/core/Api/api_manager.dart';
import 'package:hisabak/core/Api/end_point.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DashboardDs)
class DashboardDsImpl implements DashboardDs {
  final ApiManager apiManager;
  DashboardDsImpl(this.apiManager);

  @override
  Future<DashboardResponse> getDashboard() async {
    try {
      var response = await apiManager.get(endpoint: EndPoint.dashboard);
      return DashboardResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}