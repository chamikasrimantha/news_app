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

  // Save bookmark
  Future<void> saveBookmark(ArticleModel article) async {
    try {
      _setLoading(true);
      _bookmarkService.saveBookmark(article);
      _bookmarks = _bookmarkService.getAllBookmarks(); // Update the list of bookmarks
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Get all bookmarks
  Future<void> getAllBookmarks() async {
    try {
      _setLoading(true);
      _bookmarks = _bookmarkService.getAllBookmarks();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Delete a bookmark
  Future<void> deleteBookmark(String url) async {
    try {
      _setLoading(true);
      _bookmarkService.deleteBookmark(url);
      _bookmarks = _bookmarkService.getAllBookmarks(); // Update the list of bookmarks after deletion
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Helper method to set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
