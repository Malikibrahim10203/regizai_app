import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/app/config/routes/app_routes.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/core/utils/date_formatter.dart';
import 'package:regizai/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:regizai/features/journal/presentation/widgets/calorie_summary_card.dart';
import 'package:regizai/features/journal/presentation/widgets/macro_bar_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgSoft,
      appBar: AppBar(
        title: const Text('RegizAI Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppTheme.textMain),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
          ),
        ],
      ),
      body: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
          final totalCalories = (state is JournalLoadedState) ? state.todayCalories.toDouble() : 780.0;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormatter.formatIndonesian(DateTime.now()),
                  style: const TextStyle(fontSize: 14, color: AppTheme.textSub, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Halo, Selamat Sehat!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.textMain),
                ),
                const SizedBox(height: 16),
                CalorieSummaryCard(consumed: totalCalories, target: 2150.0),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: AppTheme.modernCardDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Asupan Makronutrien', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textMain)),
                      SizedBox(height: 14),
                      MacroBarWidget(label: 'Karbohidrat', current: 145, target: 275, color: AppTheme.carbColor),
                      SizedBox(height: 12),
                      MacroBarWidget(label: 'Protein', current: 62, target: 95, color: AppTheme.proteinColor),
                      SizedBox(height: 12),
                      MacroBarWidget(label: 'Lemak', current: 32, target: 65, color: AppTheme.fatColor),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Akses Cepat Fitur', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textMain)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _QuickActionCard(
                        icon: Icons.camera_alt_rounded,
                        title: 'Scan Makanan',
                        color: AppTheme.primaryGreen,
                        onTap: () => Navigator.pushNamed(context, AppRoutes.cameraScanner),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickActionCard(
                        icon: Icons.book_outlined,
                        title: 'Katalog Gizi',
                        color: AppTheme.carbColor,
                        onTap: () => Navigator.pushNamed(context, AppRoutes.foodCatalog),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _QuickActionCard(
                        icon: Icons.calculate_outlined,
                        title: 'Cek BMI',
                        color: AppTheme.calorieColor,
                        onTap: () => Navigator.pushNamed(context, AppRoutes.bmiCalculator),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickActionCard(
                        icon: Icons.article_outlined,
                        title: 'Artikel Gizi',
                        color: Colors.purple,
                        onTap: () => Navigator.pushNamed(context, AppRoutes.articles),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppTheme.primaryGreen,
        unselectedItemColor: AppTheme.textSub,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, AppRoutes.journal);
          if (index == 2) Navigator.pushNamed(context, AppRoutes.cameraScanner);
          if (index == 3) Navigator.pushNamed(context, AppRoutes.foodCatalog);
          if (index == 4) Navigator.pushNamed(context, AppRoutes.profile);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border_rounded), label: 'Catatan'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt_outlined), label: 'Scan AI'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Katalog'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: AppTheme.modernCardDecoration(),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.12),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.textMain)),
          ],
        ),
      ),
    );
  }
}
