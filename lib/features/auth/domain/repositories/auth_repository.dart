import 'package:regizai/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> signup({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String birth,
    required String width,
    required String height,
  });
  Future<bool> forgotPassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  });
  Future<UserEntity?> getCurrentUser();
  Future<void> logout();
  Future<UserEntity> editProfile({
    required String id,
    required String name,
    required String oldPassword,
    required String newPassword,
    required String width,
    required String height,
  });
}
