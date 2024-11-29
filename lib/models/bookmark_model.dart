import 'article_model.dart';

class BookmarkModel {
  final ArticleModel article;

  BookmarkModel({required this.article});

  // Convert BookmarkModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'url': article.url,
      'title': article.title,
      'author': article.author,
      'description': article.description,
      'imageUrl': article.imageUrl,
      'publishedAt': article.pulishedAt,
      'content': article.content,
    };
  }

  // Factory method to create a BookmarkModel from JSON
  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      article: ArticleModel.fromBookmark(json),
    );
  }
}
