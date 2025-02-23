import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense.dart';

class DbProvider {
  static const _databaseName = "expense_tracker.db";
  static const _databaseVersion = 1;

  // Expense table
  static const expenseTable = 'expenses';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnAmount = 'amount';
  static const columnDate = 'date';
  static const columnCategory = 'category';

  // make this a singleton class
  DbProvider._privateConstructor();
  static final DbProvider instance = DbProvider._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // open the database
  Future<Database> _initDatabase() async {
    // Get the directory path for both Android and iOS
    String path = join(await getDatabasesPath(), _databaseName);
    
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $expenseTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnAmount REAL NOT NULL,
        $columnDate TEXT NOT NULL,
        $columnCategory TEXT NOT NULL
      )
    ''');
  }

  // Helper methods for CRUD operations

  // Insert
  Future<int> insert(Expense expense) async {
    Database db = await instance.database;
    return await db.insert(expenseTable, expense.toMap());
  }

  // Query all rows
  Future<List<Expense>> queryAllRows() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      expenseTable,
      orderBy: '$columnDate DESC'
    );
    return List.generate(maps.length, (i) => Expense.fromMap(maps[i]));
  }

  // Query specific row
  Future<Expense?> queryRow(int id) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      expenseTable,
      where: '$columnId = ?',
      whereArgs: [id]
    );
    if (maps.isEmpty) return null;
    return Expense.fromMap(maps.first);
  }

  // Update
  Future<int> update(Expense expense) async {
    Database db = await instance.database;
    return await db.update(
      expenseTable,
      expense.toMap(),
      where: '$columnId = ?',
      whereArgs: [expense.id],
    );
  }

  // Delete
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      expenseTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Delete all records
  Future<int> deleteAll() async {
    Database db = await instance.database;
    return await db.delete(expenseTable);
  }

  // Get total expenses
  Future<double> getTotalExpenses() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT SUM($columnAmount) as total FROM $expenseTable'
    );
    return result.first['total'] ?? 0.0;
  }

  // Get expenses by category
  Future<Map<ExpenseCategory, double>> getExpensesByCategory() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT $columnCategory, SUM($columnAmount) as total
      FROM $expenseTable
      GROUP BY $columnCategory
    ''');
    
    return Map.fromEntries(
      results.map((row) => MapEntry(
        ExpenseCategory.values.firstWhere((e) => e.name == row[columnCategory]),
        (row['total'] as num).toDouble(),
      )),
    );
  }

  // Get expenses by date range
  Future<List<Expense>> getExpensesByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      expenseTable,
      where: '$columnDate BETWEEN ? AND ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
      orderBy: '$columnDate DESC',
    );
    return List.generate(maps.length, (i) => Expense.fromMap(maps[i]));
  }
}
