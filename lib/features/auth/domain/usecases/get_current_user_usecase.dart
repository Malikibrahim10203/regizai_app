import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/auth/domain/entities/user_entity.dart';
import 'package:regizai/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;
  GetCurrentUserUseCase(this.repository);

  @override
  Future<UserEntity?> call(NoParams params) {
    return repository.getCurrentUser();
  }
}
