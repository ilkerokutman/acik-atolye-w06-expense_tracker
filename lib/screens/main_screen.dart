import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'expense_list_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    // Load expenses when app starts
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (mounted) {
    //     Provider.of<ExpenseProvider>(context, listen: false).loadExpenses();
    //   }
    // });
  }

  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ExpenseListScreen(),
    SettingsScreen(),
  ];

  final List<String> _titles = [
    'Özet',
    'Harcamalar',
    'Ayarlar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Harcamalar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
