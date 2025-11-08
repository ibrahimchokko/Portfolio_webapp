import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/media_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavbar(),
      body: ResponsiveLayout(
        mobileBody: _buildContent(context, isMobile: true),
        desktopBody: _buildContent(context, isMobile: false),
      ),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isMobile}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          const Text("Welcome to My Portfolio",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("A hub for my videos, writings, designs, and projects."),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              3,
              (index) => SizedBox(
                width: isMobile ? 300 : 350,
                child: MediaCard(
                  title: "Featured Project ${index + 1}",
                  thumbnailUrl: "https://picsum.photos/400/200?random=$index",
                  description: "This is one of my highlighted works.",
                  onTap: () {},
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
