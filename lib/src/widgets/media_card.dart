import 'package:flutter/material.dart';

class MediaCard extends StatelessWidget {
  final String title;
  final String thumbnailUrl;
  final String description;
  final VoidCallback onTap;

  const MediaCard({
    Key? key,
    required this.title,
    required this.thumbnailUrl,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(thumbnailUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(title, style: Theme.of(context).textTheme.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
