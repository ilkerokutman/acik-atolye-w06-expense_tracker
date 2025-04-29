/* import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../database/db_provider.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Expense> _expenses = [];
  bool _isLoading = false;
  double _totalExpenses = 0;
  Map<ExpenseCategory, double> _expensesByCategory = {};

  List<Expense> get expenses => _expenses;
  bool get isLoading => _isLoading;
  double get totalExpenses => _totalExpenses;
  Map<ExpenseCategory, double> get expensesByCategory => _expensesByCategory;

  Future<void> loadExpenses() async {
    _isLoading = true;
    notifyListeners();

    try {
      _expenses = await DbProvider.instance.queryAllRows();
      _totalExpenses = await DbProvider.instance.getTotalExpenses();
      _expensesByCategory = await DbProvider.instance.getExpensesByCategory();
    } catch (e) {
      debugPrint('Error loading expenses: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addExpense(Expense expense) async {
    try {
      await DbProvider.instance.insert(expense);
      await loadExpenses();
    } catch (e) {
      debugPrint('Error adding expense: $e');
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      await DbProvider.instance.update(expense);
      await loadExpenses();
    } catch (e) {
      debugPrint('Error updating expense: $e');
    }
  }

  Future<void> deleteExpense(int id) async {
    try {
      await DbProvider.instance.delete(id);
      await loadExpenses();
    } catch (e) {
      debugPrint('Error deleting expense: $e');
    }
  }

  // Get weekly expenses for the last 7 days
  Map<DateTime, double> getWeeklyExpenses() {
    final Map<DateTime, double> weeklyData = {};
    final now = DateTime.now();
    
    // Initialize with the last 7 days
    for (int i = 6; i >= 0; i--) {
      final date = DateTime(now.year, now.month, now.day - i);
      weeklyData[date] = 0;
    }
    
    // Sum expenses for each day
    for (var expense in _expenses) {
      final expenseDate = DateTime(
        expense.date.year, 
        expense.date.month, 
        expense.date.day
      );
      
      // Check if expense is within the last 7 days
      if (now.difference(expenseDate).inDays <= 6) {
        weeklyData.update(
          expenseDate, 
          (value) => value + expense.amount,
          ifAbsent: () => expense.amount
        );
      }
    }
    
    return weeklyData;
  }
}
 */