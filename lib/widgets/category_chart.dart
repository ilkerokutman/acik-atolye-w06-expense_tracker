import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/expense.dart';

class CategoryPieChart extends StatelessWidget {
  final Map<ExpenseCategory, double> expensesByCategory;
  final double totalExpenses;

  const CategoryPieChart({
    super.key,
    required this.expensesByCategory,
    required this.totalExpenses,
  });

  @override
  Widget build(BuildContext context) {
    if (expensesByCategory.isEmpty || totalExpenses == 0) {
      return const Center(
        child: Text('No expense data available'),
      );
    }

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: _createPieSections(),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          startDegreeOffset: 180,
        ),
      ),
    );
  }

  List<PieChartSectionData> _createPieSections() {
    final List<PieChartSectionData> sections = [];
    
    // Define colors for each category
    final Map<ExpenseCategory, Color> categoryColors = {
      ExpenseCategory.food: Colors.orange,
      ExpenseCategory.transportation: Colors.blue,
      ExpenseCategory.entertainment: Colors.purple,
      ExpenseCategory.shopping: Colors.pink,
      ExpenseCategory.utilities: Colors.yellow.shade800,
      ExpenseCategory.health: Colors.red,
      ExpenseCategory.other: Colors.grey,
    };

    // Create pie sections for each category
    expensesByCategory.forEach((category, amount) {
      final double percentage = (amount / totalExpenses) * 100;
      final Color color = categoryColors[category] ?? Colors.grey;
      
      sections.add(
        PieChartSectionData(
          value: amount,
          title: '${percentage.toStringAsFixed(1)}%',
          color: color,
          radius: 100,
          titleStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    });

    return sections;
  }
}

class CategoryLegend extends StatelessWidget {
  final Map<ExpenseCategory, double> expensesByCategory;

  const CategoryLegend({
    super.key,
    required this.expensesByCategory,
  });

  @override
  Widget build(BuildContext context) {
    if (expensesByCategory.isEmpty) {
      return const SizedBox.shrink();
    }

    // Define colors and icons for each category
    final Map<ExpenseCategory, Color> categoryColors = {
      ExpenseCategory.food: Colors.orange,
      ExpenseCategory.transportation: Colors.blue,
      ExpenseCategory.entertainment: Colors.purple,
      ExpenseCategory.shopping: Colors.pink,
      ExpenseCategory.utilities: Colors.yellow.shade800,
      ExpenseCategory.health: Colors.red,
      ExpenseCategory.other: Colors.grey,
    };

    final Map<ExpenseCategory, IconData> categoryIcons = {
      ExpenseCategory.food: Icons.restaurant,
      ExpenseCategory.transportation: Icons.directions_car,
      ExpenseCategory.entertainment: Icons.movie,
      ExpenseCategory.shopping: Icons.shopping_bag,
      ExpenseCategory.utilities: Icons.lightbulb,
      ExpenseCategory.health: Icons.medical_services,
      ExpenseCategory.other: Icons.more_horiz,
    };

    // Create legend items for each category
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: expensesByCategory.keys.map((category) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              categoryIcons[category],
              color: categoryColors[category],
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              category.name.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
