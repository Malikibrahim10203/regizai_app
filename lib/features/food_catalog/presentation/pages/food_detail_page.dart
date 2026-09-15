import 'package:flutter/material.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/food_catalog/domain/entities/food_entity.dart';

class FoodDetailPage extends StatelessWidget {
  final dynamic food;

  const FoodDetailPage({Key? key, required this.food}) : super(key: key);

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
            Text(f.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(f.category, style: const TextStyle(fontSize: 14, color: AppTheme.textSub)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: AppTheme.modernCardDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NutrientItem(label: 'Kalori', value: '${f.calories} kkal', color: AppTheme.calorieColor),
                  _NutrientItem(label: 'Protein', value: '${f.protein.toInt()}g', color: AppTheme.proteinColor),
                  _NutrientItem(label: 'Lemak', value: '${f.fat.toInt()}g', color: AppTheme.fatColor),
                  _NutrientItem(label: 'Karbo', value: '${f.carbs.toInt()}g', color: AppTheme.carbColor),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Deskripsi & Manfaat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(f.description, style: const TextStyle(fontSize: 14, height: 1.5, color: AppTheme.textSub)),
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

  const _NutrientItem({required this.label, required this.value, required this.color});

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
