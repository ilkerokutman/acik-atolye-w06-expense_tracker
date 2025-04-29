import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(symbol: '₺');

    // Get icon and color based on category
    IconData categoryIcon;
    Color categoryColor;

    switch (expense.category) {
      case ExpenseCategory.food:
        categoryIcon = Icons.restaurant;
        categoryColor = Colors.orange;
        break;
      case ExpenseCategory.transportation:
        categoryIcon = Icons.directions_car;
        categoryColor = Colors.blue;
        break;
      case ExpenseCategory.entertainment:
        categoryIcon = Icons.movie;
        categoryColor = Colors.purple;
        break;
      case ExpenseCategory.shopping:
        categoryIcon = Icons.shopping_bag;
        categoryColor = Colors.pink;
        break;
      case ExpenseCategory.utilities:
        categoryIcon = Icons.lightbulb;
        categoryColor = Colors.yellow.shade800;
        break;
      case ExpenseCategory.health:
        categoryIcon = Icons.medical_services;
        categoryColor = Colors.red;
        break;
      case ExpenseCategory.other:
        categoryIcon = Icons.more_horiz;
        categoryColor = Colors.grey;
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Category icon
            CircleAvatar(
              backgroundColor: categoryColor.withAlpha(51), // 0.2 opacity = 51 alpha (255 * 0.2)
              child: Icon(categoryIcon, color: categoryColor),
            ),
            const SizedBox(width: 16),
            // Expense details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat.yMMMd().format(expense.date),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            // Amount
            Text(
              currencyFormat.format(expense.amount),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            // Actions
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'edit') {
                  onEdit();
                } else if (value == 'delete') {
                  onDelete();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
