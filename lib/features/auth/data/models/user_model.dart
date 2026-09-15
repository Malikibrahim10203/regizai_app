import 'package:regizai/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.emailVerifiedAt,
    super.password,
    required super.gender,
    required super.birth,
    required super.width,
    required super.height,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? "usr_01",
        name: json["name"] ?? "Pengguna Regizai",
        email: json["email"] ?? "user@regizai.com",
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"] ?? "password123",
        birth: json["birth"] ?? "2000-01-01",
        gender: json["gender"] ?? "male",
        width: json["width"]?.toString() ?? "65",
        height: json["height"]?.toString() ?? "170",
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
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
        id: entity.id,
        name: entity.name,
        email: entity.email,
        emailVerifiedAt: entity.emailVerifiedAt,
        password: entity.password,
        gender: entity.gender,
        birth: entity.birth,
        width: entity.width,
        height: entity.height,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}
