import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return SwitchListTile(
      title: const Text('Karanlık Mod'),
      subtitle: Text(themeProvider.isDarkMode ? 'Açık' : 'Kapalı'),
      secondary: Icon(
        themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: themeProvider.isDarkMode ? Colors.amber : Colors.blueGrey,
      ),
      value: themeProvider.isDarkMode,
      onChanged: (_) {
        themeProvider.toggleTheme();
      },
    );
  }
}
