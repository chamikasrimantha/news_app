import 'package:flutter/material.dart';
import 'package:news_app/views/widgets/article_card.dart';
import 'package:news_app/views/widgets/bottom_app_bar.dart';
import 'package:provider/provider.dart';
import '../../controllers/article_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _selectedDate;
  String _sortOption = 'Newest'; // Default sorting option is 'Newest'

  // Show date picker to select a custom date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      // After selecting the date, trigger sorting or filtering if needed
      _sortArticlesByDate();
    }
  }

  // Sort articles by the selected sort option
  void _sortArticlesByDate() {
    final controller = Provider.of<ArticleController>(context, listen: false);

    if (_selectedDate != null) {
      // If a specific date is selected, filter articles by that date
      controller.sortArticlesByDate(ascending: _sortOption == 'Oldest', selectedDate: _selectedDate);
    } else {
      // If no date is selected, sort by the selected option (Newest/Oldest)
      controller.sortArticlesByDate(ascending: _sortOption == 'Oldest');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black54, // Modern app bar color
        actions: [
          // Sort options: Newest, Oldest, and Custom Date
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _sortOption = value; // Set selected sort option
              });
              // Trigger sorting action
              _sortArticlesByDate();
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Newest',
                  child: Text('Sort by Newest'),
                ),
                PopupMenuItem<String>(
                  value: 'Oldest',
                  child: Text('Sort by Oldest'),
                ),
                PopupMenuItem<String>(
                  value: 'Custom Date',
                  child: Text('Sort by Custom Date'),
                ),
              ];
            },
          ),
          // Show date picker when Custom Date option is selected
          if (_sortOption == 'Custom Date')
            IconButton(
              icon: Icon(Icons.date_range),
              onPressed: () => _selectDate(context),
            ),
        ],
      ),
      body: Consumer<ArticleController>(
        builder: (context, controller, child) {
          // Fetch articles when the screen is first loaded
          if (controller.articles.isEmpty && !controller.isLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.fetchEverything();
            });
          }

          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator()); // Show a loading indicator
          } else if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!)); // Show error message if there's any error
          } else {
            // Limit the number of articles to 15
            final limitedArticles = controller.articles.take(15).toList();

            return ListView.builder(
              itemCount: limitedArticles.length,
              itemBuilder: (context, index) {
                final article = limitedArticles[index];
                return ArticleCard(article: article); // Display each article card
              },
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: 0, // Set initial selected index, you can modify it
        onItemTapped: (index) {
          // Handle bottom navigation bar item taps
        },
      ),
    );
  }
}
