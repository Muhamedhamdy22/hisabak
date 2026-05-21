import 'package:flutter/material.dart';
import 'package:hisabak/core/constants/app_theme.dart';
import 'package:hisabak/core/routes_manager/route.dart';
import 'package:hisabak/core/routes_manager/route_generator.dart';
import 'package:hisabak/di.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
   configureDependencies();
  runApp(const HisabakApp());
}

class HisabakApp extends StatelessWidget {
  const HisabakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hisabak',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: Routes.homeRoute,
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}