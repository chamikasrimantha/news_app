import 'package:flutter/material.dart';
import 'package:news_app/controllers/article_controller.dart';
import 'package:provider/provider.dart';
import '../widgets/article_card.dart'; // Import the ArticleCard widget
import '../widgets/bottom_app_bar.dart'; // Import BottomAppBar

class HeadlinesScreen extends StatelessWidget {
  final List<String> countries = ['us', 'gb', 'ca', 'in', 'au']; // List of supported countries

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<ArticleController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(child: Text('Error: ${controller.errorMessage}'));
          }

          return Column(
            children: [
              // Dropdown for selecting country
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButton<String>(
                  hint: Text('Select Country'),
                  value: null, // Currently no selected value, use null for default
                  onChanged: (newCountry) async {
                    if (newCountry != null) {
                      // Fetch top headlines based on selected country
                      await controller.fetchTopHeadlines(country: newCountry);
                    }
                  },
                  items: countries.map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country.toUpperCase()),
                    );
                  }).toList(),
                ),
              ),
              // List of ArticleCards based on fetched articles
              Expanded(
                child: ListView.builder(
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    final article = controller.articles[index];
                    return ArticleCard(article: article);
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: 0, // Set the index for active bottom navigation item
        onItemTapped: (index) {
          // Handle bottom navigation bar item taps if needed
        },
      ),
    );
  }
}
