import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordParams {
  final String email;
  final String oldPassword;
  final String newPassword;

  ForgotPasswordParams({
    required this.email,
    required this.oldPassword,
    required this.newPassword,
  });
}

class ForgotPasswordUseCase implements UseCase<bool, ForgotPasswordParams> {
  final AuthRepository repository;
  ForgotPasswordUseCase(this.repository);

  @override
  Future<bool> call(ForgotPasswordParams params) {
    return repository.forgotPassword(
      email: params.email,
      oldPassword: params.oldPassword,
      newPassword: params.newPassword,
    );
  }
}
