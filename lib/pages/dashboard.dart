import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:regizai/camera/camera.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/articles/presentation/cubit/article_cubit.dart';
import 'package:regizai/features/articles/presentation/cubit/article_state.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_event.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_state.dart';
import 'package:regizai/features/journal/presentation/bloc/journal_bloc.dart';
// imports removed
import 'package:regizai/login.dart';
import 'package:regizai/pages/artikel.dart';
import 'package:regizai/pages/book.dart';
import 'package:regizai/pages/calculate.dart';
import 'package:regizai/pages/catatan.dart';
import 'package:regizai/pages/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentNavIndex = 0;

  String _getTimeGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 11) return "Selamat Pagi";
    if (hour < 15) return "Selamat Siang";
    if (hour < 18) return "Selamat Sore";
    return "Selamat Malam";
  }

  void _openCamera() async {
    try {
      final cameras = await availableCameras();
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => Camera(cameras: cameras)),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Camera(cameras: [])),
        );
      }
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              final user = authState is AuthenticatedState ? authState.user : null;
              final heightVal = double.tryParse(user?.height ?? "170") ?? 170.0;
              final bbiVal = (heightVal - 100) - (0.1 * (heightVal - 100));
              final dailyTargetCalories = (30 * bbiVal).round();

              return BlocBuilder<JournalBloc, JournalState>(
                builder: (context, journalState) {
                  final todayCalories = journalState is JournalLoadedState
                      ? journalState.todayCalories
                      : 0;
                  final remainingCalories = (dailyTargetCalories - todayCalories).clamp(0, 99999);
                  final progress = (todayCalories / (dailyTargetCalories > 0 ? dailyTargetCalories : 1))
                      .clamp(0.0, 1.0);

                  return RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: () async {
                      if (user != null) {
                        context.read<JournalBloc>().add(LoadJournalEvent(user.id));
                      }
                    },
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      children: [
                        // Top Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: AppTheme.softShadow,
                                    border: Border.all(
                                      color: AppColors.primary.withOpacity(0.2),
                                      width: 1.5,
                                    ),
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
                                const SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${_getTimeGreeting()},",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      user?.name ?? "Pengguna Regizai",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: AppTheme.softShadow,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.logout_rounded, color: AppColors.textSecondary, size: 22),
                                onPressed: _confirmLogout,
                                tooltip: "Keluar",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Hero Calorie Card
                        Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            gradient: AppColors.heroGradient,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: AppTheme.coloredShadow,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.local_fire_department_rounded, color: Color(0xFFFBBF24), size: 22),
                                      SizedBox(width: 8),
                                      Text(
                                        "Target Kalori Harian",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.18),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      DateFormat('dd MMM yyyy').format(DateTime.now()),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    "$todayCalories",
                                    style: const TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "/ $dailyTargetCalories kcal",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Sisa $remainingCalories kcal",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF34D399),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 10,
                                  backgroundColor: Colors.white.withOpacity(0.2),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    progress > 1.0 ? const Color(0xFFEF4444) : const Color(0xFF34D399),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildMacroBadge("Karbo", "45%", const Color(0xFFFBBF24)),
                                    Container(width: 1, height: 24, color: Colors.white.withOpacity(0.2)),
                                    _buildMacroBadge("Protein", "30%", const Color(0xFF38BDF8)),
                                    Container(width: 1, height: 24, color: Colors.white.withOpacity(0.2)),
                                    _buildMacroBadge("Lemak", "25%", const Color(0xFFF472B6)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Quick Actions
                        const Text(
                          "Fitur Utama",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildQuickActionCard(
                                title: "Scan Makanan",
                                subtitle: "Deteksi AI",
                                icon: Icons.camera_alt_rounded,
                                color: AppColors.primary,
                                bgColor: AppColors.primarySurface,
                                onTap: _openCamera,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildQuickActionCard(
                                title: "Kalkulator",
                                subtitle: "Hitung BMI",
                                icon: Icons.calculate_rounded,
                                color: const Color(0xFF0284C7),
                                bgColor: const Color(0xFFE0F2FE),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const Calculate()),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildQuickActionCard(
                                title: "Buku Gizi",
                                subtitle: "Katalog Bahan",
                                icon: Icons.menu_book_rounded,
                                color: const Color(0xFF10B981),
                                bgColor: const Color(0xFFD1FAE5),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const Books()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // Articles Carousel
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Artikel & Panduan Gizi",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const Artikel()),
                                );
                              },
                              child: const Text(
                                "Lihat Semua",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        BlocBuilder<ArticleCubit, ArticleState>(
                          builder: (context, articleState) {
                            if (articleState is ArticleLoaded) {
                              return CarouselSlider(
                                options: CarouselOptions(
                                  height: 220,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.92,
                                  autoPlayInterval: const Duration(seconds: 5),
                                ),
                                items: articleState.articles.map((article) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (_) => const Artikel()),
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: AppTheme.softShadow,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Stack(
                                              children: [
                                                Image.asset(
                                                  article.image,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.transparent,
                                                        Colors.black.withOpacity(0.85),
                                                      ],
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 16,
                                                  left: 16,
                                                  right: 16,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                        decoration: BoxDecoration(
                                                          color: AppColors.primary,
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Text(
                                                          article.category,
                                                          style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Text(
                                                        article.title,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        const SizedBox(height: 28),

                        // Catatan Banner
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border),
                            boxShadow: AppTheme.softShadow,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.primarySurface,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(Icons.note_alt_rounded, color: AppColors.primary, size: 26),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Catatan Gizi Harian",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Tinjau daftar konsumsi makanan dan histori nutrisi harian.",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.primary, size: 18),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Catatan(id: user?.id ?? "usr_01"),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Bottom Bar
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.home_rounded,
                label: "Beranda",
                isActive: _currentNavIndex == 0,
                onTap: () => setState(() => _currentNavIndex = 0),
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.menu_book_rounded,
                label: "Katalog",
                isActive: _currentNavIndex == 1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Books()),
                  );
                },
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.assignment_rounded,
                label: "Catatan",
                isActive: _currentNavIndex == 2,
                onTap: () {
                  final authState = context.read<AuthBloc>().state;
                  final uId = authState is AuthenticatedState ? authState.user.id : "usr_01";
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Catatan(id: uId)),
                  );
                },
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.person_rounded,
                label: "Profil",
                isActive: _currentNavIndex == 3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Profile()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroBadge(String title, String percent, Color dotColor) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor),
        ),
        const SizedBox(width: 6),
        Text(
          "$title $percent",
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
          boxShadow: AppTheme.softShadow,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.primary : AppColors.textMuted,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.primary : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
