import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;
  LogoutUseCase(this.repository);

  @override
  Future<void> call(NoParams params) {
    return repository.logout();
  }
}
