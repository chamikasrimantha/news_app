import 'package:flutter/material.dart';
import 'package:news_app/views/widgets/article_card.dart';
import 'package:news_app/views/widgets/bottom_app_bar.dart';
import 'package:provider/provider.dart'; // Import provider for state management
import '../../controllers/article_controller.dart'; // Import the ArticleController

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController(); // Controller for search field

  @override
  void initState() {
    super.initState();
  }

  // Function to call search when user presses search button
  void _searchArticles() {
    final articleController = Provider.of<ArticleController>(context, listen: false);
    articleController.searchArticles(_searchController.text); // Call searchArticles with the query
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search News", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black54, // AppBar with blue accent
      ),
      body: Consumer<ArticleController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator()); // Show loading spinner if fetching
          } else if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!)); // Show error message if any error occurred
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for articles...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: _searchArticles, // Trigger search on button press
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.articles.length,
                    itemBuilder: (context, index) {
                      final article = controller.articles[index];
                      return ArticleCard(article: article); // Display article cards
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: 1, // Set index to indicate active screen (Search)
        onItemTapped: (index) {
          // Handle bottom navigation bar item taps
        },
      ),
    );
  }
}
