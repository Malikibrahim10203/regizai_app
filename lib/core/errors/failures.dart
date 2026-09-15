import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Terjadi kesalahan pada server.']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Gagal memuat data lokal.']) : super(message);
}

class AuthFailure extends Failure {
  const AuthFailure([String message = 'Autentikasi gagal.']) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}
