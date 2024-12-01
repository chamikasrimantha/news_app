import 'package:flutter/material.dart';
import 'package:news_app/views/screens/article_details_screen.dart';
import 'package:provider/provider.dart';
import '../../models/article_model.dart';
import '../../controllers/bookmark_controller.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;

  const ArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // More rounded corners
      ),
      elevation: 8, // Adding more shadow for a floating effect
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailsScreen(article: article),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image on the left side
              ClipRRect(
                borderRadius: BorderRadius.circular(12), // Smoother corners for images
                child: Image.network(
                  article.imageUrl,
                  width: 120, // Slightly larger image for emphasis
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              // Article details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      article.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87, // Ensure title is bold and prominent
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Description (subtitle)
                    Text(
                      article.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700], // Subtle color for description
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    // Published date
                    Text(
                      'Published on: ${article.pulishedAt}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic, // Italic for a more elegant look
                      ),
                    ),
                  ],
                ),
              ),
              // Bookmark Icon
              Consumer<BookmarkController>(
                builder: (context, bookmarkController, child) {
                  if (bookmarkController.isLoading) {
                    return CircularProgressIndicator(); // Loading indicator
                  }

                  final isBookmarked = bookmarkController.bookmarks.any(
                        (bookmark) => bookmark.article.url == article.url,
                  );

                  return IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? Colors.blueAccent : Colors.grey[500],
                    ),
                    onPressed: () {
                      if (isBookmarked) {
                        bookmarkController.deleteBookmark(article.url);
                      } else {
                        bookmarkController.saveBookmark(article);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}