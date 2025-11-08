import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';
import '../widgets/content_list.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyProjects = List.generate(6, (i) => {
          'title': 'Project ${i + 1}',
          'thumbnailUrl': 'https://picsum.photos/500/300?blur&random=$i',
          'description': 'A portfolio project, app, or creative build.',
        });

    return Scaffold(
      appBar: const AppNavbar(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "My Projects",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text("Explore my work in Flutter, design, and beyond."),
          const SizedBox(height: 20),
          Expanded(
            child: ContentList(contents: dummyProjects, type: 'project'),
          ),
        ],
      ),
    );
  }
}
