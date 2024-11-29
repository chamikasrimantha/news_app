import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'controllers/bookmark_controller.dart'; // Import BookmarkController
import 'controllers/article_controller.dart'; // Import ArticleController
import 'views/screens/home_screen.dart'; // Import HomeScreen

void main() {
  runApp(
    // Provide both controllers at the root level
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArticleController()),
        ChangeNotifierProvider(create: (_) => BookmarkController()), // Add BookmarkController
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // HomeScreen can now access both controllers
    );
  }
}
