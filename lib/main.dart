import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hisabak/core/constants/app_theme.dart';
import 'package:hisabak/core/helper/shared_pref_helper.dart';
import 'package:hisabak/core/routes_manager/route.dart';
import 'package:hisabak/core/routes_manager/route_generator.dart';
import 'package:hisabak/di.dart';

import 'l10n/app_localizations.dart' show AppLocalizations;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  configureDependencies();
  runApp(const HisabakApp());
}

class HisabakApp extends StatefulWidget {
  const HisabakApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    _HisabakAppState? state =
    context.findAncestorStateOfType<_HisabakAppState>();
    state?.setLocale(locale);
  }

  @override
  State<HisabakApp> createState() => _HisabakAppState();
}

class _HisabakAppState extends State<HisabakApp> {
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    final savedLang = SharedPrefHelper.getLang();
    if (savedLang != null) {
      _locale = Locale(savedLang);
    }
  }

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    final initialRoute = SharedPrefHelper.isLoggedIn()
        ? Routes.homeRoute
        : Routes.loginRoute;

    return MaterialApp(
      title: 'Hisabak',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: initialRoute,
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}