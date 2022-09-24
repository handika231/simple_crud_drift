import 'package:flutter/material.dart';
import 'package:simple_drift/page/home_page.dart';
import 'package:simple_drift/routes/router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: HomePage.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Learning Drift',
    );
  }
}
