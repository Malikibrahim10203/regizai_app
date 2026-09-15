import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/core/usecase/usecase.dart';
import 'package:regizai/features/auth/domain/usecases/edit_profile_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/login_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/logout_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/signup_usecase.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_event.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final LogoutUseCase logoutUseCase;
  final EditProfileUseCase editProfileUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.forgotPasswordUseCase,
    required this.getCurrentUserUseCase,
    required this.logoutUseCase,
    required this.editProfileUseCase,
  }) : super(AuthInitialState()) {
    on<CheckAuthStatusEvent>((event, emit) async {
      try {
        final user = await getCurrentUserUseCase(NoParams());
        if (user != null) {
          emit(AuthenticatedState(user));
        } else {
          emit(UnauthenticatedState());
        }
      } catch (_) {
        emit(UnauthenticatedState());
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final user = await loginUseCase(
          LoginParams(email: event.email, password: event.password),
        );
        emit(AuthenticatedState(user));
      } catch (e) {
        emit(AuthErrorState(e.toString().replaceAll("Exception: ", "")));
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final user = await signUpUseCase(
          SignUpParams(
            name: event.name,
            email: event.email,
            password: event.password,
            gender: event.gender,
            birth: event.birth,
            width: event.width,
            height: event.height,
          ),
        );
        emit(AuthenticatedState(user));
      } catch (e) {
        emit(AuthErrorState(e.toString().replaceAll("Exception: ", "")));
      }
    });

    on<ForgotPasswordEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final success = await forgotPasswordUseCase(
          ForgotPasswordParams(
            email: event.email,
            oldPassword: event.oldPassword,
            newPassword: event.newPassword,
          ),
        );
        if (success) {
          emit(AuthPasswordResetSuccessState());
        } else {
          emit(const AuthErrorState("Gagal mengatur ulang kata sandi"));
        }
      } catch (e) {
        emit(AuthErrorState(e.toString().replaceAll("Exception: ", "")));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await logoutUseCase(NoParams());
      emit(UnauthenticatedState());
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final updatedUser = await editProfileUseCase(
          EditProfileParams(
            id: event.id,
            name: event.name,
            oldPassword: event.oldPassword,
            newPassword: event.newPassword,
            width: event.width,
            height: event.height,
          ),
        );
        emit(AuthenticatedState(updatedUser));
      } catch (e) {
        emit(AuthErrorState(e.toString().replaceAll("Exception: ", "")));
      }
    });
  }
}
