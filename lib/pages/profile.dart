import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_event.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_state.dart';
import 'package:regizai/features/bmi/presentation/cubit/bmi_cubit.dart';
// import removed
import 'package:regizai/login.dart';
import 'package:regizai/pages/edit_profile.dart';
import 'package:regizai/pages/forgot_password.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Konfirmasi Keluar"),
        content: const Text("Apakah Anda yakin ingin keluar dari akun ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal", style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthBloc>().add(LogoutEvent());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Login()),
                (route) => false,
              );
            },
            child: const Text("Keluar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Profil Pengguna"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note_rounded, color: AppColors.primary, size: 26),
            onPressed: () {
              final state = context.read<AuthBloc>().state;
              if (state is AuthenticatedState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfile(
                      id: state.user.id,
                      name: state.user.name,
                      width: state.user.width,
                      height: state.user.height,
                    ),
                  ),
                );
              }
            },
            tooltip: "Edit Profil",
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final user = state is AuthenticatedState ? state.user : null;
            final h = double.tryParse(user?.height ?? "170") ?? 170.0;
            final w = double.tryParse(user?.width ?? "65") ?? 65.0;
            final bbi = double.parse(((h - 100) - (0.1 * (h - 100))).toStringAsFixed(1));
            final calories = (30 * bbi).round();

            // Trigger BMI calculation
            context.read<BmiCubit>().calculate(w, h);

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              children: [
                // User Card
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppTheme.coloredShadow,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            user?.gender == "female"
                                ? "assets/img/female.png"
                                : "assets/img/male.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? "Pengguna Regizai",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user?.email ?? "user@regizai.com",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.85),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                user?.gender == "female" ? "Perempuan" : "Laki-laki",
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: "Berat Ideal (BBI)",
                        value: "$bbi",
                        unit: "kg",
                        icon: Icons.accessibility_new_rounded,
                        color: const Color(0xFF0284C7),
                        bgColor: const Color(0xFFE0F2FE),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        title: "Target Kalori",
                        value: "$calories",
                        unit: "kcal",
                        icon: Icons.local_fire_department_rounded,
                        color: const Color(0xFFEF4444),
                        bgColor: const Color(0xFFFEE2E2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                BlocBuilder<BmiCubit, BmiState>(
                  builder: (context, bmiState) {
                    final bmiData = bmiState is BmiCalculatedState ? bmiState.bmiData : null;
                    final statusColor = Color(bmiData?.colorHex ?? 0xFF10B981);

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                        boxShadow: AppTheme.softShadow,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(Icons.speed_rounded, color: statusColor, size: 24),
                              ),
                              const SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Status Indeks Massa Tubuh",
                                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    bmiData?.status ?? "Normal",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: statusColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "${bmiData?.bmi ?? 0.0}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                const Text(
                  "Data Fisik & Akun",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                    boxShadow: AppTheme.softShadow,
                  ),
                  child: Column(
                    children: [
                      _buildInfoTile(
                        icon: Icons.height_rounded,
                        title: "Tinggi Badan",
                        value: "${user?.height ?? '-'} cm",
                      ),
                      const Divider(height: 1, indent: 56, color: AppColors.border),
                      _buildInfoTile(
                        icon: Icons.monitor_weight_outlined,
                        title: "Berat Badan",
                        value: "${user?.width ?? '-'} kg",
                      ),
                      const Divider(height: 1, indent: 56, color: AppColors.border),
                      _buildInfoTile(
                        icon: Icons.cake_outlined,
                        title: "Tanggal Lahir",
                        value: user?.birth ?? "-",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                    boxShadow: AppTheme.softShadow,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit_rounded, color: AppColors.primary),
                        title: const Text("Ubah Biodata & Profil", style: TextStyle(fontWeight: FontWeight.w600)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        onTap: () {
                          if (user != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProfile(
                                  id: user.id,
                                  name: user.name,
                                  width: user.width,
                                  height: user.height,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      const Divider(height: 1, indent: 56, color: AppColors.border),
                      ListTile(
                        leading: const Icon(Icons.vpn_key_outlined, color: AppColors.primary),
                        title: const Text("Ganti / Reset Kata Sandi", style: TextStyle(fontWeight: FontWeight.w600)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                          );
                        },
                      ),
                      const Divider(height: 1, indent: 56, color: AppColors.border),
                      ListTile(
                        leading: const Icon(Icons.logout_rounded, color: Color(0xFFEF4444)),
                        title: const Text(
                          "Keluar dari Aplikasi",
                          style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFEF4444)),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFFEF4444)),
                        onTap: () => _confirmLogout(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 4),
              Text(unit, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({required IconData icon, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 14),
          Text(title, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
