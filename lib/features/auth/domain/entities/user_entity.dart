import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? password;
  final String gender;
  final String birth;
  final String width;
  final String height;
  final String? createdAt;
  final String? updatedAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.password,
    required this.gender,
    required this.birth,
    required this.width,
    required this.height,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        emailVerifiedAt,
        password,
        gender,
        birth,
        width,
        height,
        createdAt,
        updatedAt,
      ];
}
