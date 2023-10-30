import 'message_model.dart';

class Charity {
  final String id;
  final String title;
  final String description;
  final String userId;
  final String category;
  final String location;
  final String? cardNumber;
  final List<String> imageUrl;
 // final bool isMe;
 // List<Message> comments;
  final DateTime createdAt;

  Charity(
      {
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

  factory Charity.fromJson(Map<dynamic, dynamic> json, {bool isMe = false}) {
    return Charity(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        userId: json["userId"],
        category: json["category"],
        location: json["location"],
        cardNumber: json["cardNumber"],
        createdAt: DateTime.parse(json["createdAt"] as String),
      //  isMe: isMe,
        // comments: json["comments"] != null
        //     ? (json["comments"] as List)
        //         .map((item) => Message.fromJson(item as Map<String, Object?>))
        //         .toList()
        //     : [],
        imageUrl:
            json["imageUrl"] != null ? json["imageUrl"] as List<String> : []);
  }

  Map<String, Object?> toJson() => {
        "id": id,
        "title": title,
        "content": description,
        "userId": userId,
    "location":location,
    "cardNumber":cardNumber,
    "category":category,
        "imageUrl": imageUrl,
       // "comments": comments.map((e) => e.toJson()).toList(),
        "createdAt": createdAt.toIso8601String()
      };
}
