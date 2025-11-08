import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../core/utils.dart';

class AdminSettingsPage extends StatelessWidget {
  const AdminSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin - Settings')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Admin Settings",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text("Manage your admin account and preferences."),
            const SizedBox(height: 40),
            
            // Logout Button
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                onPressed: () async {
                  await AuthService().logoutAdmin();
                  AppUtils.showSnackBar(context, "Logged out successfully", color: Colors.green);
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
              ),
            ),

            const SizedBox(height: 20),

            // Optional placeholder for future settings
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              "App Configuration",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Coming soon: change app title, theme, or other settings."),
          ],
        ),
      ),
    );
  }
}
