import 'package:flutter/material.dart';
import 'package:jimu_app/jimu_providers.dart';

import 'package:jimu_app/jimu_routes.dart';

class JimuApp extends StatelessWidget {
  const JimuApp({
    required this.initialRoute,
    super.key,
  });

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jimu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme(
            primary: Theme.of(context).colorScheme.primary,
            background: Colors.brown[50]!,
            brightness: Theme.of(context).colorScheme.brightness,
            error: Theme.of(context).colorScheme.error,
            onBackground: Theme.of(context).colorScheme.onBackground,
            onError: Theme.of(context).colorScheme.onError,
            onPrimary: Theme.of(context).colorScheme.onPrimary,
            onSecondary: Theme.of(context).colorScheme.onSecondary,
            onSurface: Theme.of(context).colorScheme.onSurface,
            secondary: Theme.of(context).colorScheme.secondary,
            surface: Theme.of(context).colorScheme.background,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.lightBlue[400],
          unselectedItemColor: Colors.white.withOpacity(0.5),
          selectedItemColor: Colors.white,
        ),
      ),
      initialRoute: initialRoute,
      routes: jimuRoutes(),
      builder: (
        BuildContext context,
        Widget? child,
      ) =>
          Scaffold(
        body: JimuProviders(
          child: child,
        ),
      ),
    );
  }
}
