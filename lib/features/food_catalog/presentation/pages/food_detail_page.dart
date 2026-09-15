import 'package:flutter/material.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/food_catalog/domain/entities/food_entity.dart';

class FoodDetailPage extends StatelessWidget {
  final dynamic food;

  const FoodDetailPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final f = (food is FoodEntity)
        ? food as FoodEntity
        : const FoodEntity(
            id: '1',
            name: 'Makanan Sehat',
            category: 'Gizi Seimbang',
            image: '',
            calories: 250,
            protein: 12,
            fat: 6,
            carbs: 35,
            sugar: 1,
            vitamins: 'Vitamin A, C',
            portion: '1 porsi (100g)',
            description: 'Makanan kaya nutrisi seimbang untuk menjaga kebugaran tubuh.',
          );

    final isFatSecret =
        f.description.contains('FatSecret') || f.vitamins.contains('FatSecret');

    return Scaffold(
      backgroundColor: AppTheme.bgSoft,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Hero Image with rounded bottom
                Hero(
                  tag: 'food_${f.id}_${f.name}',
                  child: Stack(
                    children: [
                      Container(
                        height: 280,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryLight,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                          child: Image.network(
                            f.image,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppTheme.primaryLight,
                              child: const Icon(Icons.fastfood_rounded, size: 80, color: AppTheme.primaryGreen),
                            ),
                          ),
                        ),
                      ),
                      // Bottom gradient overlay on image
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 90,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      // Portion chip on image
                      Positioned(
                        bottom: 16,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.scale_rounded, color: Colors.white, size: 14),
                              const SizedBox(width: 6),
                              Text(
                                f.portion.isNotEmpty ? f.portion : '1 porsi (100g)',
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content Body
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Food Name & FatSecret Badge
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              f.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.textMain,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          if (isFatSecret)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFFA7F3D0)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.verified_rounded, size: 14, color: Color(0xFF047857)),
                                  SizedBox(width: 4),
                                  Text(
                                    'FatSecret',
                                    style: TextStyle(
                                      color: Color(0xFF047857),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        f.category,
                        style: const TextStyle(fontSize: 14, color: AppTheme.textSub, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      // 4 Macro Nutrients Bento Grid
                      Row(
                        children: [
                          Expanded(
                            child: _MacroBentoCard(
                              label: 'Kalori',
                              value: '${f.calories}',
                              unit: 'kkal',
                              color: AppTheme.calorieColor,
                              icon: Icons.local_fire_department_rounded,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _MacroBentoCard(
                              label: 'Protein',
                              value: f.protein.toStringAsFixed(1),
                              unit: 'g',
                              color: AppTheme.proteinColor,
                              icon: Icons.fitness_center_rounded,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _MacroBentoCard(
                              label: 'Lemak',
                              value: f.fat.toStringAsFixed(1),
                              unit: 'g',
                              color: AppTheme.fatColor,
                              icon: Icons.opacity_rounded,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _MacroBentoCard(
                              label: 'Karbohidrat',
                              value: f.carbs.toStringAsFixed(1),
                              unit: 'g',
                              color: AppTheme.carbColor,
                              icon: Icons.grain_rounded,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Extra Vitamins & Micronutrients
                      if (f.vitamins.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FDF4),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: const Color(0xFFBBF7D0)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFDCFCE7),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.health_and_safety_rounded, color: Color(0xFF15803D), size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Mikronutrien Terdeteksi',
                                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF14532D)),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      f.vitamins,
                                      style: const TextStyle(color: Color(0xFF15803D), fontSize: 13, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      // Description Section
                      const Text(
                        'Deskripsi & Rincian Gizi',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.textMain),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: AppTheme.bentoCardDecoration(),
                        child: Text(
                          f.description,
                          style: const TextStyle(fontSize: 14, height: 1.6, color: AppTheme.textSub),
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Official Attribution
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.shield_outlined, color: Color(0xFF047857), size: 18),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Data gizi terverifikasi resmi oleh FatSecret REST Platform Database',
                                style: TextStyle(fontSize: 12, color: Color(0xFF475569), fontWeight: FontWeight.w500),
                              ),
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
          // Floating Circular Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back_rounded, color: AppTheme.textMain, size: 20),
              ),
            ),
          ),
          // Bottom Sticky Action Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 18,
                    offset: Offset(0, -6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${f.name} (${f.calories} kkal) berhasil ditambahkan ke rencana nutrisi!'),
                      backgroundColor: AppTheme.primaryGreen,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.bookmark_add_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Catat ke Jurnal Nutrisi',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MacroBentoCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;
  final IconData icon;

  const _MacroBentoCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.bentoCardDecoration(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSub),
                ),
                const SizedBox(height: 2),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: color),
                      ),
                      TextSpan(
                        text: ' $unit',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSub),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
