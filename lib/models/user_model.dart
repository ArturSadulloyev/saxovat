import 'charity_model.dart';

class User {
  String uid;
  String phoneNumber;
  String name;
  String surname;
  String? userImage;
  List<Charity>? favoriteList;

  User(
      {required this.uid,
      required this.phoneNumber,
      required this.name,
      required this.surname,
      required this.userImage,
      this.favoriteList,
      });

  factory User.fromJson(Map<String, Object?> json) {
    return User(
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
      "userImage": userImage
    };
  }
}
