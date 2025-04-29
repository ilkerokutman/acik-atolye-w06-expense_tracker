import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/expense.dart';
import '../widgets/expense_card.dart';
import 'expense_form_screen.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpenseController>(
      builder: (ec) {
        if (ec.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final expenses = ec.expenses;

        return Scaffold(
          body: expenses.isEmpty
              ? _buildEmptyState(context)
              : RefreshIndicator(
                  onRefresh: () => ec.loadExpenses(),
                  child: ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return ExpenseCard(
                        expense: expense,
                        onEdit: () => _navigateToEditExpense(context, expense),
                        onDelete: () =>
                            _showDeleteConfirmation(context, expense),
                      );
                    },
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _navigateToAddExpense(context),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 80,
            color: Theme.of(context)
                .colorScheme
                .primary
                .withAlpha(128), // 0.5 opacity = 128 alpha (255 * 0.5)
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz harcama yok',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'İlk harcamanızı eklemek için + düğmesine dokunun',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _navigateToAddExpense(context),
            icon: const Icon(Icons.add),
            label: const Text('Harcama Ekle'),
          ),
        ],
      ),
    );
  }

  void _navigateToAddExpense(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ExpenseFormScreen(),
      ),
    );
  }

  void _navigateToEditExpense(BuildContext context, Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseFormScreen(expense: expense),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Expense expense) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Harcamayı Sil'),
        content: Text(
            '"${expense.title}" harcamasını silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              // final expenseProvider =
              //     Provider.of<ExpenseProvider>(context, listen: false);

              final ExpenseController controller = Get.find();
              controller.deleteExpense(expense.id!);
              Navigator.pop(context);
            },
            child: const Text(
              'Sil',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
