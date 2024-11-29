import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/source_model.dart';
import '../models/article_model.dart';

class ApiService {
  final String _baseUrl = "https://newsapi.org/v2";
  final String _apiKey = "fd3bd6e596db40da95d16c3c9b32cc6e"; // Replace with your API key

  // Helper function to construct URL
  Uri _buildUrl(String endpoint, Map<String, String> queryParameters) {
    queryParameters['apiKey'] = _apiKey; // Always include the API key
    return Uri.parse('$_baseUrl$endpoint').replace(queryParameters: queryParameters);
  }

  // Fetch top headlines
  Future<List<ArticleModel>> fetchTopHeadlines({String? category, String? country = 'us'}) async {
    final queryParameters = <String, String>{
      'category': category ?? '',
      'country': country ?? 'us',
    }..removeWhere((key, value) => value.isEmpty);

    final url = _buildUrl('/top-headlines', queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ArticleModel> articles = (data['articles'] as List)
          .map((articleJson) => ArticleModel.fromJson(articleJson))
          .toList();
      return articles;
    } else {
      throw Exception("Failed to load top headlines: ${response.body}");
    }
  }

  // Fetch all articles (everything without filters)
  Future<List<ArticleModel>> fetchEverything() async {
    final queryParameters = <String, String>{
      'q': 'dogs', // Add your query parameters here
    };

    final url = _buildUrl('/everything', queryParameters);

    print('Requesting URL: ${url.toString()}'); // Debugging: Check the final URL

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ArticleModel> articles = (data['articles'] as List)
          .map((articleJson) => ArticleModel.fromJson(articleJson))
          .toList();
      return articles;
    } else {
      throw Exception("Failed to load everything: ${response.body}");
    }
  }

  // Search articles by query
  Future<List<ArticleModel>> searchArticles(String query) async {
    final queryParameters = <String, String>{
      'q': query,
    };

    final url = _buildUrl('/everything', queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ArticleModel> articles = (data['articles'] as List)
          .map((articleJson) => ArticleModel.fromJson(articleJson))
          .toList();
      return articles;
    } else {
      throw Exception("Failed to search articles: ${response.body}");
    }
  }

  // Fetch sources from the API
  Future<List<SourceModel>> fetchSources({String? category}) async {
    // Build the query parameters
    final queryParameters = {
      'apiKey': _apiKey,
      if (category != null) 'category': category, // Optional category filter
    };

    // Construct the URL
    final url = Uri.parse("$_baseUrl/top-headlines/sources").replace(queryParameters: queryParameters);

    print("Requesting URL: $url"); // Debugging: Check the final URL

    // Make the GET request
    final response = await http.get(url);

    // Handle the response
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Response Data: $data"); // Debugging: Check the response

      // Parse the sources into a list of SourceModel
      final List<SourceModel> sources = (data['sources'] as List)
          .map((sourceJson) => SourceModel.fromJson(sourceJson))
          .toList();

      return sources;
    } else {
      print("Error: ${response.body}"); // Debugging: Check the error response
      throw Exception("Failed to load sources");
    }
  }

  // Fetch articles by category
  Future<List<ArticleModel>> fetchArticlesByCategory(String category) async {
    return fetchTopHeadlines(category: category);
  }

  // Fetch articles by source
  Future<List<ArticleModel>> fetchArticlesBySource(String sourceId) async {
    final queryParameters = <String, String>{
      'sources': sourceId,
    };

    final url = _buildUrl('/top-headlines', queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ArticleModel> articles = (data['articles'] as List)
          .map((articleJson) => ArticleModel.fromJson(articleJson))
          .toList();
      return articles;
    } else {
      throw Exception("Failed to load articles from source: ${response.body}");
    }
  }

  // Fetch articles sorted by date
  Future<List<ArticleModel>> fetchArticlesSortedByDate({String? category, String? country = 'us'}) async {
    final queryParameters = <String, String>{
      'category': category ?? '',
      'country': country ?? 'us',
      'sortBy': 'publishedAt', // Sorting articles by publication date
    }..removeWhere((key, value) => value.isEmpty);

    final url = _buildUrl('/everything', queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ArticleModel> articles = (data['articles'] as List)
          .map((articleJson) => ArticleModel.fromJson(articleJson))
          .toList();
      return articles;
    } else {
      throw Exception("Failed to load sorted articles: ${response.body}");
    }
  }
}
