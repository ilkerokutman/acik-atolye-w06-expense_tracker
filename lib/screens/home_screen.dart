import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/category_chart.dart';
import '../widgets/weekly_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpenseController>(
      builder: (ec) {
        if (ec.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final currencyFormat = NumberFormat.currency(symbol: '₺');
        final weeklyExpenses = ec.getWeeklyExpenses();

        return RefreshIndicator(
          onRefresh: () => ec.loadExpenses(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Total expenses card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Toplam Harcama',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currencyFormat.format(ec.totalExpenses),
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${ec.expenses.length} işlem',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Category breakdown
                const Text(
                  'Kategoriye Göre Harcamalar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                if (ec.expensesByCategory.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Kategori verisi bulunamadı'),
                    ),
                  )
                else
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          CategoryPieChart(
                            expensesByCategory: ec.expensesByCategory,
                            totalExpenses: ec.totalExpenses,
                          ),
                          const SizedBox(height: 16),
                          CategoryLegend(
                            expensesByCategory: ec.expensesByCategory,
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

                // Weekly expenses
                const Text(
                  'Haftalık Harcamalar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                if (weeklyExpenses.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Haftalık veri bulunamadı'),
                    ),
                  )
                else
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: WeeklyExpenseChart(
                        weeklyExpenses: weeklyExpenses,
                      ),
                    ),
                  ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
