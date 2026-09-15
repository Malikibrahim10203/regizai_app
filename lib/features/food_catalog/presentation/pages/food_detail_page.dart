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
            portion: '1 porsi',
            description: 'Makanan kaya nutrisi seimbang untuk menjaga kebugaran tubuh.',
          );

    final isFatSecret =
        f.description.contains('FatSecret') || f.vitamins.contains('FatSecret');

    return Scaffold(
      appBar: AppBar(title: Text(f.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                f.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: AppTheme.primaryLight,
                  child: const Icon(Icons.fastfood, size: 64, color: AppTheme.primaryGreen),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    f.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                if (isFatSecret)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFA5D6A7)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.verified, size: 14, color: Color(0xFF2E7D32)),
                        SizedBox(width: 4),
                        Text(
                          'FatSecret API',
                          style: TextStyle(
                            color: Color(0xFF2E7D32),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(f.category, style: const TextStyle(fontSize: 14, color: AppTheme.textSub)),
            const SizedBox(height: 16),
            // Macro nutrients
            Container(
              padding: const EdgeInsets.all(16),
              decoration: AppTheme.modernCardDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NutrientItem(label: 'Kalori', value: '${f.calories} kkal', color: AppTheme.calorieColor),
                  _NutrientItem(label: 'Protein', value: '${f.protein.toStringAsFixed(1)}g', color: AppTheme.proteinColor),
                  _NutrientItem(label: 'Lemak', value: '${f.fat.toStringAsFixed(1)}g', color: AppTheme.fatColor),
                  _NutrientItem(label: 'Karbo', value: '${f.carbs.toStringAsFixed(1)}g', color: AppTheme.carbColor),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Portion & Serving Info
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.scale_rounded, color: AppTheme.primaryGreen, size: 20),
                  const SizedBox(width: 10),
                  const Text('Ukuran Porsi: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Expanded(
                    child: Text(
                      f.portion.isNotEmpty ? f.portion : '1 porsi (100g)',
                      style: const TextStyle(color: AppTheme.textMain, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            if (f.vitamins.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F8E9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFC8E6C9)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.health_and_safety_outlined, color: Color(0xFF2E7D32), size: 20),
                    const SizedBox(width: 10),
                    const Text('Nutrisi Ekstra: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1B5E20))),
                    Expanded(
                      child: Text(
                        f.vitamins,
                        style: const TextStyle(color: Color(0xFF2E7D32), fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            const Text('Deskripsi & Manfaat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(f.description, style: const TextStyle(fontSize: 14, height: 1.5, color: AppTheme.textSub)),
            const SizedBox(height: 20),
            // FatSecret API Attribution
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.verified_user_rounded, color: Color(0xFF2E7D32), size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Data nutrisi terverifikasi resmi melalui FatSecret Platform API',
                      style: TextStyle(fontSize: 12, color: Color(0xFF616161), fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NutrientItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _NutrientItem({ required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSub)),
      ],
    );
  }
}
