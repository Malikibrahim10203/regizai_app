import 'package:flutter/material.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/food_catalog/domain/entities/food_entity.dart';

class FoodItemCard extends StatelessWidget {
  final FoodEntity food;
  final VoidCallback onTap;

  const FoodItemCard({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isFatSecret =
        food.description.contains('FatSecret') || food.vitamins.contains('FatSecret');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: AppTheme.bentoCardDecoration(),
        child: Row(
          children: [
            // Food Image with rounded border and subtle shadow
            Hero(
              tag: 'food_${food.id}_${food.name}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.network(
                    food.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppTheme.primaryLight,
                      child: const Icon(Icons.fastfood_rounded, color: AppTheme.primaryGreen, size: 36),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Food Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          food.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textMain,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isFatSecret)
                        Container(
                          margin: const EdgeInsets.only(left: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFECFDF5),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFA7F3D0)),
                          ),
                          child: const Text(
                            'FatSecret',
                            style: TextStyle(
                              color: Color(0xFF065F46),
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Portion Tag
                  Row(
                    children: [
                      const Icon(Icons.scale_rounded, size: 13, color: AppTheme.textSub),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          food.portion.isNotEmpty ? food.portion : food.category,
                          style: const TextStyle(fontSize: 12, color: AppTheme.textSub, fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Pop-out Calorie Badge & Macro overview
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBEB),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFFDE68A)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.local_fire_department_rounded, size: 13, color: Color(0xFFD97706)),
                            const SizedBox(width: 3),
                            Text(
                              '${food.calories} kkal',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFB45309),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'P: ${food.protein.toInt()}g • L: ${food.fat.toInt()}g • K: ${food.carbs.toInt()}g',
                        style: const TextStyle(fontSize: 11, color: AppTheme.textSub, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppTheme.textSub),
            ),
          ],
        ),
      ),
    );
  }
}
