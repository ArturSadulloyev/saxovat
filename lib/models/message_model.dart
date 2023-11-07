class Message {
  final String id;
  final String message;
  final String writtenAt;
  final String senderId;
  final String recipientId;

  const Message({
    required this.id,
    required this.message,
    required this.writtenAt,
    required this.senderId,
    required this.recipientId,
  });

  factory Message.fromJson(Map<String, Object?> json, {bool isMe = true}) {
    return Message(
      id: json["id"] as String,
      message: json["message"] as String,
      writtenAt: json["writtenAt"] as String,
      senderId: json["senderId"] as String,
      recipientId: json["recipientId"] as String,
    );
  }

  Map<String, Object?> toJson() => {
        "id": id,
        "message": message,
        "writtenAt": writtenAt,
        "senderId": senderId,
        "recipientId": recipientId,
      };
}
