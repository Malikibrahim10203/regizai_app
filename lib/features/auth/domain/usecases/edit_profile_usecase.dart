import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/auth/domain/entities/user_entity.dart';
import 'package:regizai/features/auth/domain/repositories/auth_repository.dart';

class EditProfileParams {
  final String id;
  final String name;
  final String oldPassword;
  final String newPassword;
  final String width;
  final String height;

  EditProfileParams({
    required this.id,
    required this.name,
    required this.oldPassword,
    required this.newPassword,
    required this.width,
    required this.height,
  });
}

class EditProfileUseCase implements UseCase<UserEntity, EditProfileParams> {
  final AuthRepository repository;
  EditProfileUseCase(this.repository);

  @override
  Future<UserEntity> call(EditProfileParams params) {
    return repository.editProfile(
      id: params.id,
      name: params.name,
      oldPassword: params.oldPassword,
      newPassword: params.newPassword,
      width: params.width,
      height: params.height,
    );
  }
}
