import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/article_controller.dart';
import '../../models/category_model.dart';
import 'package:news_app/views/widgets/bottom_app_bar.dart';
import 'package:news_app/views/widgets/article_card.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? selectedCategory; // Initially null for no category selected
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch all categories when the screen loads
    Provider.of<CategoryController>(context, listen: false).getAllCategories();
  }

  void _fetchArticlesByCategory() {
    if (selectedCategory != null) {
      final articleController = Provider.of<ArticleController>(context, listen: false);
      articleController.fetchArticlesByCategory(selectedCategory!); // Fetch articles for the selected category
    }
  }

  void _saveCategory() {
    final categoryName = _categoryController.text.trim();
    if (categoryName.isNotEmpty) {
      final categoryController = Provider.of<CategoryController>(context, listen: false);
      final newCategory = CategoryModel(id: DateTime.now().millisecondsSinceEpoch, name: categoryName);
      categoryController.saveCategory(newCategory);
      _categoryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Categories",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: "Add New Category",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add, color: Colors.blueAccent),
                      onPressed: _saveCategory,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<CategoryController>(
                  builder: (context, categoryController, child) {
                    if (categoryController.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (categoryController.errorMessage != null) {
                      return Center(child: Text(categoryController.errorMessage!));
                    } else {
                      final categories = categoryController.categories;
                      return DropdownButton<String>(
                        value: selectedCategory,
                        hint: const Text("Select a Category"),
                        isExpanded: true,
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.name,
                            child: Text(category.name),
                          );
                        }).toList(),
                        onChanged: (String? newCategory) {
                          setState(() {
                            selectedCategory = newCategory;
                          });
                          _fetchArticlesByCategory();
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<ArticleController>(
              builder: (context, articleController, child) {
                if (articleController.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (articleController.errorMessage != null) {
                  return Center(child: Text(articleController.errorMessage!));
                } else {
                  final filteredArticles = articleController.articles;
                  if (filteredArticles.isEmpty) {
                    return const Center(child: Text("No articles found for this category."));
                  }
                  return ListView.builder(
                    itemCount: filteredArticles.length,
                    itemBuilder: (context, index) {
                      final article = filteredArticles[index];
                      return ArticleCard(article: article);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: 2, // This sets the "Categories" tab as selected
        onItemTapped: (index) {
          // Handle navigation bar item taps, if needed
        },
      ),
    );
  }
}
