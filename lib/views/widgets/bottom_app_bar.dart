import 'package:flutter/material.dart';

// Import your screen files here
import '../screens/home_screen.dart';       // Assuming you have a HomeScreen
import '../screens/search_screen.dart';     // Assuming you have a SearchScreen
import '../screens/category_screen.dart'; // Assuming you have a CategoriesScreen
import '../screens/headlines_screen.dart';  // Assuming you have a HeadlinesScreen
import '../screens/bookmark_screen.dart';  // Assuming you have a BookmarksScreen
import '../screens/sources_screen.dart';    // Assuming you have a SourcesScreen

class CustomBottomAppBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomAppBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black54, // App bar background color
      shape: CircularNotchedRectangle(), // To give the floating action button space
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(context, Icons.home, "Home", 0, HomeScreen()),
            _buildIconButton(context, Icons.search, "Search", 1, SearchScreen()),
            _buildIconButton(context, Icons.category, "Categories", 2, CategoryScreen()),
            _buildIconButton(context, Icons.view_headline_outlined, "Headlines", 3, HeadlinesScreen()),
            _buildIconButton(context, Icons.bookmark, "Bookmarks", 4, BookmarkScreen()),
            _buildIconButton(context, Icons.source, "Sources", 5, SourcesScreen()),
          ],
        ),
      ),
    );
  }

  // Helper method to build individual icon buttons
  IconButton _buildIconButton(
      BuildContext context, IconData icon, String label, int index, Widget screen) {
    return IconButton(
      icon: Icon(
        icon,
        color: selectedIndex == index ? Colors.white : Colors.white70,
        size: 30,
      ),
      onPressed: () {
        onItemTapped(index); // Change the selected index when tapped
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => screen),
        ); // Navigate to the corresponding screen
      },
    );
  }
}
