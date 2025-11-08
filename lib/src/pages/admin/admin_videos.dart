import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../services/storage_service.dart';
import '../../core/constants.dart';
import 'package:image_picker/image_picker.dart';

class AdminVideosPage extends StatefulWidget {
  const AdminVideosPage({super.key});

  @override
  State<AdminVideosPage> createState() => _AdminVideosPageState();
}

class _AdminVideosPageState extends State<AdminVideosPage> {
  final FirestoreService _firestore = FirestoreService();
  final StorageService _storage = StorageService();

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  File? _videoFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin - Videos')),
      body: StreamBuilder(
        stream: _firestore.getVideos(),
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
                subtitle: Text(data['description'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showEditDialog(docId, data),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _firestore.deleteVideo(docId),
                    ),
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

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final picked = await picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) _videoFile = File(picked.path);
  }

  void _showAddDialog() {
    _titleController.clear();
    _descController.clear();
    _videoFile = null;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Video'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: _descController, decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickVideo,
              child: const Text('Pick Video File'),
            )
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (_titleController.text.isEmpty || _videoFile == null) return;
              final url = await _storage.uploadFile(
                  '${AppConstants.videosCollection}/${_titleController.text}.mp4', _videoFile!);
              await _firestore.addVideo({
                'title': _titleController.text,
                'description': _descController.text,
                'videoUrl': url,
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
    _descController.text = data['description'] ?? '';
    _videoFile = null;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Video'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: _descController, decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickVideo,
              child: const Text('Pick New Video (Optional)'),
            )
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Map<String, dynamic> updated = {
                'title': _titleController.text,
                'description': _descController.text,
              };
              if (_videoFile != null) {
                final url = await _storage.uploadFile(
                    '${AppConstants.videosCollection}/${_titleController.text}.mp4', _videoFile!);
                updated['videoUrl'] = url;
              }
              await _firestore.updateVideo(docId, updated);
              Navigator.pop(context);
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }
}
