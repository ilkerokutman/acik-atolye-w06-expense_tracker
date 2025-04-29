import 'package:expense_tracker/controllers/bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/main_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  await AppBindings().dependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expense Tracker',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const MainScreen(),
    );
  }
}
