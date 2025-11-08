import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../services/storage_service.dart';
import '../../core/constants.dart';
import 'package:image_picker/image_picker.dart';

class AdminProjectsPage extends StatefulWidget {
  const AdminProjectsPage({super.key});

  @override
  State<AdminProjectsPage> createState() => _AdminProjectsPageState();
}

class _AdminProjectsPageState extends State<AdminProjectsPage> {
  final FirestoreService _firestore = FirestoreService();
  final StorageService _storage = StorageService();

  final _titleController = TextEditingController();
  final _linkController = TextEditingController();
  File? _thumbnailFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin - Projects')),
      body: StreamBuilder(
        stream: _firestore.getProjects(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final docId = docs[index].id;

              return ListTile(
                title: Text(data['title']),
                subtitle: Text(data['link'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: const Icon(Icons.edit), onPressed: () => _showEditDialog(docId, data)),
                    IconButton(icon: const Icon(Icons.delete), onPressed: () => _firestore.deleteProject(docId)),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _pickThumbnail() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) _thumbnailFile = File(picked.path);
  }

  void _showAddDialog() {
    _titleController.clear();
    _linkController.clear();
    _thumbnailFile = null;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Project'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: _linkController, decoration: const InputDecoration(labelText: 'Link/URL')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _pickThumbnail, child: const Text('Pick Thumbnail')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              String? thumbUrl;
              if (_thumbnailFile != null) {
                thumbUrl = await _storage.uploadFile(
                    '${AppConstants.projectsCollection}/${_titleController.text}.png', _thumbnailFile!);
              }
              await _firestore.addProject({
                'title': _titleController.text,
                'link': _linkController.text,
                'thumbnailUrl': thumbUrl,
                'createdAt': DateTime.now(),
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }

  void _showEditDialog(String docId, Map<String, dynamic> data) {
    _titleController.text = data['title'];
    _linkController.text = data['link'] ?? '';
    _thumbnailFile = null;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Project'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: _linkController, decoration: const InputDecoration(labelText: 'Link/URL')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _pickThumbnail, child: const Text('Pick New Thumbnail (Optional)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Map<String, dynamic> updated = {
                'title': _titleController.text,
                'link': _linkController.text,
              };
              if (_thumbnailFile != null) {
                final url = await _storage.uploadFile(
                    '${AppConstants.projectsCollection}/${_titleController.text}.png', _thumbnailFile!);
                updated['thumbnailUrl'] = url;
              }
              await _firestore.updateProject(docId, updated);
              Navigator.pop(context);
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }
}
