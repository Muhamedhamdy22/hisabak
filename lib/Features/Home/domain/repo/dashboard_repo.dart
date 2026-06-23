import 'package:hisabak/Features/Home/data/model/dashboard_model.dart';

abstract class DashboardRepo {
  Future<DashboardResponse> getDashboard();
}