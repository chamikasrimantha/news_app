import 'package:sqflite/sqflite.dart';
import '../models/bookmark_model.dart';
import '../models/article_model.dart';
import 'category_service.dart'; // Assuming the database is initialized in CategoryService

class BookmarkService {
  // Save a bookmark to the database
  Future<void> saveBookmark(ArticleModel article) async {
    final db = await CategoryService().database; // Get the shared database instance
    try {
      await db.insert(
        'bookmarks',
        BookmarkModel(article: article).toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore, // Prevent duplicate entries
      );
      print("Bookmark saved: ${article.title}");
    } catch (e) {
      print("Error saving bookmark: $e");
    }
  }

  // Get all bookmarks from the database
  Future<List<BookmarkModel>> getAllBookmarks() async {
    final db = await CategoryService().database; // Get the shared database instance
    try {
      final List<Map<String, dynamic>> bookmarkMaps = await db.query('bookmarks');

      // Map each database row to a BookmarkModel instance
      return List.generate(bookmarkMaps.length, (i) {
        return BookmarkModel.fromJson(bookmarkMaps[i]);
      });
    } catch (e) {
      print("Error retrieving bookmarks: $e");
      return [];
    }
  }

  // Delete a bookmark by URL
  Future<void> deleteBookmark(String url) async {
    final db = await CategoryService().database; // Get the shared database instance
    try {
      await db.delete(
        'bookmarks',
        where: 'url = ?',
        whereArgs: [url],
      );
      print("Bookmark deleted: $url");
    } catch (e) {
      print("Error deleting bookmark: $e");
    }
  }
}
