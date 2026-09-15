import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_event.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_state.dart';
import 'package:regizai/features/auth/presentation/widgets/auth_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordResetSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kata sandi berhasil diperbarui.'),
              backgroundColor: AppTheme.primaryGreen,
            ),
          );
          Navigator.pop(context);
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppTheme.fatColor,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Lupa Kata Sandi')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(28.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Masukkan email dan kata sandi baru untuk mengatur ulang akun Anda.',
                  style: TextStyle(color: AppTheme.textSub, fontSize: 14),
                ),
                const SizedBox(height: 24),
                AuthTextField(
                  controller: _emailController,
                  hintText: 'Email Anda',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || v.isEmpty) ? 'Email wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _oldPasswordController,
                  hintText: 'Kata Sandi Lama',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _newPasswordController,
                  hintText: 'Kata Sandi Baru',
                  prefixIcon: Icons.lock_reset,
                  obscureText: true,
                  validator: (v) => (v != null && v.length < 6) ? 'Minimal 6 karakter' : null,
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.read<AuthBloc>().add(
                            ForgotPasswordEvent(
                              email: _emailController.text.trim(),
                              oldPassword: _oldPasswordController.text.trim(),
                              newPassword: _newPasswordController.text.trim(),
                            ),
                          );
                    }
                  },
                  child: const Text('Perbarui Kata Sandi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
