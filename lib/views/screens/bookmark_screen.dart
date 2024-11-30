import 'package:flutter/material.dart';
import 'package:news_app/controllers/bookmark_controller.dart';
import 'package:news_app/views/widgets/article_card.dart';
import 'package:news_app/views/widgets/bottom_app_bar.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Articles', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black54, // Customize the app bar color
      ),
      body: Consumer<BookmarkController>(
        builder: (context, bookmarkController, child) {
          // Get the list of bookmarked articles (assuming BookmarkModel contains ArticleModel)
          final bookmarkedArticles = bookmarkController.bookmarks;

          // If there are no bookmarked articles
          if (bookmarkedArticles.isEmpty) {
            return Center(
              child: Text('No bookmarked articles yet!'),
            );
          }

          return ListView.builder(
            itemCount: bookmarkedArticles.length,
            itemBuilder: (context, index) {
              final bookmark = bookmarkedArticles[index];
              final article = bookmark.article;  // Extract the ArticleModel from BookmarkModel

              return ArticleCard(article: article); // Display the ArticleCard widget
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: 1, // Set to 1 since this is the Bookmark screen
        onItemTapped: (index) {
          // Handle bottom navigation bar item taps if needed
        },
      ),
    );
  }
}
