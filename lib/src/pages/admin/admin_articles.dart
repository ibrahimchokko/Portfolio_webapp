import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../core/constants.dart';

class AdminArticlesPage extends StatefulWidget {
  const AdminArticlesPage({super.key});

  @override
  State<AdminArticlesPage> createState() => _AdminArticlesPageState();
}

class _AdminArticlesPageState extends State<AdminArticlesPage> {
  final FirestoreService _firestore = FirestoreService();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin - Articles')),
      body: StreamBuilder(
        stream: _firestore.getArticles(),
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
                subtitle: Text(data['content'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: const Icon(Icons.edit), onPressed: () => _showEditDialog(docId, data)),
                    IconButton(icon: const Icon(Icons.delete), onPressed: () => _firestore.deleteArticle(docId)),
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

  void _showAddDialog() {
    _titleController.clear();
    _contentController.clear();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Article'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: _contentController, decoration: const InputDecoration(labelText: 'Content'), maxLines: 5),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              await _firestore.addArticle({
                'title': _titleController.text,
                'content': _contentController.text,
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
    _contentController.text = data['content'] ?? '';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Article'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: _contentController, decoration: const InputDecoration(labelText: 'Content'), maxLines: 5),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              await _firestore.updateArticle(docId, {
                'title': _titleController.text,
                'content': _contentController.text,
              });
              Navigator.pop(context);
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }
}
