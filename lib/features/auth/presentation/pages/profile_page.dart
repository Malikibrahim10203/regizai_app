import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/app/config/routes/app_routes.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_event.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengguna')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = (state is AuthenticatedState) ? state.user : null;
          final name = user?.name ?? 'User RegizAI';
          final email = user?.email ?? 'user@regizai.com';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: AppTheme.primaryLight,
                        child: Text(
                          name.isNotEmpty ? name[0].toUpperCase() : 'U',
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppTheme.primaryDark),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                      Text(email, style: const TextStyle(color: AppTheme.textSub)),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ListTile(
                  leading: const Icon(Icons.edit_outlined, color: AppTheme.primaryGreen),
                  title: const Text('Ubah Profil'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.pushNamed(context, AppRoutes.editProfile),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.calculate_outlined, color: AppTheme.carbColor),
                  title: const Text('Kalkulator BMI'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.pushNamed(context, AppRoutes.bmiCalculator),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: AppTheme.fatColor),
                  title: const Text('Keluar', style: TextStyle(color: AppTheme.fatColor)),
                  onTap: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (r) => false);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
