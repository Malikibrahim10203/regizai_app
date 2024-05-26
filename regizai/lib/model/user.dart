import 'dart:ui';

class User {
  String? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? password;
  String? birth;
  String? gender;
  String? width;
  String? height;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.password,
    required this.birth,
    required this.gender,
    required this.width,
    required this.height,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    password: json["password"],
    birth: json["birth"],
    gender: json["gender"],
    width: json["width"],
    height: json["height"],
    rememberToken: json["remember_token"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "password": password,
    "birth": birth,
    "gender": gender,
    "width": width,
    "height": height,
    "remember_token": rememberToken,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
