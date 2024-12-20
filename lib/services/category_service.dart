import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/category_model.dart';

class CategoryService {
  final List<CategoryModel> _categories = []; // In-memory storage for categories

  static Database? _database;

  // Get the database instance
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // Initialize the SQLite database
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create categories table
        await db.execute('''
          CREATE TABLE categories(
            id INTEGER PRIMARY KEY,
            name TEXT
          )
        ''');

        // Create bookmarks table
        await db.execute('''
          CREATE TABLE bookmarks(
            url TEXT PRIMARY KEY,
            title TEXT,
            author TEXT,
            description TEXT,
            imageUrl TEXT,
            publishedAt TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  // Save a category (both in-memory and in the database)
  Future<void> saveCategory(CategoryModel category) async {
    final isAlreadyExists = _categories.any((existingCategory) => existingCategory.name == category.name);

    if (!isAlreadyExists) {
      _categories.add(category);

      final db = await database;
      await db.insert('categories', category.toJson());

      print("Category saved: ${category.name}");
    } else {
      print("Category already exists: ${category.name}");
    }
  }

  // Retrieve all categories (from database)
  Future<List<CategoryModel>> getAllCategories() async {
    final db = await database;

    final List<Map<String, dynamic>> categoryMaps = await db.query('categories');

    return List.generate(categoryMaps.length, (i) {
      return CategoryModel.fromJson(categoryMaps[i]);
    });
  }

  // Delete a category by name (from both in-memory and database)
  Future<void> deleteCategory(String name) async {
    final categoryToRemove = _categories.firstWhere(
          (category) => category.name == name,
      orElse: () => throw Exception("Category not found: $name"),
    );

    _categories.remove(categoryToRemove);
    print("Category removed from memory: ${categoryToRemove.name}");

    final db = await database;
    await db.delete(
      'categories',
      where: 'name = ?',
      whereArgs: [name],
    );
    print("Category removed from database: $name");
  }
}
