import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/db_provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/theme_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isResetting = false;

  void _showResetConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Veritabanını Sıfırla'),
        content: const Text('Tüm harcama verilerini silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetDatabase(context);
            },
            child: const Text(
              'Sıfırla',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _resetDatabase(BuildContext context) async {
    // Store the context reference before the async gap
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    
    setState(() {
      _isResetting = true;
    });

    try {
      // Delete all expenses from the database
      await DbProvider.instance.deleteAll();
      
      // Refresh the expense provider
      if (mounted) {
        await expenseProvider.loadExpenses();
        
        // Show success message
        if (mounted) {
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              content: Text('Veritabanı başarıyla sıfırlandı'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Hata: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isResetting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 16),
          
          // App info card
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Harcama Takibi',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            'Sürüm 1.0.0',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const Divider(),
          
          // Theme settings
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'GÖRÜNÜM',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const ThemeSwitch(),
          
          const Divider(),
          
          // About section
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('Hakkında'),
            subtitle: Text('Bu uygulama hakkında daha fazla bilgi edinin'),
          ),
          
          const ListTile(
            leading: Icon(Icons.code),
            title: Text('Sürüm'),
            subtitle: Text('1.0.0'),
          ),
          
          const Divider(),
          
          // Database reset option
          ListTile(
            leading: _isResetting 
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Veritabanını Sıfırla'),
            subtitle: const Text('Tüm harcama verilerini siler'),
            onTap: _isResetting ? null : () => _showResetConfirmation(context),
            enabled: !_isResetting,
          ),
        ],
      ),
    );
  }
}
