import 'package:flutter/material.dart';
import 'package:hisabak/Features/Auth/presentation/screens/loginscreen.dart';
import 'package:hisabak/Features/Auth/presentation/screens/signUpscreen.dart';
import 'package:hisabak/Features/CustomerDetails/presentation/screens/customer_details.dart';
import 'package:hisabak/Features/Customers/presentation/screens/customers_screen.dart';
import 'package:hisabak/Features/Home/presentation/screens/home_screen.dart';
import 'package:hisabak/core/routes_manager/route.dart';

import '../../Features/Add Customer/presentation/screens/add_customer_screen.dart' show AddCustomerScreen;
import '../../Features/AddTransaction/presentation/screens/add_transaction_screen.dart' show AddTransactionScreen;
import '../../Features/Settings/presentation/screens/setting_screen.dart' show SettingsScreen;


class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());

      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) =>  SignUpScreen());

      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) =>  HomeScreen());

      case Routes.customersRoute:
        return MaterialPageRoute(builder: (_) =>  CustomersScreen());

      case Routes.customerDetail:
        {
          final customerId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => CustomerDetailScreen(customerId: customerId),
          );
        }

      case Routes.addCustomer:
        return MaterialPageRoute(builder: (_) =>  AddCustomerScreen());

      case Routes.addTransaction:
        {
          final customerId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => AddTransactionScreen(customerId: customerId),
          );
        }

      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) =>  SettingsScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(
          child: Text('No Route Found'),
        ),
      ),
    );
  }
}