class ArticleModel {
  final String author;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String pulishedAt;
  final String content;

  ArticleModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.pulishedAt,
    required this.content,
  });

  // Factory constructor for creating an instance from JSON
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? 'https://media.wired.com/photos/672bda0a90a94384370310f4/191:100/w_1280,c_limit/business_crypto_faithful_trump.jpg',
      pulishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }

  // Factory constructor for creating an instance from a bookmark
  factory ArticleModel.fromBookmark(Map<String, dynamic> bookmark) {
    return ArticleModel(
      author: bookmark['author'] ?? '',
      title: bookmark['title'] ?? '',
      description: bookmark['description'] ?? '',
      url: bookmark['url'] ?? '',
      imageUrl: bookmark['imageUrl'] ?? '',
      pulishedAt: bookmark['publishedAt'] ?? '',
      content: bookmark['content'] ?? '',
    );
  }
}
