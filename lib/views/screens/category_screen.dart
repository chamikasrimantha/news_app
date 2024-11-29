import 'package:flutter/material.dart';
import 'package:news_app/views/widgets/bottom_app_bar.dart'; // Assuming you have this widget
import 'package:news_app/views/widgets/article_card.dart'; // Assuming this widget is used for displaying articles
import 'package:provider/provider.dart';
import '../../controllers/article_controller.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Dummy list of categories
  final List<String> categories = ['Technology', 'Sports', 'Business', 'Health', 'Entertainment'];
  String selectedCategory = 'Technology'; // Default selected category

  // Fetch articles based on the selected category
  void _fetchArticlesByCategory() {
    final controller = Provider.of<ArticleController>(context, listen: false);
    controller.fetchArticlesByCategory(selectedCategory); // This would be a method to filter articles by category
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Category selection dropdown or list
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (String? newCategory) {
              if (newCategory != null) {
                setState(() {
                  selectedCategory = newCategory;
                });
                _fetchArticlesByCategory(); // Fetch articles when a new category is selected
              }
            },
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
          // Display articles based on the selected category
          Consumer<ArticleController>(
            builder: (context, controller, child) {
              if (controller.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.errorMessage != null) {
                return Center(child: Text(controller.errorMessage!));
              } else {
                final filteredArticles = controller.articles; // Assuming articles are filtered by category
                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredArticles.length,
                    itemBuilder: (context, index) {
                      final article = filteredArticles[index];
                      return ArticleCard(article: article); // Display each article card
                    },
                  ),
                );
              }
            },
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
