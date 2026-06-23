import 'package:hisabak/Features/Home/data/model/dashboard_model.dart';

abstract class DashboardDs {
  Future<DashboardResponse> getDashboard();
}