import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/app/config/routes/app_routes.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_event.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgSoft,
      appBar: AppBar(
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note_rounded, color: AppTheme.primaryDark),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.editProfile),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = (state is AuthenticatedState) ? state.user : null;
          final name = user?.name.isNotEmpty == true ? user!.name : 'Malik Ibrahim';
          final email = user?.email.isNotEmpty == true ? user!.email : 'malik@regizai.com';

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Hero Health Pass Card
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: AppTheme.emeraldHeroGradient,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3D065F46),
                        blurRadius: 24,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Avatar
                      Stack(
                        children: [
                          Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              color: const Color(0xFFD1FAE5),
                            ),
                            child: Center(
                              child: Text(
                                name.isNotEmpty ? name[0].toUpperCase() : 'U',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF047857),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF59E0B),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.star_rounded, color: Colors.white, size: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 18),
                      // User Info & Status
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              email,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFFD1FAE5),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.verified_rounded, color: Color(0xFF6EE7B7), size: 13),
                                  SizedBox(width: 5),
                                  Text(
                                    'Active Health Enthusiast',
                                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                // 2. 4 Body Metrics Bento Grid
                const Text(
                  'Kondisi Tubuh & Target',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.textMain),
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Expanded(
                      child: _BentoStatCard(
                        icon: Icons.scale_rounded,
                        label: 'Berat Badan',
                        value: '68',
                        unit: 'kg',
                        color: Color(0xFF059669),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _BentoStatCard(
                        icon: Icons.height_rounded,
                        label: 'Tinggi Badan',
                        value: '175',
                        unit: 'cm',
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Expanded(
                      child: _BentoStatCard(
                        icon: Icons.speed_rounded,
                        label: 'Status BMI',
                        value: '22.2',
                        unit: 'Normal',
                        color: Color(0xFF10B981),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _BentoStatCard(
                        icon: Icons.local_fire_department_rounded,
                        label: 'Target Kalori',
                        value: '2.150',
                        unit: 'kkal',
                        color: Color(0xFFD97706),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // 3. Settings & Features Bento Groups
                const Text(
                  'Pengaturan & Layanan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.textMain),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: AppTheme.bentoCardDecoration(),
                  child: Column(
                    children: [
                      _ProfileMenuItem(
                        icon: Icons.person_outline_rounded,
                        iconColor: AppTheme.primaryGreen,
                        title: 'Ubah Data Profil',
                        subtitle: 'Nama, email, dan biodata fisik',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.editProfile),
                      ),
                      const Divider(height: 1, indent: 64),
                      _ProfileMenuItem(
                        icon: Icons.calculate_outlined,
                        iconColor: AppTheme.carbColor,
                        title: 'Kalkulator BMI & Berat Ideal',
                        subtitle: 'Hitung indeks massa tubuh Anda',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.bmiCalculator),
                      ),
                      const Divider(height: 1, indent: 64),
                      _ProfileMenuItem(
                        icon: Icons.menu_book_rounded,
                        iconColor: const Color(0xFF7C3AED),
                        title: 'Katalog Gizi FatSecret',
                        subtitle: 'Database makanan resmi online',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.foodCatalog),
                      ),
                      const Divider(height: 1, indent: 64),
                      _ProfileMenuItem(
                        icon: Icons.notifications_none_rounded,
                        iconColor: AppTheme.calorieColor,
                        title: 'Pengingat Jadwal Makan',
                        subtitle: 'Sarapan, makan siang, & malam',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Pengingat jadwal makan otomatis aktif!'),
                              backgroundColor: AppTheme.primaryGreen,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // 4. Logout Button Card
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                        title: const Text('Konfirmasi Keluar', style: TextStyle(fontWeight: FontWeight.w800)),
                        content: const Text('Apakah Anda yakin ingin keluar dari akun RegizAI?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Batal', style: TextStyle(color: AppTheme.textSub)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF43F5E),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              Navigator.pop(ctx);
                              context.read<AuthBloc>().add(LogoutEvent());
                              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (r) => false);
                            },
                            child: const Text('Ya, Keluar'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F2),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFFECDD3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.logout_rounded, color: Color(0xFFE11D48), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Keluar dari Akun',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFE11D48),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BentoStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _BentoStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.bentoCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSub),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: color, letterSpacing: -0.5),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textSub),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppTheme.textMain),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 11, color: AppTheme.textSub),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppTheme.textSub),
      onTap: onTap,
    );
  }
}
