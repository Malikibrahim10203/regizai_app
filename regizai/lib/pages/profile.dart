import 'package:flutter/material.dart';
import 'package:regizai/event/event_pref.dart';
import 'package:regizai/login.dart';
import 'package:regizai/mock/offline_service.dart';
import 'package:regizai/model/user.dart';
import 'package:regizai/pages/edit_profile.dart';
import 'package:regizai/pages/forgot_password.dart';
import 'package:regizai/theme/app_theme.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? _user;
  double _bbi = 0.0;
  int _calories = 0;
  Map<String, dynamic>? _bmiData;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    final user = await OfflineService.getCurrentUser();
    final heightVal = double.tryParse(user.height ?? "170") ?? 170.0;
    final weightVal = double.tryParse(user.width ?? "65") ?? 65.0;

    // Formula SRS
    final bbiVal = (heightVal - 100) - (0.1 * (heightVal - 100));
    final calVal = (30 * bbiVal).round();
    final bmiRes = OfflineService.calculateBmi(weightVal, heightVal);

    if (mounted) {
      setState(() {
        _user = user;
        _bbi = double.parse(bbiVal.toStringAsFixed(1));
        _calories = calVal;
        _bmiData = bmiRes;
      });
    }
  }

  void _confirmLogout() {
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
              EventPref.clear();
              OfflineService.logout();
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
    final statusColor = Color(_bmiData?['color'] ?? 0xFF10B981);

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
              if (_user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfile(
                      id: _user!.id,
                      name: _user!.name,
                      width: _user!.width,
                      height: _user!.height,
                    ),
                  ),
                ).then((_) => _loadProfile());
              }
            },
            tooltip: "Edit Profil",
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async => _loadProfile(),
          child: ListView(
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
                          _user?.gender == "female"
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
                            _user?.name ?? "Pengguna Regizai",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _user?.email ?? "user@regizai.com",
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
                              _user?.gender == "female" ? "Perempuan" : "Laki-laki",
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

              // 3 Health Metric Cards
              Row(
                children: [
                  // BBI
                  Expanded(
                    child: _buildStatCard(
                      title: "Berat Ideal (BBI)",
                      value: "$_bbi",
                      unit: "kg",
                      icon: Icons.accessibility_new_rounded,
                      color: const Color(0xFF0284C7),
                      bgColor: const Color(0xFFE0F2FE),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Target Kalori
                  Expanded(
                    child: _buildStatCard(
                      title: "Target Kalori",
                      value: "$_calories",
                      unit: "kcal",
                      icon: Icons.local_fire_department_rounded,
                      color: const Color(0xFFEF4444),
                      bgColor: const Color(0xFFFEE2E2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // BMI Card
              Container(
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
                              _bmiData?['status'] ?? "Normal",
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
                      "${_bmiData?['bmi'] ?? 0.0}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Detailed Profile Info List
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
                      value: "${_user?.height ?? '-'} cm",
                    ),
                    const Divider(height: 1, indent: 56, color: AppColors.border),
                    _buildInfoTile(
                      icon: Icons.monitor_weight_outlined,
                      title: "Berat Badan",
                      value: "${_user?.width ?? '-'} kg",
                    ),
                    const Divider(height: 1, indent: 56, color: AppColors.border),
                    _buildInfoTile(
                      icon: Icons.cake_outlined,
                      title: "Tanggal Lahir",
                      value: _user?.birth ?? "-",
                    ),
                    const Divider(height: 1, indent: 56, color: AppColors.border),
                    _buildInfoTile(
                      icon: Icons.lock_outline_rounded,
                      title: "Keamanan Sandi",
                      value: "••••••••",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Actions: Edit Profile & Forgot Password & Logout
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
                        if (_user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProfile(
                                id: _user!.id,
                                name: _user!.name,
                                width: _user!.width,
                                height: _user!.height,
                              ),
                            ),
                          ).then((_) => _loadProfile());
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
                      onTap: _confirmLogout,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
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
