import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';
import '../widgets/content_list.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyArticles = List.generate(6, (i) => {
          'title': 'Article ${i + 1}',
          'thumbnailUrl': 'https://picsum.photos/500/300?grayscale&random=$i',
          'description': 'My thoughts, essays, or creative writing piece.',
        });

    return Scaffold(
      appBar: const AppNavbar(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "My Articles & Writings",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text("Dive into my thoughts, poetry, and creative works."),
          const SizedBox(height: 20),
          Expanded(
            child: ContentList(contents: dummyArticles, type: 'article'),
          ),
        ],
      ),
    );
  }
}
