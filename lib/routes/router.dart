import 'package:flutter/material.dart';
import 'package:simple_drift/page/edit_employee_page.dart';
import 'package:simple_drift/page/home_page.dart';

import '../page/add_employee_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case AddEmployeePage.routeName:
        return MaterialPageRoute(
          builder: (_) => const AddEmployeePage(),
        );
      case EditEmployeePage.routeName:
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => EditEmployeePage(args: args),
          );
        } else {
          return _errorPage();
        }
      default:
        return MaterialPageRoute(
          builder: (_) => _errorPage(),
        );
    }
  }
}

_errorPage() {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Error'),
    ),
    body: const Center(
      child: Text('Error Page'),
    ),
  );
}
