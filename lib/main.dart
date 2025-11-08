import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/pages/home_page.dart';
import 'src/pages/videos_page.dart';
import 'src/pages/articles_page.dart';
import 'src/pages/projects_page.dart';
import 'src/pages/contact_page.dart';
import 'src/pages/video_player_page.dart';
import 'src/pages/admin/admin_dashboard.dart';
import 'src/pages/admin/admin_videos.dart';
import 'src/pages/admin/admin_articles.dart';
import 'src/pages/admin/admin_projects.dart';
import 'src/pages/admin/admin_settings.dart';
import 'src/pages/admin/admin_login.dart';
import 'src/services/auth_service.dart';
import 'src/core/theme.dart';
import 'src/core/firebase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform, // your Firebase config
  );
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/videos': (_) => const VideosPage(),
        '/articles': (_) => const ArticlesPage(),
        '/projects': (_) => const ProjectsPage(),
        '/contact': (_) => const ContactPage(),
        // Admin pages (CRUD)
        '/admin': (_) => const AdminAuthWrapper(),
        '/admin/videos': (_) => const AdminVideosPage(),
        '/admin/articles': (_) => const AdminArticlesPage(),
        '/admin/projects': (_) => const AdminProjectsPage(),
        '/admin/settings': (context) => const AdminSettingsPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/video_player') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => VideoPlayerPage(
              videoUrl: args['videoUrl'],
              title: args['title'],
              description: args['description'],
            ),
          );
        }
        return null;
      },
    );
  }
}

/// Protect admin routes with Firebase Auth
class AdminAuthWrapper extends StatelessWidget {
  const AdminAuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService().isAdminLoggedIn(), // check if admin is logged in
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        if (snapshot.data!) {
          return const AdminDashboard(); // logged in → show dashboard
        } else {
          return const AdminLoginPage(); // not logged in → show login
        }
      },
    );
  }
}
