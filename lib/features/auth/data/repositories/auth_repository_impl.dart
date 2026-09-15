import 'package:regizai/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:regizai/features/auth/domain/entities/user_entity.dart';
import 'package:regizai/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<UserEntity> login(String email, String password) =>
      localDataSource.login(email, password);

  @override
  Future<UserEntity> signup({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String birth,
    required String width,
    required String height,
  }) =>
      localDataSource.signup(
        name: name,
        email: email,
        password: password,
        gender: gender,
        birth: birth,
        width: width,
        height: height,
      );

  @override
  Future<bool> forgotPassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) =>
      localDataSource.forgotPassword(
        email: email,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

  @override
  Future<UserEntity?> getCurrentUser() => localDataSource.getCurrentUser();

  @override
  Future<void> logout() => localDataSource.logout();

  @override
  Future<UserEntity> editProfile({
    required String id,
    required String name,
    required String oldPassword,
    required String newPassword,
    required String width,
    required String height,
  }) =>
      localDataSource.editProfile(
        id: id,
        name: name,
        oldPassword: oldPassword,
        newPassword: newPassword,
        width: width,
        height: height,
      );
}
