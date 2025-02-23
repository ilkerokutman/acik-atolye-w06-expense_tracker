enum ExpenseCategory {
  food,
  transportation,
  entertainment,
  shopping,
  utilities,
  health,
  other
}

class Expense {
  final int? id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  // Convert Expense to Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.name,
    };
  }

  // Create Expense from Map (database row)
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: map['amount'] as double,
      date: DateTime.parse(map['date'] as String),
      category: ExpenseCategory.values.firstWhere(
        (e) => e.name == (map['category'] as String),
      ),
    );
  }

  // Create a copy of Expense with optional new values
  Expense copyWith({
    int? id,
    String? title,
    double? amount,
    DateTime? date,
    ExpenseCategory? category,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return 'Expense(id: $id, title: $title, amount: $amount, date: $date, category: $category)';
  }
}
