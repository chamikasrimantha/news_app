import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/api_service.dart';

class ArticleController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<ArticleModel> _articles = [];
  List<dynamic> _sources = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ArticleModel> get articles => _articles;
  List<dynamic> get sources => _sources;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch top headlines
  Future<void> fetchTopHeadlines({String? category, String? country = 'us'}) async {
    try {
      _setLoading(true);
      _articles = await _apiService.fetchTopHeadlines(country: country);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Fetch everything (all articles)
  Future<void> fetchEverything() async {
    try {
      _setLoading(true);
      _articles = await _apiService.fetchEverything();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Search articles
  Future<void> searchArticles(String query) async {
    try {
      _setLoading(true);
      _articles = await _apiService.searchArticles(query);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Fetch and set sources
  Future<void> fetchAndSetSources({String? category}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedSources = await _apiService.fetchSources(category: category);
      _sources = fetchedSources;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch articles by category
  Future<void> fetchArticlesByCategory(String category) async {
    try {
      _setLoading(true);
      _articles = await _apiService.fetchArticlesByCategory(category);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Fetch articles by source
  Future<void> fetchArticlesBySource(String sourceId) async {
    try {
      _setLoading(true);
      _articles = await _apiService.fetchArticlesBySource(sourceId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Sort articles by date (publishedAt)
  void sortArticlesByDate({bool ascending = true, DateTime? selectedDate}) {
    if (selectedDate != null) {
      // Filter articles by selected date
      _articles = _articles.where((article) {
        DateTime articleDate = DateTime.parse(article.pulishedAt);
        return articleDate.year == selectedDate.year &&
            articleDate.month == selectedDate.month &&
            articleDate.day == selectedDate.day;
      }).toList();
    } else {
      // Sort articles by ascending or descending order based on the selected option
      _articles.sort((a, b) {
        DateTime dateA = DateTime.parse(a.pulishedAt);
        DateTime dateB = DateTime.parse(b.pulishedAt);
        return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
      });
    }
    notifyListeners();
  }

  // Helper method to set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
