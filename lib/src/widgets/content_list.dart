import 'package:flutter/material.dart';
import 'media_card.dart';

class ContentList extends StatelessWidget {
  final List<Map<String, String>> contents;
  final String type;

  const ContentList({
    Key? key,
    required this.contents,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: contents.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final item = contents[index];
        return MediaCard(
          title: item['title'] ?? '',
          thumbnailUrl: item['thumbnailUrl'] ?? '',
          description: item['description'] ?? '',
          onTap: () {
            // later we’ll navigate to video or article view
          },
        );
      },
    );
  }
}
