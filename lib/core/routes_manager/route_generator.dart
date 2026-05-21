// import 'package:flutter/material.dart';
//
//
// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings settings) {
//     switch (settings.name) {
//
//       case Routes.loginRoute:
//         return MaterialPageRoute(builder: (_) => const LoginScreen());
//
//       case Routes.signUpRoute:
//         return MaterialPageRoute(builder: (_) => const SignUpScreen());
//
//       case Routes.homeRoute:
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//
//       case Routes.customersRoute:
//         return MaterialPageRoute(builder: (_) => const CustomersScreen());
//
//       case Routes.customerDetail:
//         {
//           final customerId = settings.arguments as int;
//           return MaterialPageRoute(
//             builder: (_) => CustomerDetailScreen(customerId: customerId),
//           );
//         }
//
//       case Routes.addCustomer:
//         return MaterialPageRoute(builder: (_) => const AddCustomerScreen());
//
//       case Routes.addTransaction:
//         {
//           final customerId = settings.arguments as int;
//           return MaterialPageRoute(
//             builder: (_) => AddTransactionScreen(customerId: customerId),
//           );
//         }
//
//       case Routes.settingsRoute:
//         return MaterialPageRoute(builder: (_) => const SettingsScreen());
//
//       default:
//         return unDefinedRoute();
//     }
//   }
//
//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         appBar: AppBar(
//           title: const Text('No Route Found'),
//         ),
//         body: const Center(
//           child: Text('No Route Found'),
//         ),
//       ),
//     );
//   }
// }