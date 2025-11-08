import 'package:flutter/material.dart';
import 'admin_videos.dart';
import 'admin_articles.dart';
import 'admin_projects.dart';
import 'admin_settings.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    AdminVideosPage(),
    AdminArticlesPage(),
    AdminProjectsPage(),
    AdminSettingsPage(),
  ];

  final List<String> _titles = const [
    'Videos',
    'Articles',
    'Projects',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin - ${_titles[_selectedIndex]}'),
      ),
      body: Row(
        children: [
          // Sidebar Menu
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.video_library),
                label: Text('Videos'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.article),
                label: Text('Articles'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.code),
                label: Text('Projects'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),

          const VerticalDivider(thickness: 1, width: 1),

          // Selected page
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
