import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/auth/domain/entities/user_entity.dart';
import 'package:regizai/features/auth/domain/repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<UserEntity> call(LoginParams params) {
    return repository.login(params.email, params.password);
  }
}
