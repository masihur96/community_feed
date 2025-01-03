class PostModel {
  final String id;
  final String username;
  final String content;
  final String imageUrl;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.username,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      username: json['username'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
