class Charity {
  final String id;
  final String title;
  final String description;
  final String userId;
  final String charityId;
  final String category;
  final String location;
  final String? cardNumber;
  final String imageUrl;
  final String createdAt;

  Charity({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.charityId,
    required this.category,
    required this.location,
    this.cardNumber,
    required this.imageUrl,
    required this.createdAt,
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
      charityId: json["charityId"] ?? '',
      category: json["category"] ?? '',
      location: json["location"] ?? '',
      cardNumber: json["cardNumber"] ?? '',
      createdAt: (json["createdAt"]) ?? DateTime.now().toString(),
      imageUrl: json["imageUrl"] ?? '',
      //      json["imageUrl"] != null ? json["imageUrl"] as List<String> : [],
    );
  }

  Map<String, Object?> toJson() => {
        "id": id,
        "title": title,
        "content": description,
        "userId": userId,
        "charityId": charityId,
        "location": location,
        "cardNumber": cardNumber,
        "category": category,
        "imageUrl": imageUrl,
        "createdAt": createdAt,
      };
}


class MainCharity {
  final String id;
  final String charityId;
  bool approve;

  MainCharity({
    required this.id,
    required this.charityId,
    this.approve = false,
  });


  factory MainCharity.fromJson(Map<dynamic, dynamic> json) {
    return MainCharity(
      id: json["id"] ?? '',
      charityId: json["charityId"] ?? '',
      approve: json["approve"] ?? '',
    );
  }

  Map<String, Object?> toJson() => {
    "id": id,
    "charityId": charityId,
    "approve": approve,
  };
}