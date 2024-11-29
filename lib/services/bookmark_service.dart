import '../models/bookmark_model.dart';
import '../models/article_model.dart';

class BookmarkService {
  // In-memory list of bookmarks
  final List<BookmarkModel> _bookmarks = [];

  // Save a bookmark
  void saveBookmark(ArticleModel article) {
    if (!_bookmarks.any((bookmark) => bookmark.article.url == article.url)) {
      _bookmarks.add(BookmarkModel(article: article));
    }
  }

  // Get all bookmarks
  List<BookmarkModel> getAllBookmarks() {
    return _bookmarks;
  }

  // Delete a bookmark by URL
  void deleteBookmark(String url) {
    _bookmarks.removeWhere((bookmark) => bookmark.article.url == url);
  }
}
