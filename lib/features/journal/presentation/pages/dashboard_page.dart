import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/app/config/routes/app_routes.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/core/utils/date_formatter.dart';
import 'package:regizai/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:regizai/features/journal/presentation/widgets/calorie_summary_card.dart';
import 'package:regizai/features/journal/presentation/widgets/floating_nav_bar.dart';
import 'package:regizai/features/journal/presentation/widgets/macro_bar_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgSoft,
      extendBody: true,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.eco_rounded, color: AppTheme.primaryGreen, size: 20),
            ),
            const SizedBox(width: 8),
            const Text(
              'RegizAI',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
                color: AppTheme.textMain,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.borderSubtle),
              ),
              child: const Icon(Icons.person_outline_rounded, color: AppTheme.textMain, size: 20),
            ),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
          final totalCalories = (state is JournalLoadedState) ? state.todayCalories.toDouble() : 780.0;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Date & Greeting
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormatter.formatIndonesian(DateTime.now()),
                          style: const TextStyle(fontSize: 13, color: AppTheme.textSub, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Halo, Sahabat Sehat! 👋',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppTheme.textMain, letterSpacing: -0.5),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryExtraLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.primaryLight),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.bolt_rounded, color: AppTheme.primaryGreen, size: 16),
                          SizedBox(width: 4),
                          Text('Fit Hari Ini', style: TextStyle(color: AppTheme.primaryDark, fontSize: 11, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Hero Calorie Card
                CalorieSummaryCard(consumed: totalCalories, target: 2150.0),
                const SizedBox(height: 22),
                // Detailed Macro Intake Bento Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppTheme.bentoCardDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Keseimbangan Nutrisi',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.textMain),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Target Harian', style: TextStyle(fontSize: 11, color: AppTheme.textSub, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const MacroBarWidget(label: 'Karbohidrat', current: 145, target: 275, color: AppTheme.carbColor),
                      const SizedBox(height: 12),
                      const MacroBarWidget(label: 'Protein', current: 62, target: 95, color: AppTheme.proteinColor),
                      const SizedBox(height: 12),
                      const MacroBarWidget(label: 'Lemak', current: 32, target: 65, color: AppTheme.fatColor),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Bento Quick Action Grid Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Akses Cepat & Layanan', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.textMain)),
                    Text('4 Fitur', style: TextStyle(fontSize: 12, color: AppTheme.textSub, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 12),
                // Bento Quick Action Grid
                Row(
                  children: [
                    Expanded(
                      child: _BentoActionCard(
                        icon: Icons.camera_alt_rounded,
                        title: 'Scan Makanan',
                        subtitle: 'AI Recognition',
                        gradientColors: const [Color(0xFF059669), Color(0xFF10B981)],
                        onTap: () => Navigator.pushNamed(context, AppRoutes.cameraScanner),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _BentoActionCard(
                        icon: Icons.menu_book_rounded,
                        title: 'Katalog Gizi',
                        subtitle: 'FatSecret Live',
                        gradientColors: const [Color(0xFF2563EB), Color(0xFF3B82F6)],
                        badgeText: 'LIVE',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.foodCatalog),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _BentoActionCard(
                        icon: Icons.calculate_rounded,
                        title: 'Kalkulator BMI',
                        subtitle: 'Status Berat Badan',
                        gradientColors: const [Color(0xFFD97706), Color(0xFFF59E0B)],
                        onTap: () => Navigator.pushNamed(context, AppRoutes.bmiCalculator),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _BentoActionCard(
                        icon: Icons.article_rounded,
                        title: 'Artikel Nutrisi',
                        subtitle: 'Edukasi Pola Makan',
                        gradientColors: const [Color(0xFF7C3AED), Color(0xFF8B5CF6)],
                        onTap: () => Navigator.pushNamed(context, AppRoutes.articles),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: FloatingNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, AppRoutes.journal);
          if (index == 2) Navigator.pushNamed(context, AppRoutes.foodCatalog);
          if (index == 3) Navigator.pushNamed(context, AppRoutes.profile);
        },
        onScanTap: () => Navigator.pushNamed(context, AppRoutes.cameraScanner),
      ),
    );
  }
}

class _BentoActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final String? badgeText;
  final VoidCallback onTap;

  const _BentoActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    this.badgeText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.bentoCardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: gradientColors.last.withValues(alpha: 0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 22),
                ),
                if (badgeText != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFA5D6A7)),
                    ),
                    child: Text(
                      badgeText!,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  )
                else
                  const Icon(Icons.arrow_outward_rounded, size: 18, color: AppTheme.textSub),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppTheme.textMain),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppTheme.textSub),
            ),
          ],
        ),
      ),
    );
  }
}
