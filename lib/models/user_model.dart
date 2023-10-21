import 'charity_model.dart';

class User {
  final String uid;
  final String phoneNumber;
  final String name;
  final String surname;
  final String? userImage;
  final List<Charity>? favoriteList;
  final DateTime dateOfBirth;

  User({
    required this.uid,
    required this.phoneNumber,
    required this.name,
    required this.surname,
    required this.userImage,
    this.favoriteList,
    required this.dateOfBirth,
  });

  factory User.fromJson(Map<String, Object?> json) {
    return User(
      dateOfBirth: json["dateOfBirth"] as DateTime,
      uid: json["uid"] as String,
      phoneNumber: json["phoneNumber"] as String,
      name: json["name"] as String,
      surname: json["surname"] as String,
      userImage: json["userImage"] as String?,
      //  favoriteList:(json['favoriteList'] as List?).map((e) => null)
    );
  }

  Map<String, Object?> toJson() {
    return {
      "uid": uid,
      "phoneNumber": phoneNumber,
      "name": name,
      "surname": surname,
      "userImage": userImage,
      "dateOfBirth": dateOfBirth
    };
  }
}
