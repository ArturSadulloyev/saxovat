import 'charity_model.dart';

class User {
  final String uid;
  final String phoneNumber;
  final String name;
  final String email;
  final String username;
  final String password;
  final String? userImage;
  final List<String> favoriteUserUid;
  final String dateOfBirth;

  User({
    required this.uid,
    required this.phoneNumber,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
    required this.userImage,
    required this.favoriteUserUid,
    required this.dateOfBirth,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      dateOfBirth: json["dateOfBirth"] ?? '',
      uid: json["uid"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
      username: json["username"] ?? '',
      userImage: json["userImage"] ?? '',
      favoriteUserUid: List<String>.from(json['favoriteList'] ?? []),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          email == other.email;

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;

  Map<String, Object?> toJson() {
    return {
      "uid": uid,
      "phoneNumber": phoneNumber,
      "name": name,
      "email": email,
      "password": password,
      "username": username,
      "userImage": userImage,
      "dateOfBirth": dateOfBirth,
      "favoriteList": favoriteUserUid,
    };
  }
}
