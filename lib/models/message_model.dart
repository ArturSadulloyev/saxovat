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

  factory Message.fromJson(Map<dynamic, dynamic> json, {bool isMe = true}) {
    return Message(
      id: json["id"] as String,
      message: json["message"] as String,
      writtenAt: json["writtenAt"] as String,
      senderId: json["senderId"] as String,
      recipientId: json["recipientId"] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          writtenAt == other.writtenAt;

  @override
  int get hashCode => writtenAt.hashCode;

  Map<String, Object?> toJson() => {
        "id": id,
        "message": message,
        "writtenAt": writtenAt,
        "senderId": senderId,
        "recipientId": recipientId,
      };
}

class SendMessage {
  final String id;
  final List<Message> message;

  const SendMessage({
    required this.id,
    required this.message,
  });

  factory SendMessage.fromJson(Map<dynamic, dynamic> json) {
    return SendMessage(
      id: json["id"] as String,
      message:
          (json['message'] as List).map((e) => Message.fromJson(e)).toList() ?? [],
    );
  }

  Map<String, Object?> toJson() => {
        "id": id,
        "message": message.map((e) => e.toJson()).toList(),
      };
}
