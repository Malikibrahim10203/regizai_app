import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class CheckAuthStatusEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String gender;
  final String birth;
  final String width;
  final String height;

  const SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.birth,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [name, email, password, gender, birth, width, height];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  final String oldPassword;
  final String newPassword;

  const ForgotPasswordEvent({
    required this.email,
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [email, oldPassword, newPassword];
}

class LogoutEvent extends AuthEvent {}

class UpdateProfileEvent extends AuthEvent {
  final String id;
  final String name;
  final String oldPassword;
  final String newPassword;
  final String width;
  final String height;

  const UpdateProfileEvent({
    required this.id,
    required this.name,
    required this.oldPassword,
    required this.newPassword,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [id, name, oldPassword, newPassword, width, height];
}
