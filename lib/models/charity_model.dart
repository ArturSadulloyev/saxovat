import 'message_model.dart';

class Charity {
  final String id;
  final String title;
  final String description;
  final String userId;
  final String category;
  final String location;
  final List<String> imageUrl;
  final bool isMe;
  List<Message> comments;
  final DateTime createdAt;

  Charity(
      {this.isMe = false,
      required this.id,
      required this.title,
      required this.description,
      required this.userId,
        required this.category,
        required this.location,
      required this.imageUrl,
      required this.createdAt,
      required this.comments});

  factory Charity.fromJson(Map<String, Object?> json, {bool isMe = false}) {
    return Charity(
        id: json["id"] as String,
        title: json["title"] as String,
        description: json["description"] as String,
        userId: json["userId"] as String,
        category: json["category"] as String,
        location: json["location"] as String,
        createdAt: DateTime.parse(json["createdAt"] as String),
        isMe: isMe,
        comments: json["comments"] != null
            ? (json["comments"] as List)
                .map((item) => Message.fromJson(item as Map<String, Object?>))
                .toList()
            : [],
        imageUrl:
            json["imageUrl"] != null ? json["imageUrl"] as List<String> : []);
  }

  Map<String, Object?> toJson() => {
        "id": id,
        "title": title,
        "content": description,
        "userId": userId,
    "location":location,
    "category":category,
        "imageUrl": imageUrl,
        "comments": comments.map((e) => e.toJson()).toList(),
        "createdAt": createdAt.toIso8601String()
      };
}
