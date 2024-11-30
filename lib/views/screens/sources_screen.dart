import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/article_controller.dart';
import '../../models/source_model.dart';
import '../../models/article_model.dart';
import '../widgets/bottom_app_bar.dart';  // Import CustomBottomAppBar
import '../widgets/article_card.dart';  // Import the ArticleCard widget

class SourcesScreen extends StatefulWidget {
  @override
  _SourcesScreenState createState() => _SourcesScreenState();
}

class _SourcesScreenState extends State<SourcesScreen> {
  int _selectedIndex = 5;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final controller = Provider.of<ArticleController>(context, listen: false);
      if (controller.sources.isEmpty) {
        controller.fetchAndSetSources();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sources',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Consumer<ArticleController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(child: Text('Error: ${controller.errorMessage!}'));
          }

          final sources = controller.sources;
          return ListView.builder(
            itemCount: sources.length,
            itemBuilder: (context, index) {
              final source = sources[index];
              return SourceCard(source: source);
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class SourceCard extends StatelessWidget {
  final SourceModel source;

  const SourceCard({Key? key, required this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticlesScreen(source: source),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.source,
                    color: Colors.black87,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      source.name.isNotEmpty ? source.name : 'No Name',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Chip(
                    label: Text(
                      source.category.isNotEmpty
                          ? source.category.toUpperCase()
                          : 'N/A',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.black54,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                source.description.isNotEmpty
                    ? source.description
                    : 'No Description Available',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticlesScreen extends StatelessWidget {
  final SourceModel source;

  const ArticlesScreen({Key? key, required this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          source.name.isNotEmpty ? source.name : 'Articles',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black54,
      ),
      body: FutureBuilder<List<ArticleModel>>(
        future: Provider.of<ArticleController>(context, listen: false)
            .fetchArticlesBySource(source.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Check if the data is null or empty
          final articles = snapshot.data ?? [];

          if (articles.isEmpty) {
            return const Center(child: Text('No articles found.'));
          }

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ArticleCard(article: article); // Use ArticleCard widget to display article
            },
          );
        },
      ),
    );
  }
}
