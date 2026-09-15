import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/auth/domain/entities/user_entity.dart';
import 'package:regizai/features/auth/domain/repositories/auth_repository.dart';

class SignUpParams {
  final String name;
  final String email;
  final String password;
  final String gender;
  final String birth;
  final String width;
  final String height;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.birth,
    required this.width,
    required this.height,
  });
}

class SignUpUseCase implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;
  SignUpUseCase(this.repository);

  @override
  Future<UserEntity> call(SignUpParams params) {
    return repository.signup(
      name: params.name,
      email: params.email,
      password: params.password,
      gender: params.gender,
      birth: params.birth,
      width: params.width,
      height: params.height,
    );
  }
}
