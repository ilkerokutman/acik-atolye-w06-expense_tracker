import 'package:expense_tracker/database/db_provider.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  //
  @override
  void onReady() {
    super.onReady();
    loadExpenses();
  }

  final RxList<Expense> _expenses = <Expense>[].obs;
  final RxBool _isLoading = false.obs;
  final Rx<double> _totalExpenses = 0.0.obs;
  final RxMap<ExpenseCategory, double> _expensesByCategory =
      <ExpenseCategory, double>{}.obs;

  List<Expense> get expenses => _expenses;
  bool get isLoading => _isLoading.value;
  double get totalExpenses => _totalExpenses.value;
  Map<ExpenseCategory, double> get expensesByCategory => _expensesByCategory;

  Future<void> loadExpenses() async {
    _isLoading.value = true;
    update();

    final expensesResult = await DbProvider.instance.queryAllRows();
    final totalExpensesResult = await DbProvider.instance.getTotalExpenses();
    final expensesByCategoryResult =
        await DbProvider.instance.getExpensesByCategory();

    _expenses.value = expensesResult;
    _totalExpenses.value = totalExpensesResult;
    _expensesByCategory.value = expensesByCategoryResult;

    _isLoading.value = false;
    update();
  }

  Future<void> addExpense(Expense expense) async {
    _isLoading.value = true;
    update();

    try {
      await DbProvider.instance.insert(expense);
      await loadExpenses();
    } catch (e) {
      debugPrint('Error adding expense: $e');
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  Future<void> updateExpense(Expense expense) async {
    _isLoading.value = true;
    update();

    try {
      await DbProvider.instance.update(expense);
      await loadExpenses();
    } catch (e) {
      debugPrint('Error updating expense: $e');
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  Future<void> deleteExpense(int id) async {
    _isLoading.value = true;
    update();

    try {
      await DbProvider.instance.delete(id);
      await loadExpenses();
    } catch (e) {
      debugPrint('Error deleting expense: $e');
    } finally {
      _isLoading.value = false;
      update();
    }
  }

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
      final expenseDate =
          DateTime(expense.date.year, expense.date.month, expense.date.day);

      // Check if expense is within the last 7 days
      if (now.difference(expenseDate).inDays <= 6) {
        weeklyData.update(expenseDate, (value) => value + expense.amount,
            ifAbsent: () => expense.amount);
      }
    }

    return weeklyData;
  }
}
