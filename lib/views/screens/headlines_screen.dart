import 'package:flutter/material.dart';
import 'package:news_app/controllers/article_controller.dart';
import 'package:provider/provider.dart';
import '../widgets/article_card.dart'; // Import the ArticleCard widget
import '../widgets/bottom_app_bar.dart'; // Import BottomAppBar

class HeadlinesScreen extends StatefulWidget {
  @override
  _HeadlinesScreenState createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  final List<String> countries = ['us', 'gb', 'ca', 'in', 'au']; // List of supported countries
  String? selectedCountry; // To keep track of selected country

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top Headlines',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedCountry,
              hint: const Text("Select Country"),
              isExpanded: true,
              onChanged: (String? newCountry) async {
                if (newCountry != null) {
                  setState(() {
                    selectedCountry = newCountry;
                  });
                  // Fetch top headlines for the selected country
                  await Provider.of<ArticleController>(context, listen: false)
                      .fetchTopHeadlines(country: newCountry);
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
          Expanded(
            child: Consumer<ArticleController>(
              builder: (context, controller, child) {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage != null) {
                  return Center(child: Text('Error: ${controller.errorMessage}'));
                }

                if (controller.articles.isEmpty) {
                  return const Center(child: Text("No articles found for this country."));
                }

                return ListView.builder(
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    final article = controller.articles[index];
                    return ArticleCard(article: article);
                  },
                );
              },
            ),
          ),
        ],
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
