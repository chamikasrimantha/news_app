import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryController extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  List<CategoryModel> _categories = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Predefined categories
  List<CategoryModel> predefinedCategories = [
    CategoryModel(id: 1, name: "Technology"),
    CategoryModel(id: 2, name: "Business"),
    CategoryModel(id: 3, name: "Sports"),
    CategoryModel(id: 4, name: "Health"),
    CategoryModel(id: 5, name: "Entertainment"),
  ];

  CategoryController() {
    // Load predefined categories initially
    _categories.addAll(predefinedCategories);
  }

  // Save a category
  Future<void> saveCategory(CategoryModel category) async {
    try {
      _setLoading(true);
      await _categoryService.saveCategory(category); // Ensure it's awaited
      _categories = await _categoryService.getAllCategories(); // Update categories list asynchronously
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Get all categories
  Future<void> getAllCategories() async {
    try {
      _setLoading(true);
      _categories = await _categoryService.getAllCategories(); // Ensure it's awaited
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Delete a category by name
  Future<void> deleteCategory(String name) async {
    try {
      _setLoading(true);
      await _categoryService.deleteCategory(name); // Ensure it's awaited
      _categories = await _categoryService.getAllCategories(); // Update categories list asynchronously
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Helper method to set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
