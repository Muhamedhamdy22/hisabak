import 'package:flutter/material.dart';
import 'package:hisabak/core/constants/app_theme.dart';
import 'package:hisabak/core/helper/shared_pref_helper.dart';
import 'package:hisabak/core/routes_manager/route.dart';
import 'package:hisabak/core/routes_manager/route_generator.dart';
import 'package:hisabak/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  configureDependencies();
  runApp(const HisabakApp());
}

class HisabakApp extends StatelessWidget {
  const HisabakApp({super.key});

  @override
  Widget build(BuildContext context) {
    final initialRoute = SharedPrefHelper.isLoggedIn()
        ? Routes.homeRoute
        : Routes.loginRoute;

    return MaterialApp(
      title: 'Hisabak',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: initialRoute,
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}