import 'message_model.dart';

class Charity {
  final String id;
  final String title;
  final String description;
  final String userId;
  final String category;
  final String location;
  final String? cardNumber;
  final String imageUrl;

  // final bool isMe;
  // List<Message> comments;
  final DateTime createdAt;

  Charity({
    //this.isMe = false,
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.category,
    required this.location,
    this.cardNumber,
    required this.imageUrl,
    required this.createdAt,
    //required this.comments
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Charity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId;

  @override
  int get hashCode => id.hashCode ^ userId.hashCode;

  factory Charity.fromJson(Map<dynamic, dynamic> json) {
    return Charity(
      id: json["id"] ?? '',
      title: json["title"] ?? '',
      description: json["content"] ?? '',
      userId: json["userId"] ?? '',
      category: json["category"] ?? '',
      location: json["location"] ?? '',
      cardNumber: json["cardNumber"] ?? '',
      createdAt: DateTime.parse(json["createdAt"] as String),
      imageUrl: json["imageUrl"] ?? '',
    //      json["imageUrl"] != null ? json["imageUrl"] as List<String> : [],
    );
  }

  Map<String, Object?> toJson() => {
        "id": id,
        "title": title,
        "content": description,
        "userId": userId,
        "location": location,
        "cardNumber": cardNumber,
        "category": category,
        "imageUrl": imageUrl,
        // "comments": comments.map((e) => e.toJson()).toList(),
        "createdAt": createdAt.toIso8601String()
      };
}
