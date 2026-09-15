import 'package:flutter/material.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/food_catalog/domain/entities/food_entity.dart';

class FoodItemCard extends StatelessWidget {
  final FoodEntity food;
  final VoidCallback onTap;

  const FoodItemCard({Key? key, required this.food, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: AppTheme.modernCardDecoration(),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                food.image,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 64,
                  height: 64,
                  color: AppTheme.primaryLight,
                  child: const Icon(Icons.fastfood, color: AppTheme.primaryGreen),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                  const SizedBox(height: 4),
                  Text('${food.calories} kkal • ${food.category}', style: const TextStyle(fontSize: 13, color: AppTheme.textSub)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppTheme.textSub),
          ],
        ),
      ),
    );
  }
}
