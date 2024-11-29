import '../models/category_model.dart';

class CategoryService {
  final List<CategoryModel> _categories = []; // In-memory storage for categories

  // Save a category
  void saveCategory(CategoryModel category) {
    // Check if the category already exists (based on name)
    final isAlreadyExists = _categories.any((existingCategory) => existingCategory.name == category.name);

    if (!isAlreadyExists) {
      _categories.add(category);
      print("Category saved: ${category.name}");
    } else {
      print("Category already exists: ${category.name}");
    }
  }

  // Retrieve all categories
  List<CategoryModel> getAllCategories() {
    return _categories;
  }

  // Delete a category by name
  void deleteCategory(String name) {
    final categoryToRemove = _categories.firstWhere(
          (category) => category.name == name,
      orElse: () => throw Exception("Category not found: $name"),
    );

    _categories.remove(categoryToRemove);
    print("Category removed: ${categoryToRemove.name}");
  }
}
