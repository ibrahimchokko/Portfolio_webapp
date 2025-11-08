import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_service.dart';

class ContactService {
  final FirestoreService _firestore = FirestoreService();

  Future<void> sendMessage(String name, String email, String message) async {
    Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await _firestore.addMessage(data);

    // Optional: Trigger Cloud Function for email notification here
  }
}
