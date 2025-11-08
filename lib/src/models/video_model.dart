class VideoModel {
  final String id;
  final String title;
  final String description;
  final String storagePath;
  final String thumbnailUrl;
  final DateTime publishedAt;
  final List<String> tags;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.storagePath,
    required this.thumbnailUrl,
    required this.publishedAt,
    required this.tags,
  });

  factory VideoModel.fromMap(String id, Map<String, dynamic> data) {
    return VideoModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      storagePath: data['storagePath'] ?? '',
      thumbnailUrl: data['thumbnailUrl'] ?? '',
      publishedAt: (data['publishedAt'] as Timestamp).toDate(),
      tags: List<String>.from(data['tags'] ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'storagePath': storagePath,
    'thumbnailUrl': thumbnailUrl,
    'publishedAt': publishedAt,
    'tags': tags,
  };
}
