import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/article_model.dart';
import '../../controllers/bookmark_controller.dart';
import '../../utils/constants.dart'; // Make sure this path is correct for your constants file.

class ArticleDetailsScreen extends StatelessWidget {
  final ArticleModel article;

  ArticleDetailsScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        centerTitle: true,
        actions: [
          // Bookmark Icon in AppBar
          Consumer<BookmarkController>(
            builder: (context, bookmarkController, child) {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.mediumSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: AppSpacing.mediumSpacing),

            // Title Section
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: AppTextStyles.headingFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.smallSpacing),

            // Author & Published Date
            Row(
              children: [
                Icon(Icons.person, size: 16, color: AppColors.primaryColor),
                const SizedBox(width: AppSpacing.smallSpacing),
                Text(
                  article.author.isNotEmpty ? article.author : 'Unknown Author',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: AppTextStyles.bodyFontSize,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: AppSpacing.mediumSpacing),
                Icon(Icons.access_time, size: 16, color: AppColors.primaryColor),
                const SizedBox(width: AppSpacing.smallSpacing),
                Text(
                  article.pulishedAt,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: AppTextStyles.bodyFontSize,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.mediumSpacing),

            // Description Section
            Text(
              article.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: AppTextStyles.bodyFontSize,
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: AppSpacing.mediumSpacing),

            // Content Section
            Text(
              article.content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: AppTextStyles.bodyFontSize,
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: AppSpacing.largeSpacing),
          ],
        ),
      ),
    );
  }
}
