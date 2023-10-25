import 'charity_model.dart';

class User {
  final String uid;
  final String phoneNumber;
  final String name;
  final String email;
  final String username;
  final String password;
  final String? userImage;
  final List<Charity> favoriteList;
  final DateTime dateOfBirth;

  User({
    required this.uid,
    required this.phoneNumber,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
    required this.userImage,
    required this.favoriteList,
    required this.dateOfBirth,
  });

  factory User.fromJson(Map<String, Object?> json) {
    return User(
      dateOfBirth: json["dateOfBirth"] as DateTime,
      uid: json["uid"] as String,
      phoneNumber: json["phoneNumber"] as String,
      name: json["name"] as String,
      email: json["email"] as String,
      password: json["password"] as String,
      username: json["username"] as String,
      userImage: json["userImage"] as String?,
      favoriteList: (json['favoriteList'] as List)
          .map((e) => Charity.fromJson(e as Map<String, Object?>))
          .toList(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      "uid": uid,
      "phoneNumber": phoneNumber,
      "name": name,
      "email": email,
      "password": password,
      "username": username,
      "userImage": userImage,
      "dateOfBirth": dateOfBirth
    };
  }
}
