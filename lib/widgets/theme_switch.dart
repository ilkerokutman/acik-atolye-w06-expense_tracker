import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text('Karanlık Mod'),
      subtitle: Text(Get.isDarkMode ? 'Açık' : 'Kapalı'),
      secondary: Icon(
        Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: Get.isDarkMode ? Colors.amber : Colors.blueGrey,
      ),
      value: Get.isDarkMode,
      onChanged: (_) {
        // themeProvider.toggleTheme();
        Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
      },
    );
  }
}
