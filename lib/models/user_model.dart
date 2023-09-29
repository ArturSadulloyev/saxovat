class User {
  String uid;
  String phoneNumber;
  String name;
  String surname;
  String? userImage;

  User(
      {required this.uid,
      required this.phoneNumber,
      required this.name,
      required this.surname,
      required this.userImage});

  factory User.fromJson(Map<String, Object?> json) {
    return User(
        uid: json["uid"] as String,
        phoneNumber: json["phoneNumber"] as String,
        name: json["name"] as String,
        surname: json["surname"] as String,
        userImage: json["userImage"] as String?);
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
