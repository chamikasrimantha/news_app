import 'package:flutter/material.dart';
import '../models/bookmark_model.dart';
import '../models/article_model.dart';
import '../services/bookmark_service.dart';

class BookmarkController extends ChangeNotifier {
  final BookmarkService _bookmarkService = BookmarkService();
  List<BookmarkModel> _bookmarks = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getter for bookmarks
  List<BookmarkModel> get bookmarks => _bookmarks;

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Getter for error message
  String? get errorMessage => _errorMessage;

  // Save a bookmark and refresh the list
  Future<void> saveBookmark(ArticleModel article) async {
    try {
      _setLoading(true);
      await _bookmarkService.saveBookmark(article); // Ensure async operation is awaited
      await fetchAllBookmarks(); // Refresh bookmarks list
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Fetch all bookmarks
  Future<void> fetchAllBookmarks() async {
    try {
      _setLoading(true);
      _bookmarks = await _bookmarkService.getAllBookmarks(); // Fetch data from the database
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Delete a bookmark and refresh the list
  Future<void> deleteBookmark(String url) async {
    try {
      _setLoading(true);
      await _bookmarkService.deleteBookmark(url); // Ensure async operation is awaited
      await fetchAllBookmarks(); // Refresh bookmarks list
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Helper method to set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
