import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ===== Videos =====
  Stream<QuerySnapshot> getVideos() {
    return _db.collection(AppConstants.videosCollection).orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> addVideo(Map<String, dynamic> data) async {
    await _db.collection(AppConstants.videosCollection).add(data);
  }

  Future<void> updateVideo(String id, Map<String, dynamic> data) async {
    await _db.collection(AppConstants.videosCollection).doc(id).update(data);
  }

  Future<void> deleteVideo(String id) async {
    await _db.collection(AppConstants.videosCollection).doc(id).delete();
  }

  // ===== Articles =====
  Stream<QuerySnapshot> getArticles() {
    return _db.collection(AppConstants.articlesCollection).orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> addArticle(Map<String, dynamic> data) async {
    await _db.collection(AppConstants.articlesCollection).add(data);
  }

  Future<void> updateArticle(String id, Map<String, dynamic> data) async {
    await _db.collection(AppConstants.articlesCollection).doc(id).update(data);
  }

  Future<void> deleteArticle(String id) async {
    await _db.collection(AppConstants.articlesCollection).doc(id).delete();
  }

  // ===== Projects =====
  Stream<QuerySnapshot> getProjects() {
    return _db.collection(AppConstants.projectsCollection).orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> addProject(Map<String, dynamic> data) async {
    await _db.collection(AppConstants.projectsCollection).add(data);
  }

  Future<void> updateProject(String id, Map<String, dynamic> data) async {
    await _db.collection(AppConstants.projectsCollection).doc(id).update(data);
  }

  Future<void> deleteProject(String id) async {
    await _db.collection(AppConstants.projectsCollection).doc(id).delete();
  }

  // ===== Messages =====
  Future<void> addMessage(Map<String, dynamic> data) async {
    await _db.collection(AppConstants.messagesCollection).add(data);
  }
}
