import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';
import '../widgets/media_card.dart';
import '../widgets/content_list.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy videos (you’ll replace this with Firestore data later)
    final dummyVideos = List.generate(6, (i) => {
          'title': 'Video ${i + 1}',
          'thumbnailUrl': 'https://picsum.photos/500/300?random=$i',
          'videoUrl': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4',
          'description': 'A cool highlight or video showcase.',
        });

    return Scaffold(
      appBar: const AppNavbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            "My Videos",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text("Watch my content, edits, and creative visuals."),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: dummyVideos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Adjust for responsiveness later
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 16 / 9,
              ),
              itemBuilder: (context, index) {
                final video = dummyVideos[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/video_player',
                      arguments: {
                        'videoUrl': video['videoUrl'],
                        'title': video['title'],
                        'description': video['description'],
                      },
                    );
                  },
                  child: MediaCard(
                    title: video['title']!,
                    thumbnailUrl: video['thumbnailUrl']!,
                    description: video['description']!, onTap: () {  },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
